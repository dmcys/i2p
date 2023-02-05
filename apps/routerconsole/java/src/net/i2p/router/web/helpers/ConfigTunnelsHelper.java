package net.i2p.router.web.helpers;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import net.i2p.data.DataHelper;
import net.i2p.data.Destination;
import net.i2p.data.Hash;
import net.i2p.router.TunnelManagerFacade;
import net.i2p.router.TunnelPoolSettings;
import net.i2p.router.transport.TransportUtil;
import net.i2p.router.web.HelperBase;

public class ConfigTunnelsHelper extends HelperBase {
    private static final String HOP = "hop";
    private static final String TUNNEL = "tunnel";
    /** dummies for translation */
    private static final String HOPS = ngettext("{0} hop", "{0} hops");
    private static final String TUNNELS = ngettext("{0} tunnel", "{0} tunnels");

    public String getForm() {
        StringBuilder buf = new StringBuilder(1024);
        // HTML: <input> cannot be inside a <table>
        buf.append("<input type=hidden name=\"pool.0\" value=\"exploratory\" >\n");
        int cur = 1;
        Set<Destination> clients = _context.clientManager().listClients();
        TunnelManagerFacade mgr = _context.tunnelManager();
        // display name to in pool
        List<TunnelPoolSettings> sorted = new ArrayList<TunnelPoolSettings>(clients.size());
        for (Destination dest : clients) {
            TunnelPoolSettings in = mgr.getInboundSettings(dest.calculateHash());
            if (in != null)
                sorted.add(in);
        }
        if (sorted.size() > 1)
            DataHelper.sort(sorted, new TPComparator());
        for (TunnelPoolSettings in : sorted) {
            buf.append("<input type=hidden name=\"pool.").append(cur).append("\" value=\"");
            buf.append(in.getDestination().toBase64()).append("\" >\n");
            cur++;
        }

        buf.append("<table id=\"tunnelconfig\" class=\"configtable\">\n");
        TunnelPoolSettings exploratoryIn = mgr.getInboundSettings();
        TunnelPoolSettings exploratoryOut = mgr.getOutboundSettings();

        renderForm(buf, 0, "exploratory", _t("Exploratory tunnels"), exploratoryIn, exploratoryOut);

        cur = 1;
        for (TunnelPoolSettings in : sorted) {
            Hash h = in.getDestination();
            TunnelPoolSettings out = mgr.getOutboundSettings(h);

            if (in.getAliasOf() != null ||
                out == null || out.getAliasOf() != null) {
                cur++;
                continue;
            }

            String prefix = h.toBase64().substring(0,4);
            renderForm(buf, cur, prefix, _t("Client tunnels for {0}", getTunnelName(in)), in, out);
            cur++;
        }

        buf.append("</table>\n");
        return buf.toString();
    }

    /**
     *  Sort tunnels by the name of the tunnel
     *  @since 0.9.57
     */
    private class TPComparator implements Comparator<TunnelPoolSettings> {
         private final Collator _comp = Collator.getInstance();
         public int compare(TunnelPoolSettings l, TunnelPoolSettings r) {
             int rv = _comp.compare(getTunnelName(l), getTunnelName(r));
             if (rv != 0)
                 return rv;
             return l.getDestination().toBase32().compareTo(r.getDestination().toBase32());
        }
    }

    /**
     *  Get display name for the tunnel
     *  @since 0.9.57
     */
    private String getTunnelName(TunnelPoolSettings ins) {
        String name = ins.getDestinationNickname();
        if (name == null) {
            TunnelPoolSettings outPool = _context.tunnelManager().getOutboundSettings(ins.getDestination());
            if (outPool != null)
                name = outPool.getDestinationNickname();
        }
        if (name != null)
            return DataHelper.escapeHTML(_t(name));
        return ins.getDestination().toBase32();
    }

    private static final int WARN_LENGTH = 4;
//    private static final int MAX_LENGTH = 4;
    private static final int MAX_LENGTH = 5;
    private static final int MAX_ADVANCED_LENGTH = 7;
    private static final int WARN_QUANTITY = 5;
    private static final int MAX_QUANTITY = 6;
    private static final int MAX_ADVANCED_QUANTITY = 16;
    private static final int MAX_BACKUP_QUANTITY = 3;
    private static final int MAX_ADVANCED_BACKUP_QUANTITY = 16;
    private static final int MAX_VARIANCE = 3;
    private static final int MIN_NEG_VARIANCE = -2;

