<%@page contentType="text/html"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="css.jsi" %>
<%=intl.title("events")%>
 <jsp:useBean class="net.i2p.router.web.helpers.EventLogHelper" id="eventHelper" scope="request" />
 <jsp:setProperty name="eventHelper" property="contextId" value="<%=i2pcontextId%>" />
<% /* GraphHelper sets the defaults in setContextId, so setting the properties must be after the context */ %>
 <jsp:setProperty name="eventHelper" property="*" />
<%
    eventHelper.storeWriter(out);
    eventHelper.storeMethod(request.getMethod());
%>
<script nonce="<%=cspNonce%>" src="/js/tablesort/tablesort.js" type="text/javascript"></script>
<script nonce="<%=cspNonce%>" src="/js/tablesort/tablesort.number.js" type="text/javascript"></script>
<script nonce="<%=cspNonce%>" src="/js/tablesort/tablesort.date.js" type="text/javascript"></script>
<link href="/themes/console/tablesort.css" rel="stylesheet" type="text/css">
</head>
<body>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.show();</script>
<%@include file="summary.jsi" %>
<h1 class="log"><%=intl._t("Event Log")%></h1>
<div class="main" id="events">
 <div class="eventspanel">
 <div class="widepanel">
 <jsp:getProperty name="eventHelper" property="allMessages" />
 <jsp:getProperty name="eventHelper" property="form" />
 <jsp:getProperty name="eventHelper" property="events" />
</div>
</div>
</div>
<script nonce="<%=cspNonce%>" type="text/javascript">new Tablesort(document.getElementById("eventlog"));</script>
<%@include file="summaryajax.jsi" %>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.hide();</script>
</body>
</html>
