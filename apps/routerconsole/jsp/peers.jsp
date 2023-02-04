<%@page contentType="text/html"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%
    net.i2p.I2PAppContext ctx = net.i2p.I2PAppContext.getGlobalContext();
    String lang = "en";
    if (ctx.getProperty("routerconsole.lang") != null)
        lang = ctx.getProperty("routerconsole.lang");
%>
<html lang="<%=lang%>">
<head>
<%@include file="css.jsi" %>
<%@include file="summaryajax.jsi" %>
<%=intl.title("peer connections")%>
</head>
<body>
<script nonce="<%=cspNonce%>" type=text/javascript>progressx.show();progressx.progress(0.5);</script>
<%@include file="summary.jsi" %>
<jsp:useBean class="net.i2p.router.web.helpers.PeerHelper" id="peerHelper" scope="request" />
<jsp:setProperty name="peerHelper" property="contextId" value="<%=i2pcontextId%>" />
<jsp:setProperty name="peerHelper" property="urlBase" value="peers.jsp" />
<jsp:setProperty name="peerHelper" property="transport" value="<%=request.getParameter(\"transport\")%>" />
<jsp:setProperty name="peerHelper" property="sort" value="<%=request.getParameter(\"sort\") != null ? request.getParameter(\"sort\") : \"\"%>" />
<%
    String req = request.getParameter("transport");
    if (req == null) {
%>
<h1 class="netwrk"><%=intl._t("Network Peers")%></h1>
<%
    } else if (req.equals("ntcp")) {
%>
<h1 class="netwrk"><%=intl._t("Network Peers")%> &ndash; NTCP</h1>
<%
    } else if (req.equals("ssu")) {
%>
<h1 class="netwrk"><%=intl._t("Network Peers")%> &ndash; SSU</h1>
<%
    }
%>
<div class=main id="peers">
<%
    peerHelper.storeWriter(out);
    if (allowIFrame)
        peerHelper.allowGraphical();
%>
<jsp:getProperty name="peerHelper" property="peerSummary" />
</div>
<script nonce="<%=cspNonce%>" src="/js/lazyload.js" type=text/javascript></script>
<script nonce="<%=cspNonce%>" type=text/javascript>
document.addEventListener("DOMContentLoaded", function() {
  setInterval(function() {
    progressx.show();
    var uri = (window.location.pathname + window.location.search).substring(1);
    var xhr = new XMLHttpRequest();
    if (uri.includes("?transport"))
      xhr.open('GET', uri + '&t=' + new Date().getTime(), true);
    else
      xhr.open('GET', '/peers?' + new Date().getTime(), true);
    xhr.responseType = "document";
    var udp = document.getElementById("udp");
    var ntcp = document.getElementById("ntcp");
    var summary = document.getElementById("transportSummary");
    var autorefresh = document.getElementById("autorefresh");
    xhr.onreadystatechange = function () {
      if (xhr.readyState==4 && xhr.status==200 && autorefresh.checked) {
        if (udp) {
          var udpResponse = xhr.responseXML.getElementById("udp");
          //var udpParent = udp.parentNode;
          if (!Object.is(udp.innerHTML, udpResponse.innerHTML))
            //udpParent.replaceChild(udpResponse, udp);
            udp.innerHTML = udpResponse.innerHTML;
        } else if (ntcp) {
          var ntcpResponse = xhr.responseXML.getElementById("ntcp");
          //var ntcpParent = ntcp.parentNode;
          if (!Object.is(ntcp.innerHTML, ntcpResponse.innerHTML))
            ntcp.innerHTML = ntcpResponse.innerHTML;
            //ntcpParent.replaceChild(ntcpResponse, ntcp);
        } else if (summary) {
          var summaryResponse = xhr.responseXML.getElementById("transportSummary");
          //var summaryParent = summary.parentNode;
          if (!Object.is(summary.innerHTML, summaryResponse.innerHTML))
            summary.innerHTML = summaryResponse.innerHTML;
            //summaryParent.replaceChild(summaryResponse, summary);
        }
      }
    }
    window.addEventListener("DOMContentLoaded", progressx.hide());
    if (ntcp != null)
        ntcp.addEventListener("mouseover", lazyload());
    if (udp != null)
        udp.addEventListener("mouseover", lazyload());
    xhr.send();
  }, 15000);
}, true);
</script>
<script nonce="<%=cspNonce%>" type=text/javascript>window.addEventListener("DOMContentLoaded", progressx.hide());window.addEventListener("pageshow", lazyload());</script>
</body>
</html>