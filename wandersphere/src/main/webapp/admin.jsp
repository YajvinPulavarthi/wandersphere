<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('sea.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        header {
            background-color: #2c3e50;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        header a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 16px;
            background-color: #34495e;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        header a:hover {
            background-color: #1abc9c;
        }

        .dropdown {
            position: relative;
        }

        .dropdown-btn {
            background-color: #34495e;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            user-select: none;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #ecf0f1;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
            border-radius: 6px;
            margin-top: 8px;
        }

        .dropdown-content a {
            color: #fff;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            border-bottom: 1px solid #bdc3c7;
        }

        .dropdown-content a:hover {
            background-color: #d0e4ea;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .container {
            text-align: center;
            margin-top: 100px;
        }

        h1 {
            font-size: 42px;
            color: #00000;
            background-color: rgba(255, 255, 255, 0.7);
            display: inline-block;
            padding: 10px 30px;
            border-radius: 10px;
        }

        .buttons-container {
            margin-top: 60px;
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
        }

        .glass-button {
            padding: 40px;
            width: 220px;
            height: 120px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            display: flex;
            justify-content: center;
            align-items: center;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .glass-button a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
            font-size: 20px;
        }

        .glass-button:hover {
            transform: scale(1.05);
            background: rgba(255, 255, 255, 0.3);
        }
    </style>
</head>
<body>

<header>
    <div class="nav-links">
        <a href="login1.jsp">Login</a>
        <a href="signup.jsp">Signup</a>
    </div>

    <div class="nav-links">
        <div class="dropdown">
            <div class="dropdown-btn">Admin Options</div>
            <div class="dropdown-content">
                <a href="settings.jsp">Settings</a>
                <a href="dashboard.jsp">Logout</a>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <h1>Welcome, Admin</h1>

    <div class="buttons-container">
        <div class="glass-button">
            <a href="http://localhost/packages.php">Manage Packages</a>
        </div>
        <div class="glass-button">
            <a href="users.jsp">Manage Users</a>
        </div>
    </div>
</div>

</body>
</html>
