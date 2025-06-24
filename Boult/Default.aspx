<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BoltToolkit.Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bolt Diagnostic Toolkit</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        /* Navbar */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #004C46; /* FinThrive green-teal */
            padding: 10px 30px;
            height: 60px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1050;
        }

        .logo-img {
            height: 36px;
            width: auto;
            opacity: 0.8;
            filter: none;
        }

        .navbar-left,
        .navbar-right {
            display: flex;
            align-items: center;
            gap: 12px;
            flex: 1;
        }

        .navbar-title {
            flex: 2;
            text-align: center;
            pointer-events: none;
        }

        .navbar-title span {
            color: white;
            font-family: 'Segoe UI', sans-serif;
            font-weight: 800;
            font-size: 28px;
            letter-spacing: 3px;
        }

        .navbar-right {
            justify-content: flex-end;
        }

        .fa-bars {
            font-size: 22px;
            color: white;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .fa-bars:hover {
            transform: scale(1.1);
        }

        .navbar-right button {
            background-color: #007070;
            padding: 6px 14px;
            margin-left: 12px;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
            border: none;
            transition: all 0.3s ease;
        }

        .navbar-right button:hover {
            background-color: #004040;
            transform: scale(1.05);
        }

        /* Sidebar */
        .sidebar {
            height: calc(100vh - 60px);
            width: 450px;
            position: fixed;
            top: 60px;
            left: -450px;
            background-color: #1f2d2d;
            padding-top: 20px;
            transition: left 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar .search-bar {
            padding: 10px 15px;
            display: flex;
            gap: 8px;
        }

        .sidebar .search-bar input {
            flex: 1;
            padding: 6px;
            border-radius: 5px;
            border: none;
        }

        .sidebar .search-bar button {
            padding: 6px 12px;
            background-color: #007070;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .sidebar .search-bar button:hover {
            background-color: #005050;
        }

        .sidebar a {
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            display: block;
            transition: all 0.3s ease;
        }

        .sidebar a[data-toggle="collapse"] {
            font-weight: bold;
            color: #ffffff;
        }

        .sidebar .collapse a {
            font-weight: normal;
            font-size: 15px;
            padding-left: 30px;
            color: #a8c3c3;
        }

        .sidebar a:hover {
            background-color: #2d3e3e;
            padding-left: 25px;
        }

        /* Content */
        .content {
            margin-top: 80px;
            margin-left: 0;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        .content.shifted {
            margin-left: 450px;
        }

        .vm-example {
            background-color: white;
            padding: 30px;
            margin: 40px auto;
            max-width: 600px;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .welcome-center {
            display: flex;
            align-items: center;
            justify-content: center;
            height: calc(100vh - 80px);
            text-align: center;
        }

        .welcome-center h2 {
            font-size: 32px;
            font-weight: bold;
            color: #004C46;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar -->
        <div class="navbar">
            <div class="navbar-left">
                <i class="fas fa-bars" id="sidebarToggle"></i>
                <img src="images/finthrive-logo.png" alt="FinThrive Logo" class="logo-img" />
            </div>
            <div class="navbar-title">
                <span>BOLT</span>
            </div>
            <div class="navbar-right">
                <button type="button" runat="server" onserverclick="Login_Click">Login</button>
                <button type="button" runat="server" onserverclick="SSO_Click">SSO</button>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="search-bar">
                <input type="text" id="vmSearch" placeholder="Search VM..." />
                <button type="button" id="searchBtn">Search</button>
            </div>
            <a href="#network" data-toggle="collapse">Network</a>
            <div id="network" class="collapse">
                <a href="#">Ping</a>
                <a href="#">DNS resolution</a>
            </div>
            <a href="#windows" data-toggle="collapse">Windows OS</a>
            <div id="windows" class="collapse">
                <a href="#">Last Boot</a>
                <a href="#">Service Status</a>
                <a href="#">Patch Status</a>
                <a href="#">Hardware Inventory</a>
                <a href="#">Software Inventory</a>
                <a href="#">Disk Space</a>
                <a href="#">Performance</a>
                <a href="#">Group Policies</a>
            </div>
            <a href="#security" data-toggle="collapse">Security</a>
            <div id="security" class="collapse">
                <a href="#">Vulnerability Check</a>
                <a href="#">Resource Explorer</a>
            </div>
            <a href="#directory" data-toggle="collapse">Directory</a>
            <div id="directory" class="collapse">
                <a href="#">OU/Object</a>
                <a href="#">Security Group</a>
                <a href="#">Domain Check</a>
            </div>
            <a href="#azure" data-toggle="collapse">Azure</a>
            <div id="azure" class="collapse">
                <a href="#">Azure VM Status</a>
                <a href="#">Azure ARC Status</a>
                <a href="#">Azure Security Centre</a>
            </div>
        </div>

        <!-- Content -->
        <div class="content" id="mainContent">
            <div id="welcomeMessage" class="welcome-center">
                <h2>Welcome to Finthrive Bolt</h2>
            </div>

            <div id="vmResults" style="display: none;">
                <div class="vm-example">
                    <h4>Sample VM: <strong>bolt-vm-01</strong></h4>
                    <p>Status: <span style="color: green; font-weight: bold;">Running</span></p>
                    <p>IP Address: 10.20.30.40</p>
                    <button class="btn btn-info">Open Console</button>
                </div>

                <div class="vm-example">
                    <h4>Sample VM: <strong>bolt-vm-02</strong></h4>
                    <p>Status: <span style="color: orange; font-weight: bold;">Idle</span></p>
                    <p>IP Address: 10.20.30.41</p>
                    <button class="btn btn-info">Open Console</button>
                </div>

                <div class="vm-example">
                    <h4>Sample VM: <strong>bolt-vm-03</strong></h4>
                    <p>Status: <span style="color: red; font-weight: bold;">Stopped</span></p>
                    <p>IP Address: 10.20.30.42</p>
                    <button class="btn btn-info">Open Console</button>
                </div>
            </div>
        </div>
    </form>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        document.getElementById("sidebarToggle").addEventListener("click", function () {
            var sidebar = document.getElementById("sidebar");
            var content = document.getElementById("mainContent");
            sidebar.classList.toggle("active");
            content.classList.toggle("shifted");
        });

        document.getElementById("searchBtn").addEventListener("click", function () {
            document.getElementById("vmResults").style.display = "block";
            var welcome = document.getElementById("welcomeMessage");
            if (welcome) welcome.style.display = "none";
        });
    </script>
</body>
</html>
