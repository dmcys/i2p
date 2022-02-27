package net.i2p.router.transport.udp;

import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import com.southernstorm.noise.protocol.CipherState;

import net.i2p.data.ByteArray;
import net.i2p.data.DataFormatException;
import net.i2p.data.DataHelper;
import net.i2p.data.Hash;
import net.i2p.data.router.RouterInfo;
import net.i2p.data.SessionKey;
import net.i2p.data.i2np.I2NPMessage;
import net.i2p.data.i2np.I2NPMessageException;
import net.i2p.data.i2np.I2NPMessageImpl;
import net.i2p.router.RouterContext;
import static net.i2p.router.transport.udp.SSU2Util.*;
import net.i2p.util.HexDump;
import net.i2p.util.Log;

/**
 * Contain all of the state about a UDP connection to a peer.
 * This is instantiated only after a connection is fully established.
 *
 * Public only for UI peers page. Not a public API, not for external use.
 *
 * SSU2 only.
 *
 * @since 0.9.54
 */
public class PeerState2 extends PeerState implements SSU2Payload.PayloadCallback {
    private final long _sendConnID;
    private final long _rcvConnID;
    private final AtomicInteger _packetNumber = new AtomicInteger();
    private final CipherState _sendCha;
    private final CipherState _rcvCha;
    private final byte[] _sendHeaderEncryptKey1;
    private final byte[] _rcvHeaderEncryptKey1;
    private final byte[] _sendHeaderEncryptKey2;
    private final byte[] _rcvHeaderEncryptKey2;
    private final SSU2Bitfield _receivedMessages;
    private final SSU2Bitfield _ackedMessages;

    public static final int MIN_MTU = 1280;

    /**
     *  @param rtt from the EstablishState, or 0 if not available
     */
    public PeerState2(RouterContext ctx, UDPTransport transport,
                     InetSocketAddress remoteAddress, Hash remotePeer, boolean isInbound, int rtt,
                     CipherState sendCha, CipherState rcvCha, long sendID, long rcvID,
                     byte[] sendHdrKey1, byte[] sendHdrKey2, byte[] rcvHdrKey2) {
        super(ctx, transport, remoteAddress, remotePeer, isInbound, rtt);
        _sendConnID = sendID;
        _rcvConnID = rcvID;
        _sendCha = sendCha;
        _rcvCha = rcvCha;
        _sendHeaderEncryptKey1 = sendHdrKey1;
        _rcvHeaderEncryptKey1 = transport.getSSU2StaticIntroKey();
        _sendHeaderEncryptKey2 = sendHdrKey2;
        _rcvHeaderEncryptKey2 = rcvHdrKey2;
        _receivedMessages = new SSU2Bitfield(256, 0);
        _ackedMessages = new SSU2Bitfield(256, 0);
    }

    // SSU 1 overrides

    @Override
    public int getVersion() { return 2; }

    /**
     *  how much payload data can we shove in there?
     *  Does NOT leave any room for acks, we'll fit them in when we can.
     *  This is 5 bytes too low for first or only fragment.
     *
     *  @return MTU - 68 (IPv4), MTU - 88 (IPv6)
     */
    @Override
    int fragmentSize() {
        // 20 + 8 + 16 + 3 + 5 + 16 = 68 (IPv4)
        // 40 + 8 + 16 + 3 + 5 + 16 = 88 (IPv6)
        return _mtu -
               (_remoteIP.length == 4 ? PacketBuilder2.MIN_DATA_PACKET_OVERHEAD : PacketBuilder2.MIN_IPV6_DATA_PACKET_OVERHEAD) -
               DATA_FOLLOWON_EXTRA_SIZE; // Followon fragment block overhead (5)
    }

    /**
     *  Packet overhead
     *  Does NOT leave any room for acks, we'll fit them in when we can.
     *  This is 5 bytes too high for first or only fragment.
     *
     *  @return 68 (IPv4), 88 (IPv6)
     */
    @Override
    int fragmentOverhead() {
        // 20 + 8 + 16 + 3 + 5 + 16 = 68 (IPv4)
        // 40 + 8 + 16 + 3 + 5 + 16 = 88 (IPv6)
        return (_remoteIP.length == 4 ? PacketBuilder2.MIN_DATA_PACKET_OVERHEAD : PacketBuilder2.MIN_IPV6_DATA_PACKET_OVERHEAD) +
               DATA_FOLLOWON_EXTRA_SIZE; // Followon fragment block overhead (5)
    }

