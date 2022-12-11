<%@page contentType="text/html"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<jsp:useBean class="net.i2p.router.web.CSSHelper" id="tester" scope="request" />
<%
   String i2pcontextId1 = null;
   try {
       i2pcontextId1 = (String) session.getAttribute("i2p.contextId");
   } catch (IllegalStateException ise) {}
%>
<jsp:setProperty name="tester" property="contextId" value="<%=i2pcontextId1%>" />
<%
    // CSSHelper is also pulled in by css.jsi below...
    boolean testIFrame = tester.allowIFrame(request.getHeader("User-Agent"));
    if (!testIFrame) {
        response.setStatus(307);
        response.setHeader("Location", "/susidns/addressbook?book=router&amp;filter=none");
        // force commitment
        response.getOutputStream().close();
        return;
    } else {
%>
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
<%=intl.title("addressbook")%>
</head>
<body>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.show();</script>
<%@include file="summary.jsi" %>
<h1 class="addbook"><%=intl._t("Addressbook")%> <a href="/susidns/addressbook?book=router&amp;filter=none" target="_blank" title="<%=intl._t("Open in new tab")%>"><span id="newtab"><img src="<%=intl.getTheme(request.getHeader("User-Agent"))%>images/newtab.png" alt="<%=intl._t("Open in new tab")%>"></span></a></h1>
<div class="main" id="dns">
<style>iframe{width:1px;min-width:100%;opacity:0}</style>
<noscript>
<style type="text/css">iframe {display: none}</style>
<p class="infohelp" id="jsRequired" style="margin: 10px;">Javascript is required to view <a href="/susidns/addressbook?book=router&amp;filter=none" target="_blank" rel="noreferrer">the Addressbook</a> in embedded mode.</p>
</noscript>
<iframe src="/susidns/addressbook?book=router&amp;filter=none" title="I2P+ <%=intl._t("addressbook")%>" width="100%" scrolling="no" frameborder="0" border="0" name="susidnsframe" id="susidnsframe" allowtransparency="true">
<%=intl._t("Your browser does not support iFrames.")%>
&nbsp;<a href="/susidns/addressbook?book=router&amp;filter=none"><%=intl._t("Click here to continue.")%></a>
</iframe>
<script charset="utf-8" type="text/javascript" src="/js/iframedClassInject.js?<%=net.i2p.CoreVersion.VERSION%>"></script>
<script nonce="<%=cspNonce%>" type="text/javascript">
  function setupFrame() {
    f = document.getElementById("susidnsframe");
    f.addEventListener("load", function() {
      injectClass(f);
    }, true);
  }
</script>
<script charset="utf-8" type="text/javascript" src="/js/iframeResizer/iframeResizer.js?<%=net.i2p.CoreVersion.VERSION%>"></script>
<script nonce="<%=cspNonce%>" type="text/javascript">
  document.addEventListener('DOMContentLoaded', function(event) {
    var iframes = iFrameResize({log: false, interval: 0, heightCalculationMethod: 'taggedElement', warningTimeout: 0}, '#susidnsframe')
  });
  window.addEventListener("pageshow", progressx.hide());
</script>
</div>
<style type="text/css">iframe{opacity:1}#dns::before{width:100%;animation:fade .3s linear .7s both}</style>
<%@include file="summaryajax.jsi" %>
</body>
</html>
<%
    }
%>