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
            background-color: #004C46;
            padding: 10px 30px;
            /*height: 60px;*/
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1050;
        }

        .logo-img {
            height: 36px;
            width: auto;
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
        }

        .navbar-right button:hover {
            background-color: #004040;
        }

        /* Center Search Section */
        .search-section {
            margin-top: 80px;
            padding: 30px 0;
            text-align: center;
        }

        .search-section .search-box {
            background-color: white;
            border-radius: 12px;
            padding: 30px;
            width: 500px;
            margin: 0 auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border: 2px solid #e0e0e0;
        }

        .search-section input[type="text"] {
            width: 100%;
            height: 60px;
            padding: 12px 20px;
            font-size: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
            cursor: pointer; /* show pointer since readonly */
            background-color: #fff;
        }

        .search-section input[type="text"]:hover {
            border-color: #004C46;
        }

        .search-section button {
            width: 100%;
            height: 50px;
            font-size: 16px;
            background-color: #004C46;
            color: white;
            border: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .search-section button:hover {
            background-color: #00665a;
        }

        /* Sidebar */
        .sidebar {
            height: calc(100vh - 60px);
            width: 280px; /* reduced width */
            position: fixed;
            top: 60px;
            left: -280px; /* hidden by default */
            background-color: #1f2d2d;
            padding-top: 20px;
            transition: left 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar.active {
            left: 0;
        }

        /* Main sidebar links with icons */
        .sidebar a[data-toggle="collapse"] {
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: bold;
            color: #ffffff;
            transition: all 0.3s ease;
        }

        .sidebar a[data-toggle="collapse"]:hover {
            background-color: #2d3e3e;
            padding-left: 25px;
            color: #ffffff;
        }

        /* Submenu links: with icons, smaller size */
        .sidebar .collapse a {
            padding: 8px 20px 8px 45px; /* indent for icons */
            text-decoration: none;
            font-size: 14px;
            color: #a8c3c3;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .sidebar .collapse a:hover {
            background-color: #2d3e3e;
            padding-left: 50px;
            color: #ffffff;
        }

        /* Icon size fix */
        .sidebar a i {
            width: 20px;
            text-align: center;
        }

        /* Content */
        .content {
            margin-top: 20px;
            padding: 20px;
            transition: margin-left 0.3s ease;
            margin-left: 0; /* default no sidebar */
        }

        .content.shifted {
            margin-left: 280px; /* match sidebar width */
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

        .vm-container {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            justify-content: center;
            padding: 20px 0;
        }

        .vm-example {
            background: linear-gradient(135deg, #ffffff, #f4f4f4);
            background-image: url('https://www.transparenttextures.com/patterns/white-wall-3.png');
            background-blend-mode: overlay;
            padding: 30px;
            flex: 1 1 300px;
            max-width: 380px;
            border-radius: 12px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .vm-example:hover {
            transform: scale(1.015);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.15);
        }

        .vm-example h4 {
            font-size: 20px;
            font-weight: 700;
            color: #004C46;
        }

        .vm-example p {
            font-size: 16px;
            color: #333;
        }

        .vm-example button {
            margin-top: 15px;
            padding: 8px 18px;
            font-size: 15px;
            background-color: #004C46;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .vm-example button:hover {
            background-color: #00665a;
        }

        /* Modal Styles */
        #vmModal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #vmModal .modal-content {
            background: #fff;
            padding: 25px 30px;
            border-radius: 12px;
            width: 500px;
            max-width: 90%;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            text-align: center;
        }

        #vmModal textarea {
            width: 100%;
            height: 150px;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
            resize: vertical;
        }

        #vmModal .modal-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            gap: 12px;
        }

        #vmModal button {
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        #vmModal #vmModalOk {
            background: #004C46;
            color: white;
        }

        #vmModal #vmModalCancel {
            background: #ccc;
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

        <!-- Search Section -->
        <div class="search-section">
            <div class="search-box">
                <input type="text" id="vmSearchInput" placeholder="Click here to enter VM names (comma separated)" readonly />
                <button type="button" id="searchBtn">Search</button>
            </div>
        </div>

        <!-- Modal for entering VM names -->
        <div id="vmModal">
            <div class="modal-content">
                <h4>Enter VM Names</h4>
                <textarea id="vmModalInput" placeholder="bolt-vm-01, bolt-vm-02..."></textarea>
                <div class="modal-buttons">
                    <button type="button" id="vmModalOk">OK</button>
                    <button type="button" id="vmModalCancel">Cancel</button>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <a href="#network" data-toggle="collapse">
                <i class="fas fa-network-wired"></i> Network
            </a>
            <div id="network" class="collapse">
                <a href="#"><i class="fas fa-wifi"></i> Ping</a>
                <a href="#"><i class="fas fa-search"></i> DNS resolution</a>
            </div>
            <a href="#windows" data-toggle="collapse">
                <i class="fas fa-desktop"></i> Windows OS
            </a>
            <div id="windows" class="collapse">
                <a href="#"><i class="fas fa-history"></i> Last Boot</a>
                <a href="#"><i class="fas fa-cogs"></i> Service Status</a>
                <a href="#"><i class="fas fa-tools"></i> Patch Status</a>
                <a href="#"><i class="fas fa-microchip"></i> Hardware Inventory</a>
                <a href="#"><i class="fas fa-box-open"></i> Software Inventory</a>
                <a href="#"><i class="fas fa-hdd"></i> Disk Space</a>
                <a href="#"><i class="fas fa-tachometer-alt"></i> Performance</a>
                <a href="#"><i class="fas fa-user-shield"></i> Group Policies</a>
            </div>
            <a href="#security" data-toggle="collapse">
                <i class="fas fa-shield-alt"></i> Security
            </a>
            <div id="security" class="collapse">
                <a href="#"><i class="fas fa-bug"></i> Vulnerability Check</a>
                <a href="#"><i class="fas fa-search-plus"></i> Resource Explorer</a>
            </div>
            <a href="#directory" data-toggle="collapse">
                <i class="fas fa-sitemap"></i> Directory
            </a>
            <div id="directory" class="collapse">
                <a href="#"><i class="fas fa-folder"></i> OU/Object</a>
                <a href="#"><i class="fas fa-users"></i> Security Group</a>
                <a href="#"><i class="fas fa-globe"></i> Domain Check</a>
            </div>
            <a href="#azure" data-toggle="collapse">
                <i class="fab fa-microsoft"></i> Azure
            </a>
            <div id="azure" class="collapse">
                <a href="#"><i class="fas fa-server"></i> Azure VM Status</a>
                <a href="#"><i class="fas fa-cloud"></i> Azure ARC Status</a>
                <a href="#"><i class="fas fa-shield-virus"></i> Azure Security Centre</a>
            </div>
        </div>

        <!-- Content -->
        <div class="content" id="mainContent">
            <div id="welcomeMessage" class="welcome-center">
                <h2>Welcome to Finthrive Bolt</h2>
            </div>

            <div id="vmResults" style="display: none;">
                <div class="vm-container">
                    <% 
                        for (int i = 1; i <= 40; i++) {
                            string vmName = "bolt-vm-" + i.ToString("00");
                    %>
                  <div class="vm-example">
                        <h4>Sample VM: <strong><%= vmName %></strong></h4>

                        <p>Status: <span style="color: green; font-weight: bold;">Running</span></p>

                        <p>IP Address: 10.20.30.<%= 10 + i %></p>

                        <p><strong>Network:</strong> Ping: Success, DNS: <%= vmName %>.domain.local</p>

                        <p><strong>Windows OS:</strong> Last Boot: 2025-06-23 10:4<%= i %> AM, Services OK: 45/47, Patches: Up to date</p>

                        <p><strong>Hardware:</strong> CPU: Intel Xeon, RAM: 16GB</p>

                        <p><strong>Disk Space:</strong> 120 GB used / 250 GB total (48%)</p>

                        <p><strong>Performance:</strong> CPU: 23%, Memory: 45%</p>

                        <p><strong>Security:</strong> Vulnerabilities: 0, Security Alerts: None</p>

                        <p><strong>Directory:</strong> OU: Sales, Domain Joined: Yes</p>

                        <p><strong>Azure:</strong> VM State: Running, ARC: Healthy, Security Center: Compliant</p>

                        <button class="btn btn-info">Open Console</button>
                    </div>

                    <% } %>
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

        // Show modal when clicking search input
        document.getElementById("vmSearchInput").addEventListener("click", function () {
            document.getElementById("vmModal").style.display = "flex";
            document.getElementById("vmModalInput").value = this.value;
            document.getElementById("vmModalInput").focus();
        });

        // Modal OK button: copy textarea to input and close modal
        document.getElementById("vmModalOk").addEventListener("click", function () {
            var val = document.getElementById("vmModalInput").value.trim();
            document.getElementById("vmSearchInput").value = val;
            document.getElementById("vmModal").style.display = "none";
        });

        // Modal Cancel button: just close modal
        document.getElementById("vmModalCancel").addEventListener("click", function () {
            document.getElementById("vmModal").style.display = "none";
        });

        // Search button click handler
        document.getElementById("searchBtn").addEventListener("click", function () {
            const input = document.getElementById("vmSearchInput").value.trim();
            if (input !== "") {
                document.getElementById("vmResults").style.display = "block";
                const welcome = document.getElementById("welcomeMessage");
                if (welcome) welcome.style.display = "none";
            } else {
                alert("Please enter a VM name to search.");
            }
        });
    </script>
</body>
</html>