    // SSU 1 unsupported things

    @Override
    void setCurrentMACKey(SessionKey key) { throw new UnsupportedOperationException(); }
    @Override
    void setCurrentCipherKey(SessionKey key) { throw new UnsupportedOperationException(); }
    @Override
    List<Long> getCurrentFullACKs() { throw new UnsupportedOperationException(); }
    @Override
    List<Long> getCurrentResendACKs() { throw new UnsupportedOperationException(); }
    @Override
    void removeACKMessage(Long messageId) { throw new UnsupportedOperationException(); }
    @Override
    void fetchPartialACKs(List<ACKBitfield> rv) { throw new UnsupportedOperationException(); }

    // SSU 2 things

    long getNextPacketNumber() { return _packetNumber.incrementAndGet(); }
    long getSendConnID() { return _sendConnID; }
    long getRcvConnID() { return _rcvConnID; }
    /** caller must sync on returned object when encrypting */
    CipherState getSendCipher() { return _sendCha; }
    byte[] getSendHeaderEncryptKey1() { return _sendHeaderEncryptKey1; }
    byte[] getRcvHeaderEncryptKey1() { return _rcvHeaderEncryptKey1; }
    byte[] getSendHeaderEncryptKey2() { return _sendHeaderEncryptKey2; }
    byte[] getRcvHeaderEncryptKey2() { return _rcvHeaderEncryptKey2; }
    SSU2Bitfield getReceivedMessages() { return _receivedMessages; }
    SSU2Bitfield getAckedMessages() { return _ackedMessages; }

    void receivePacket(UDPPacket packet) {
        DatagramPacket dpacket = packet.getPacket();
        byte[] data = dpacket.getData();
        int off = dpacket.getOffset();
        int len = dpacket.getLength();
        try {
            if (len < MIN_DATA_LEN) {
                if (_log.shouldWarn())
                    _log.warn("Inbound packet too short " + len + " on " + this);
                return;
            }
            SSU2Header.Header header = SSU2Header.trialDecryptShortHeader(packet, _rcvHeaderEncryptKey1, _rcvHeaderEncryptKey2);
            if (header == null) {
                if (_log.shouldWarn())
                    _log.warn("bad data header on " + this);
                return;
            }
            if (header.getDestConnID() != _rcvConnID) {
                if (_log.shouldWarn())
                    _log.warn("bad Dest Conn id " + header.getDestConnID() + " on " + this);
                return;
            }
            if (header.getType() != DATA_FLAG_BYTE) {
                if (_log.shouldWarn())
                    _log.warn("bad data pkt type " + (header.getType() & 0xff) + " on " + this);
                return;
            }
            long n = header.getPacketNumber();
            SSU2Header.acceptTrialDecrypt(packet, header);
            synchronized (_rcvCha) {
                _rcvCha.setNonce(n);
                // decrypt in-place
                _rcvCha.decryptWithAd(header.data, data, off + SHORT_HEADER_SIZE, data, off + SHORT_HEADER_SIZE, len - SHORT_HEADER_SIZE);
                if (_receivedMessages.set(n)) {
                    if (_log.shouldWarn())
                        _log.warn("dup pkt rcvd " + n + " on " + this);
                    return;
                }
            }
            int payloadLen = len - (SHORT_HEADER_SIZE + MAC_LEN);
            processPayload(data, off + SHORT_HEADER_SIZE, payloadLen);
            packetReceived(payloadLen);
        } catch (GeneralSecurityException gse) {
            if (_log.shouldWarn())
                _log.warn("Bad encrypted packet:\n" + HexDump.dump(data, off, len), gse);
        } catch (IndexOutOfBoundsException ioobe) {
            if (_log.shouldWarn())
                _log.warn("Bad encrypted packet:\n" + HexDump.dump(data, off, len), ioobe);
        } finally {
            packet.release();
        }
    }

    private void processPayload(byte[] payload, int offset, int length) throws GeneralSecurityException {
        try {
            int blocks = SSU2Payload.processPayload(_context, this, payload, offset, length, false);
        } catch (Exception e) {
            throw new GeneralSecurityException("Session Created payload error", e);
        }
    }

    /////////////////////////////////////////////////////////
    // begin payload callbacks
    /////////////////////////////////////////////////////////

    public void gotDateTime(long time) {
    }

    public void gotOptions(byte[] options, boolean isHandshake) {
    }