    private void renderForm(StringBuilder buf, int index, String prefix, String name, TunnelPoolSettings in, TunnelPoolSettings out) {

        boolean advanced = isAdvanced();

        buf.append("<tr><th colspan=4 class=\"th_title\"><a name=\"").append(prefix).append("\">");
        buf.append(name).append("</a></th></tr>\n");
        if (in.getLength() <= 0 ||
            in.getLength() + in.getLengthVariance() <= 0 ||
            out.getLength() <= 0 ||
            out.getLength() + out.getLengthVariance() <= 0) {
            buf.append("<tr><th colspan=4><font color=\"#900\">" +
                       _t("ANONYMITY WARNING - Settings include 0-hop tunnels.") +
                       "</font></th></tr>\n");
            if (TransportUtil.getIPv6Config(_context, "SSU") == TransportUtil.IPv6Config.IPV6_ONLY) {
                // rare, don't bother translating
                buf.append("<tr><th colspan=4><font color=\"#900\">" +
                           _t("WARNING - 0-hop tunnels not recommended for IPv6-only routers.") +
                           "</font></th></tr>\n");
            }
            if ((in.getLength() <= 0 || in.getLength() + in.getLengthVariance() <= 0) &&
                _context.router().isHidden()) {
                // rare, don't bother translating
                buf.append("<tr><th colspan=4><font color=\"#900\">" +
                           _t("WARNING - Inbound 0-hop tunnels not recommended for hidden routers.") +
                           "</font></th></tr>\n");
            }
        } else if (in.getLength() <= 1 ||
            in.getLength() + in.getLengthVariance() <= 1 ||
            out.getLength() <= 1 ||
            out.getLength() + out.getLengthVariance() <= 1) {
            buf.append("<tr><th colspan=4><font color=\"#900\">" +
                       _t("ANONYMITY WARNING - Settings include 1-hop tunnels.") +
                       "</font></th></tr>\n");
        }
        if (in.getLength() + Math.abs(in.getLengthVariance()) >= WARN_LENGTH ||
            out.getLength() + Math.abs(out.getLengthVariance()) >= WARN_LENGTH)
            buf.append("<tr><th colspan=4><font color=\"#900\">" +
                       _t("PERFORMANCE WARNING - Settings include very long tunnels.") +
                       "</font></th></tr>\n");
        if (in.getTotalQuantity() >= WARN_QUANTITY ||
            out.getTotalQuantity() >= WARN_QUANTITY)
            buf.append("<tr><th colspan=4><font color=\"#900\">" +
                       _t("PERFORMANCE WARNING - Settings include high tunnel quantities.") +
                       "</font></th></tr>\n");

        buf.append("<tr><th></th><th class=inbound>" + _t("Inbound") + "</th><th class=outbound>" +
                   _t("Outbound") + "</th><th class=spacer></th>\n</tr>\n");

        // tunnel depth
        int maxLength = advanced ? MAX_ADVANCED_LENGTH : MAX_LENGTH;
        buf.append("<tr><td><b>" + _t("Length") + ":</b></td>\n");
        buf.append("<td><select name=\"").append(index).append(".depthInbound\"");
        if (!advanced && prefix != "exploratory")
            buf.append(" disabled");
        buf.append(">\n");
        int now = in.getLength();
        renderOptions(buf, 0, maxLength, now, "", HOP);
        if (now > maxLength)
            renderOptions(buf, now, now, now, "", HOP);
        buf.append("</select></td>\n");

        buf.append("<td><select name=\"").append(index).append(".depthOutbound\"");
        if (!advanced && prefix != "exploratory")
            buf.append(" disabled");
        buf.append(">\n");
        now = out.getLength();
        renderOptions(buf, 0, maxLength, now, "", HOP);
        if (now > maxLength)
            renderOptions(buf, now, now, now, "", HOP);
        buf.append("</select></td>\n");
        buf.append("<td class=spacer></td>\n</tr>\n");

        // tunnel depth variance
        if (advanced) {
            buf.append("<tr><td><b>" + _t("Randomization") + ":</b></td>\n");
            buf.append("<td><select name=\"").append(index).append(".varianceInbound\">\n");
            now = in.getLengthVariance();
            renderOptions(buf, 0, 0, now, "", HOP);
            renderOptions(buf, 1, MAX_VARIANCE, now, "+ 0-", HOP);
            renderOptions(buf, MIN_NEG_VARIANCE, -1, now, "+/- 0", HOP);
            if (now > MAX_VARIANCE)
                renderOptions(buf, now, now, now, "+ 0-", HOP);
            else if (now < MIN_NEG_VARIANCE)
                renderOptions(buf, now, now, now, "+/- 0", HOP);
            buf.append("</select></td>\n");

            buf.append("<td><select name=\"").append(index).append(".varianceOutbound\">\n");
            now = out.getLengthVariance();
            renderOptions(buf, 0, 0, now, "", HOP);
            renderOptions(buf, 1, MAX_VARIANCE, now, "+ 0-", HOP);
            renderOptions(buf, MIN_NEG_VARIANCE, -1, now, "+/- 0", HOP);
            if (now > MAX_VARIANCE)
                renderOptions(buf, now, now, now, "+ 0-", HOP);
            else if (now < MIN_NEG_VARIANCE)
                renderOptions(buf, now, now, now, "+/- 0", HOP);
            buf.append("</select></td>\n");
            buf.append("<td class=spacer></td>\n</tr>\n");
        }
        // tunnel quantity
        int maxQuantity = advanced ? MAX_ADVANCED_QUANTITY : MAX_QUANTITY;
        buf.append("<tr");
        if (!advanced)
            buf.append(" class=\"lastrow\"");
        buf.append("><td><b>" + _t("Quantity") + ":</b></td>\n");
        buf.append("<td><select name=\"").append(index).append(".quantityInbound\"");
        if (!advanced && prefix != "exploratory")
            buf.append(" disabled");
        buf.append(">\n");
        now = in.getQuantity();
        renderOptions(buf, 1, maxQuantity, now, "", TUNNEL);
        if (now > maxQuantity)
            renderOptions(buf, now, now, now, "", TUNNEL);
        buf.append("</select></td>\n");

        buf.append("<td><select name=\"").append(index).append(".quantityOutbound\"");
        if (!advanced && prefix != "exploratory")
            buf.append(" disabled");
        buf.append(">\n");
        now = out.getQuantity();
        renderOptions(buf, 1, maxQuantity, now, "", TUNNEL);
        if (now > maxQuantity)
            renderOptions(buf, now, now, now, "", TUNNEL);
        buf.append("</select></td>\n");
        buf.append("<td class=spacer></td>\n</tr>\n");

        // tunnel backup quantity
        if (advanced) {
            int maxBQuantity = advanced ? MAX_ADVANCED_BACKUP_QUANTITY : MAX_BACKUP_QUANTITY;
            buf.append("<tr class=\"lastrow\"><td><b>" + _t("Backup quantity") + ":</b></td>\n");
            buf.append("<td><select name=\"").append(index).append(".backupInbound\">\n");
            now = in.getBackupQuantity();
            renderOptions(buf, 0, maxBQuantity, now, "", TUNNEL);
            if (now > maxBQuantity)
                renderOptions(buf, now, now, now, "", TUNNEL);
            buf.append("</select></td>\n");

            buf.append("<td><select name=\"").append(index).append(".backupOutbound\">\n");
            now = out.getBackupQuantity();
            renderOptions(buf, 0, maxBQuantity, now, "", TUNNEL);
            if (now > maxBQuantity)
                renderOptions(buf, now, now, now, "", TUNNEL);
            buf.append("</select></td>\n");
            buf.append("<td class=spacer></td>\n</tr>\n");
        }

        // custom options
        // There is no facility to set these, either in ConfigTunnelsHandler or
        // TunnelPoolOptions, so make the boxes readonly.
        // And let's not display them at all unless they have contents, which should be rare.
        Properties props = in.getUnknownOptions();
        if (!props.isEmpty()) {
            buf.append("<tr><td><b>" + _t("Inbound options") + ":</b></td>\n" +
                       "<td colspan=2><input name=\"").append(index);
            buf.append(".inboundOptions\" type=text size=32 disabled=disabled " +
                       "value=\"");
            for (String prop : props.stringPropertyNames()) {
                String val = props.getProperty(prop);
                buf.append(prop).append('=').append(val).append(' ');
            }
            buf.append("\"></td>\n<td class=spacer></td>\n</tr>\n");
        }
        props = out.getUnknownOptions();
        if (!props.isEmpty()) {
            buf.append("<tr><td><b>" + _t("Outbound options") + ":</b></td>\n" +
                       "<td colspan=2><input name=\"").append(index);
            buf.append(".outboundOptions\" type=text size=32 disabled=disabled " +
                       "value=\"");
            for (String prop : props.stringPropertyNames()) {
                String val = props.getProperty(prop);
                buf.append(prop).append('=').append(val).append(' ');
            }
            buf.append("\"></td>\n<td class=spacer></td>\n</tr>\n");
        }
    }

    /** to fool xgettext so the following isn't tagged */
    private static final String DUMMY2 = "{0} ";

    private void renderOptions(StringBuilder buf, int min, int max, int now, String prefix, String name) {
        for (int i = min; i <= max; i++) {
            buf.append("<option value=\"").append(i).append("\" ");
            if (i == now)
                buf.append(SELECTED);
            buf.append(">").append(ngettext(DUMMY2 + name, DUMMY2 + name + 's', i));
            buf.append("</option>\n");
        }
    }

    /** dummy for tagging */
    private static String ngettext(String s, String p) {
        return null;
    }
}
