<%@ page contentType="text/html; charset=UTF-8"%>

<%
    int critical = (int) request.getAttribute("critical");
    int high = (int) request.getAttribute("high");
    int safe = (int) request.getAttribute("safe");
%>

<html>
<head>
<title>Command Center | DigitalFootprint</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
.nav-links a {
    margin-left:20px;
    color:#94a3b8;
    text-decoration:none;
}
.nav-links a:hover { color:#06b6d4; }

/* CONTAINER */
.container {
    padding:40px;
}

/* GRID */
.grid {
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
}

/* CARD */
.card {
    background: rgba(15,23,42,0.6);
    border-radius:16px;
    padding:20px;
    border:1px solid rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    box-shadow:0 0 30px rgba(6,182,212,0.08);
}

/* TITLE */
.card h3 {
    color:#06b6d4;
    margin-bottom:15px;
}

/* FEED */
.feed-item {
    padding:8px;
    border-bottom:1px solid #1e293b;
    font-family:monospace;
    font-size:13px;
}

/* STATS */
.stats {
    display:flex;
    justify-content:space-between;
    margin-bottom:15px;
}
.stat-box {
    text-align:center;
    flex:1;
}
.stat-box h2 { margin:0; }
.stat-box span { color:#94a3b8; font-size:12px; }

/* HEATMAP */
.heatmap {
    display:grid;
    grid-template-columns:repeat(12,1fr);
    gap:3px;
}
.cell {
    width:100%;
    padding-top:100%;
}
#log-feed {
    max-height:250px;
    overflow:hidden;
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">Digital<span>Footprint</span></div>
    <div class="nav-links">
        <a href="index.jsp">Scanner</a>
        <a href="dashboard">Dashboard</a>
    </div>
</nav>

<div class="container">

<h2>🛡 COMMAND CENTER</h2>

<div class="grid">

<!-- 🔴 LIVE FEED -->
<div class="card">
<h3>🚨 LIVE THREAT FEED</h3>
<div id="log-feed"></div>
</div>

<!-- 📊 STATS + CHART -->
<div class="card">

<div class="stats">
    <div class="stat-box">
        <h2 id="critical"><%=critical%></h2>
        <span>Critical</span>
    </div>
    <div class="stat-box">
        <h2 id="high"><%=high%></h2>
        <span>High</span>
    </div>
    <div class="stat-box">
        <h2 id="safe"><%=safe%></h2>
        <span>Safe</span>
    </div>
</div>

<canvas id="chart"></canvas>

</div>

<!-- 🌐 HEATMAP -->
<div class="card">
<h3>🌐 GLOBAL ATTACK GRID</h3>
<div class="heatmap" id="heatmap"></div>
</div>

</div>
</div>

<script>

/* ===== LIVE FEED ===== */

const threats = [
"SQL Injection blocked",
"Brute-force login attempt",
"Malware detected",
"Phishing domain flagged",
"DDoS spike detected",
"Unauthorized API access"
];

const severities = ["CRITICAL","HIGH","MEDIUM","LOW"];

function rand(a){ return a[Math.floor(Math.random()*a.length)]; }

function ip(){
return Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255);
}

function color(s){
if(s==="CRITICAL") return "#ff003c";
if(s==="HIGH") return "#ff6b00";
if(s==="MEDIUM") return "#facc15";
return "#22c55e";
}

setInterval(function(){

const feed=document.getElementById("log-feed");
const sev=rand(severities);

const log =
'<span style="color:'+color(sev)+';font-weight:bold;">['+sev+']</span> '+
new Date().toLocaleTimeString()+
' ('+ip()+') - '+rand(threats);

const el=document.createElement("div");
el.className="feed-item";
el.innerHTML=log;

feed.prepend(el);

if(feed.children.length>12){
feed.removeChild(feed.lastChild);
}


updateStats(sev);

},1200);

/* ===== STATS UPDATE ===== */

function updateStats(sev){

let c = parseInt(document.getElementById("critical").innerText);
let h = parseInt(document.getElementById("high").innerText);
let s = parseInt(document.getElementById("safe").innerText);

if(sev==="CRITICAL") c++;
else if(sev==="HIGH") h++;
else s++;

document.getElementById("critical").innerText = c;
document.getElementById("high").innerText = h;
document.getElementById("safe").innerText = s;

chart.data.datasets[0].data=[c,h,s];
chart.update();
}

/* ===== CHART ===== */

const chart=new Chart(document.getElementById("chart"),{
type:'doughnut',
data:{
labels:["Critical","High","Safe"],
datasets:[{
data:[<%=critical%>,<%=high%>,<%=safe%>],
backgroundColor:["#ff003c","#ff6b00","#00ff99"]
}]
},
options:{
cutout:"70%",
plugins:{legend:{position:"bottom"}}
}
});

/* ===== HEATMAP ===== */

const map=document.getElementById("heatmap");

for(let i=0;i<144;i++){
const c=document.createElement("div");
c.className="cell";
c.style.background="rgba(6,182,212,"+Math.random()+")";
map.appendChild(c);
}

setInterval(()=>{
document.querySelectorAll(".cell").forEach(c=>{
c.style.background="rgba(6,182,212,"+Math.random()+")";
});
},1500);

</script>

</body>
</html>