    public void gotRI(RouterInfo ri, boolean isHandshake, boolean flood) throws DataFormatException {
    }

    public void gotRIFragment(byte[] data, boolean isHandshake, boolean flood, boolean isGzipped, int frag, int totalFrags) {
        throw new IllegalStateException("RI fragment in Data phase");
    }

    public void gotAddress(byte[] ip, int port) {
    }

    public void gotIntroKey(byte[] key) {
    }

    public void gotRelayTagRequest() {
    }

    public void gotRelayTag(long tag) {
    }

    public void gotToken(long token, long expires) {
        _transport.getEstablisher().addOutboundToken(_remotePeer, token, expires);
    }

    public void gotI2NP(I2NPMessage msg) {
        // 9 byte header
        int size = msg.getMessageSize() - 7;
        // complete message, skip IMF and MessageReceiver
        _transport.messageReceived(msg, null, _remotePeer, 0, size);
    }

    public void gotFragment(byte[] data, int off, int len, long messageId,int frag, boolean isLast) throws DataFormatException {
        InboundMessageState state;
        boolean messageComplete = false;
        boolean messageExpired = false;

        synchronized (_inboundMessages) {
            state = _inboundMessages.get(messageId);
            if (state == null) {
                state = new InboundMessageState(_context, messageId, _remotePeer, data, off, len, frag, isLast);
                _inboundMessages.put(messageId, state);
            } else {
                boolean fragmentOK = state.receiveFragment(data, off, len, frag, isLast);
                if (!fragmentOK)
                    return;
                if (state.isComplete()) {
                    messageComplete = true;
                    _inboundMessages.remove(messageId);
                } else if (state.isExpired()) {
                    messageExpired = true;
                    _inboundMessages.remove(messageId);
                }
            }
        }

        if (messageComplete) {
            messageFullyReceived(messageId, state.getCompleteSize());
            if (_log.shouldDebug())
                _log.debug("Message received completely!  " + state);
            _context.statManager().addRateData("udp.receivedCompleteTime", state.getLifetime(), state.getLifetime());
            _context.statManager().addRateData("udp.receivedCompleteFragments", state.getFragmentCount(), state.getLifetime());
            receiveMessage(state);
        } else if (messageExpired) {
            if (_log.shouldWarn())
                _log.warn("Message expired while only being partially read: " + state);
            _context.messageHistory().droppedInboundMessage(state.getMessageId(), state.getFrom(), "expired while partially read: " + state.toString());
            // all state access must be before this
            state.releaseResources();
        }
    }

    public void gotACK(long ackThru, int acks, byte[] ranges) {
    }

    public void gotTermination(int reason, long count) {
    }

    public void gotUnknown(int type, int len) {
    }

    public void gotPadding(int paddingLength, int frameLength) {
    }

    /////////////////////////////////////////////////////////
    // end payload callbacks
    /////////////////////////////////////////////////////////

    /**
     *  Do what MessageReceiver does, but inline and for SSU2.
     *  Will always be more than one fragment.
     */
    private void receiveMessage(InboundMessageState state) {
        int sz = state.getCompleteSize();
        try {
            byte buf[] = new byte[sz];
            I2NPMessage m;
            int numFragments = state.getFragmentCount();
            ByteArray fragments[] = state.getFragments();
            int off = 0;
            for (int i = 0; i < numFragments; i++) {
                ByteArray ba = fragments[i];
                int len = ba.getValid();
                System.arraycopy(ba.getData(), 0, buf, off, len);
                off += len;
             }
             if (off != sz) {
                 if (_log.shouldWarn())
                     _log.warn("Hmm, offset of the fragments = " + off + " while the state says " + sz);
                 return;
             }
             I2NPMessage msg = I2NPMessageImpl.fromRawByteArrayNTCP2(_context, buf, 0, sz, null);
             _transport.messageReceived(msg, null, _remotePeer, state.getLifetime(), sz);
        } catch (I2NPMessageException ime) {
            if (_log.shouldWarn())
                _log.warn("Message invalid: " + state + " PeerState: " + this, ime);
        } catch (RuntimeException e) {
            // e.g. AIOOBE
            if (_log.shouldWarn())
                _log.warn("Error handling a message: " + state, e);
        } finally {
            state.releaseResources();
        }
    }

    /**
     *  Record the mapping of packet number to what fragments were in it,
     *  so we can process acks.
     */
    void fragmentsSent(long pktNum, List<PacketBuilder.Fragment> fragments) {

    }
}