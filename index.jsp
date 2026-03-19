<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DigitalFootprint | Scanner</title>

<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>

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

/* TITLE */
.title {
    text-align:center;
    font-size:38px;
    margin-top:30px;
}
.title span {
    color:#06b6d4;
    text-shadow:0 0 15px rgba(6,182,212,0.6);
}

/* CARD */
.card {
    max-width:850px;
    margin:25px auto;
    padding:30px;
    border-radius:20px;
    background: rgba(15,23,42,0.6);
    backdrop-filter: blur(20px);
    border:1px solid rgba(255,255,255,0.08);
}

/* TOGGLE */
.toggle { display:flex; justify-content:center; margin-bottom:20px; }
.toggle-inner {
    display:flex;
    background:#020617;
    border-radius:50px;
    padding:5px;
}
.toggle-inner label {
    padding:8px 30px;
    cursor:pointer;
    color:#64748b;
}
input:checked + label {
    background:linear-gradient(90deg,#6366f1,#06b6d4);
    border-radius:50px;
    color:white;
}

/* TABS */
.tabs {
    display:flex;
    justify-content:center;
    gap:12px;
    margin-bottom:20px;
}
.tab {
    padding:10px 18px;
    border-radius:12px;
    background:#0f172a;
    border:1px solid #1e293b;
    display:flex;
    gap:8px;
    cursor:pointer;
    transition:0.25s;
}
.tab:hover {
    transform:translateY(-2px);
    border-color:#06b6d4;
}
.tab.active {
    border-color:#06b6d4;
    color:#06b6d4;
    box-shadow:0 0 12px rgba(6,182,212,0.4);
}

/* SEARCH */
.search {
    display:flex;
    border:1px solid #1e293b;
    border-radius:12px;
    overflow:hidden;
}
.search input {
    flex:1;
    padding:15px;
    background:none;
    border:none;
    color:white;
}

/* BUTTON */
.search button {
    padding:15px 25px;
    border:none;
    background:linear-gradient(90deg,#6366f1,#06b6d4);
    color:white;
    cursor:pointer;
    animation:pulse 2.5s infinite;
}
@keyframes pulse {
    0% { box-shadow:0 0 0 rgba(6,182,212,0.4); }
    50% { box-shadow:0 0 15px rgba(6,182,212,0.6); }
    100% { box-shadow:0 0 0 rgba(6,182,212,0.4); }
}

/* FEED */
.feed-title {
    color:#06b6d4;
    margin-bottom:15px;
}
.feed-item {
    padding:10px;
    border-bottom:1px solid #1e293b;
    font-family:monospace;
    font-size:13px;
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

<h1 class="title">THREAT <span>ANALYZER</span></h1>

<!-- SCANNER -->
<div class="card">
<form action="scan" method="post">

<div class="toggle">
    <div class="toggle-inner">
        <input type="radio" id="api" name="scanType" checked hidden onchange="toggleTabs()">
        <label for="api">API</label>

        <input type="radio" id="local" name="scanType" hidden onchange="toggleTabs()">
        <label for="local">LOCAL</label>
    </div>
</div>

<div class="tabs">
    <div class="tab active" id="t-email" onclick="setTab('email')">
        <i data-lucide="mail"></i> Email
    </div>
    <div class="tab" id="t-ip" style="display:none" onclick="setTab('ip')">
        <i data-lucide="globe"></i> IP
    </div>
    <div class="tab" id="t-url" style="display:none" onclick="setTab('url')">
        <i data-lucide="link"></i> URL
    </div>
</div>

<div class="search">
    <input type="text" id="target" name="target" placeholder="Enter email..." required>
    <button>START SCAN</button>
</div>

</form>
</div>

<!-- THREAT FEED -->
<div class="card">
<div class="feed-title">🚨 LIVE THREAT INTELLIGENCE</div>
<div id="intel-feed"></div>
</div>

<script>
lucide.createIcons();

function toggleTabs() {
    const isLocal = document.getElementById("local").checked;
    document.getElementById("t-ip").style.display = isLocal ? "flex" : "none";
    document.getElementById("t-url").style.display = isLocal ? "flex" : "none";

    if (!isLocal) setTab("email");
}
window.onload = toggleTabs;

function setTab(type) {
    document.querySelectorAll(".tab").forEach(t => t.classList.remove("active"));
    document.getElementById("t-"+type).classList.add("active");
    document.getElementById("target").placeholder = "Enter "+type+"...";
}

/* REALISTIC FEED */
const threats=["SQL Injection blocked","DDoS attempt","Phishing flagged","Malware detected"];
const sev=["CRITICAL","HIGH","MEDIUM","LOW"];

function rand(a){ return a[Math.floor(Math.random()*a.length)]; }
function ip(){ return Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255)+"."+Math.floor(Math.random()*255); }

function color(s){
if(s==="CRITICAL") return "#ff003c";
if(s==="HIGH") return "#ff6b00";
if(s==="MEDIUM") return "#facc15";
return "#22c55e";
}

setInterval(()=>{
const f=document.getElementById("intel-feed");
const s=rand(sev);

const log =
'<span style="color:'+color(s)+'">['+s+']</span> '+
new Date().toLocaleTimeString()+
' ('+ip()+') - '+rand(threats);

const d=document.createElement("div");
d.className="feed-item";
d.innerHTML=log;

f.prepend(d);
if(f.children.length>8) f.removeChild(f.lastChild);

},1200);
</script>

</body>
</html>
