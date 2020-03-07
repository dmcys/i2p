<%@page contentType="text/html"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Tunnel Filtering - I2P+</title>
<%@include file="../css.jsi" %>
<%@include file="../summaryajax.jsi" %>
</head>
<body>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.show();</script>
<%@include file="../summary.jsi" %>
<h1 class="hlp"><%=intl._t("Tunnel Filtering")%></h1>
<div class="main" id="help">
<div class="confignav">
<span class="tab"><a href="/help/configuration">Configuration</a></span>
<span class="tab"><a href="/help/advancedsettings">Advanced Settings</a></span>
<span class="tab"><a href="/help/ui">User Interface</a></span>
<span class="tab"><a href="/help/reseed">Reseeding</a></span>
<span class="tab2">Tunnel Filtering</span>
<span class="tab"><a href="/help/webhosting">Web Hosting</a></span>
<span class="tab"><a href="/help/faq">FAQ</a></span>
<span class="tab"><a href="/help/newusers">New User Guide</a></span>
<span class="tab"><a href="/help/troubleshoot">Troubleshoot</a></span>
<span class="tab"><a href="/help/glossary">Glossary</a></span>
<span class="tab"><a href="/help/legal">Legal</a></span>
<span class="tab"><a href="/help/changelog">Change Log</a></span>
</div>

<div id="filterlist">

<h2><%=intl._t("Introduction to Tunnel Filtering")%></h2>

<p>Server tunnels, configurable in the <a href="/i2ptunnelmgr">Tunnel Manager</a>, provide a number of ways to limit access including whitelisting, blacklisting, and custom access lists. Below we introduce you to the syntax required to implement your own custom access lists for your server tunnels.</p>

<h3>Overview</h3>

<p>A filter is a file that can contain one or more declarations. Blank lines and lines beginning with <i class="example">#</i> are ignored.</p>

<p>A declaration will contain a directive (keyword) with parameters to define the scope of the declaration, and can represent one of the following:</p>

<ul>
<li>A default threshold to apply to all remote destinations not listed in the containing file or any of the referenced files</li>
<li>A threshold to apply to a specific remote destination</li>
<li>A threshold to apply to remote destinations listed in a file</li>
<li>A threshold that if breached will cause the offending remote destination to be recorded in a specified file</li>
</ul>

<p>Note: The order of the declarations matters. The first threshold declaration for a given destination (whether explicit or listed in a referenced file) overrides any future thresholds for the same destination, whether explicit or listed in a file.</p>

<h3>Thresholds</h3>

<p>A threshold is defined by the number of connection attempts a remote destination is permitted to perform over a specified number of seconds before a &quot;breach&quot; occurs.</p>

<p>A threshold declaration can be expressed in one of the following ways:</p>

<ul>
<li>Numeric definition of the number of connection attempts in the period specified (in seconds) e.g. <i class="example">15/5</i>, <i class="example">60/60</i> etc.<br>
Note that if the number of connections is 1 (e.g. <i class="example">1/60</i>), the first connection attempt will result in a breach.</li>
<li>The keyword <i class="example">allow</i>. This threshold is never breached, i.e. an infinite number of connection attempts is permitted.</li>
<li>The keyword <i class="example">deny</i>. This threshold is always breached, i.e. no connection attempts will be allowed.</li>
</ul>

<h4>Default Threshold</h4>

<p>The <i class="example">default</i> threshold applies to any remote destination not explicitly listed in the definition or in any of the referenced files. To set a default threshold use the keyword <i class="example">default</i>.</p>

<p>The following threshold definition <i class="example">15/5</i> specifies that the same remote destination is allowed to make 14 connection attempts during a 5 second period. If it makes one more attempt within the same period, the threshold will be breached.</p>

<code>
15/5 default<br>
allow default<br>
deny default
</code>

<h4>Explicit Thresholds</h4>

<p>Explicit thresholds are applied to a remote destination listed in the definition itself:
</p>

<code>
15/5 explicit asdfasdf&hellip;asdf.b32.i2p<br>
allow explicit fdsafdsa&hellip;fdsa.b32.i2p<br>
deny explicit qwerqwer&hellip;qwerq.b32.i2p
</code>

<h4>Bulk Thresholds</h4>

<p>For convenience you can maintain a list of destinations in a file and define a threshold for all of them in bulk:</p>

<code>
15/5 file /path/throttled_destinations.txt<br>
deny file /path/forbidden_destinations.txt<br>
allow file /path/unlimited_destinations.txt
</code>

<h3>Recorders</h3>

<p>Recorders keep track of connection attempts made by a remote destination, and if that breaches the defined threshold, the destination gets logged in the specified file:</p>

<code>
30/5 record /path/aggressive.txt<br>
60/5 record /path/very_aggressive.txt<br>
</code>

<p>You can use a recorder to log aggressive destinations to a given file, and then use that same file to throttle them. The following snippet defines a filter that
initially allows all connection attempts, but if any single destination exceeds 30 attempts in 5 seconds, it gets throttled down to 15 attempts every 5 seconds:</p>

<code>
# by default there are no limits<br>
allow default<br>
# but log overly aggressive destinations<br>
30/5 record /path/throttled.txt<br>
# and any that end up in that file will get throttled in the future<br>
15/5 file /path/throttled.txt
</code>

<p>To log all unique remote destinations connecting to a server, and also log aggressive connection attempts:</p>

<code>
# log all unique destinations</br>
1/60 record /path/visitors.txt<br>
# log visitors making 60 or more connections a minute<br>
60/60 record /path/aggressive.txt
</code>

<p>You can use a recorder in one tunnel that writes to a file that another tunnel, or multiple tunnels, can use for throttling. These files can also be edited by hand.</p>

<p>The following filter definition applies some throttling by default, no throttling for destinations in the file <i class="example">friends.txt</i>, forbids any connections from destinations in the file <i class="example">enemies.txt</i>, and logs any aggressive behavior in a file called <i class="example">suspicious.txt</i>:</p>

<code>
15/5 default<br>
allow file /path/friends.txt<br>
deny file /path/enemies.txt<br>
60/60 record /path/suspicious.txt
</code>

</div>

</div>
<script nonce="<%=cspNonce%>" type="text/javascript">progressx.hide();</script>
</body>
</html>