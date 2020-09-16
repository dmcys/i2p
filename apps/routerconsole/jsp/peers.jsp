<%@page contentType="text/html"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="css.jsi" %>
<%=intl.title("peer connections")%>
</head>
<body>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.show();</script>
<%@include file="summary.jsi" %>
<h1 class="netwrk"><%=intl._t("Network Peers")%></h1>
<div class="main" id="peers">
 <jsp:useBean class="net.i2p.router.web.helpers.PeerHelper" id="peerHelper" scope="request" />
 <jsp:setProperty name="peerHelper" property="contextId" value="<%=i2pcontextId%>" />
<%
    peerHelper.storeWriter(out);
    if (allowIFrame)
        peerHelper.allowGraphical();
%>
 <jsp:setProperty name="peerHelper" property="urlBase" value="peers.jsp" />
 <jsp:setProperty name="peerHelper" property="sort" value="<%=request.getParameter(\"sort\") != null ? request.getParameter(\"sort\") : \"\"%>" />
 <jsp:setProperty name="peerHelper" property="transport" value="<%=request.getParameter(\"transport\")%>" />
 <jsp:getProperty name="peerHelper" property="peerSummary" />
</div>
<script nonce="<%=cspNonce%>" type="text/javascript">
  setInterval(function() {
    progressx.show();
    var uri = (window.location.pathname + window.location.search).substring(1);
    var xhr = new XMLHttpRequest();
    if (uri.includes("?transport"))
      xhr.open('GET', uri + '&t=' + new Date().getTime(), true);
    else
      xhr.open('GET', '/peers?' + new Date().getTime(), true);
    xhr.responseType = "document";
    xhr.onreadystatechange = function () {
      if (xhr.readyState==4 && xhr.status==200) {
        var udp = document.getElementById("udp");
        var ntcp = document.getElementById("ntcp");
        if (udp) {
          var udpResponse = xhr.responseXML.getElementById("udp");
          var udpParent = udp.parentNode;
          if (!Object.is(udp.innerHTML, udpResponse.innerHTML))
            udpParent.replaceChild(udpResponse, udp);
        }
        if (ntcp) {
          var ntcpResponse = xhr.responseXML.getElementById("ntcp");
          var ntcpParent = ntcp.parentNode;
          if (!Object.is(ntcp.innerHTML, ntcpResponse.innerHTML))
            ntcpParent.replaceChild(ntcpResponse, ntcp);
        }
      }
    }
    window.addEventListener("pageshow", progressx.hide());
    xhr.send();
  }, 15000);
</script>
<%@include file="summaryajax.jsi" %>
<script nonce="<%=cspNonce%>" type="text/javascript">window.addEventListener("pageshow", progressx.hide());</script>
</body>
</html>
