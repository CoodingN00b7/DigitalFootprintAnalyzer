<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Scan Report | DigitalFootprint</title>

<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap" rel="stylesheet">

<style>
body {
    margin:0;
    font-family:'Orbitron', sans-serif;
    background: radial-gradient(circle at top, #020617, #000);
    color:white;
}

/* NAVBAR */
.navbar {
    display:flex;
    justify-content:space-between;
    padding:20px 40px;
}
.logo span { color:#06b6d4; }

/* MAIN */
.container {
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

/* CARD */
.card {
    width:100%;
    max-width:650px;
    padding:30px;
    border-radius:20px;
    background: rgba(15,23,42,0.6);
    backdrop-filter: blur(20px);
    border:1px solid rgba(255,255,255,0.08);
    box-shadow:0 0 60px rgba(6,182,212,0.1);
    text-align:center;
}

/* STATUS */
.status {
    font-size:22px;
    margin:15px 0;
}
.critical { color:#ff003c; }
.safe { color:#00ff99; }

/* TARGET */
.target-box {
    background:#020617;
    padding:12px;
    border-radius:10px;
    border:1px solid #1e293b;
    margin:20px 0;
}

/* RISK BAR */
.risk-bar {
    height:12px;
    border-radius:10px;
    background:#020617;
    overflow:hidden;
    margin-top:10px;
}
.risk-fill {
    height:100%;
}

/* BREACH BOX */
.breach-box {
    margin-top:20px;
    text-align:left;
    background:rgba(255,0,60,0.05);
    border:1px solid rgba(255,0,60,0.2);
    border-radius:10px;
    padding:15px;
}

/* BUTTON */
.btn {
    display:inline-block;
    margin-top:25px;
    padding:12px 30px;
    border-radius:12px;
    border:1px solid #06b6d4;
    color:#06b6d4;
    text-decoration:none;
}
.btn:hover {
    background:rgba(6,182,212,0.1);
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">Digital<span>Footprint</span></div>
    <div>
        <a href="index.jsp">Scanner</a> |
        <a href="dashboard">Dashboard</a>
    </div>
</nav>

<div class="container">

<div class="card">

<h2 style="color:#06b6d4;">🧠 THREAT ANALYSIS REPORT</h2>

<div class="target-box">
    Target: <strong>${target}</strong>
</div>

<%
    int breaches = (Integer) request.getAttribute("breaches");
    int risk = (Integer) request.getAttribute("risk");
    List<String> details = (List<String>) request.getAttribute("breachDetails");

    String statusClass = breaches > 0 ? "critical" : "safe";
    String statusText = breaches > 0 ? "⚠ CRITICAL RISK DETECTED" : "✅ SYSTEM SECURE";
%>

<div class="status <%=statusClass%>">
    <%=statusText%>
</div>

<!-- STATS -->
<div style="margin-top:20px;">
    <div>Known Breaches: <strong><%=breaches%></strong></div>
    <div style="margin-top:10px;">Risk Score: <strong><%=risk%> / 100</strong></div>
</div>

<!-- RISK BAR -->
<div class="risk-bar">
    <div class="risk-fill" 
         style="width:<%=risk%>%; background:<%= risk > 70 ? "#ff003c" : risk > 40 ? "#ff6b00" : "#00ff99" %>;">
    </div>
</div>

<!-- BREACH DETAILS -->
<%
if (details != null && !details.isEmpty()) {
%>
<div class="breach-box">
    <strong style="color:#ff003c;">🚨 COMPROMISED SOURCES</strong>

    <ul style="list-style:none; padding:0; margin-top:10px;">

    <% for(String s : details) {

        String color = "#22c55e";

        if (s.contains("CRITICAL")) color = "#ff003c";
        else if (s.contains("HIGH")) color = "#ff6b00";
        else if (s.contains("MEDIUM")) color = "#facc15";
    %>

        <li style="margin-bottom:10px; padding:10px; border-radius:8px; background:#020617; border:1px solid #1e293b;">
            
            <span style="color:<%=color%>; font-weight:bold;">●</span>

            <span style="margin-left:8px;"><%=s%></span>

        </li>

    <% } %>

    </ul>
</div>
<% } %>

<a href="index.jsp" class="btn">NEW SCAN</a>

</div>
</div>

</body>
</html>
