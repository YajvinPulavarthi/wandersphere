<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('1.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        header {
            background-color: #2c3e50;
            padding: 15px 30px;
            color: white;
            font-size: 20px;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }

        .section {
            background: rgba(255, 255, 255, 0.85);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .section h2 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }

        .setting-item {
            margin: 15px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .setting-item span {
            font-size: 16px;
        }

        .btn {
            padding: 6px 14px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<header>Admin Settings</header>

<div class="container">

    <div class="section">
        <h2>Profile Settings</h2>
        <div class="setting-item">
            <span>Change Name or Email</span>
            <button class="btn">Edit</button>
        </div>
        <div class="setting-item">
            <span>Update Password</span>
            <button class="btn">Change</button>
        </div>
    </div>

    <div class="section">
        <h2>Security Settings</h2>
        <div class="setting-item">
            <span>Enable Two-Factor Authentication</span>
            <button class="btn">Configure</button>
        </div>
        <div class="setting-item">
            <span>Session Timeout</span>
            <button class="btn">Set</button>
        </div>
    </div>

    <div class="section">
        <h2>Notification Preferences</h2>
        <div class="setting-item">
            <span>Email Alerts</span>
            <button class="btn">Toggle</button>
        </div>
        <div class="setting-item">
            <span>Weekly Reports</span>
            <button class="btn">Toggle</button>
        </div>
    </div>

    <div class="section">
        <h2>Appearance</h2>
        <div class="setting-item">
            <span>Theme Mode (Light/Dark)</span>
            <button class="btn">Switch</button>
        </div>
        <div class="setting-item">
            <span>Customize Layout</span>
            <button class="btn">Edit</button>
        </div>
    </div>

    <div class="section">
        <h2>Backup & Restore</h2>
        <div class="setting-item">
            <span>Manual Backup</span>
            <button class="btn">Backup Now</button>
        </div>
        <div class="setting-item">
            <span>Restore Previous Version</span>
            <button class="btn">Restore</button>
        </div>
    </div>

</div>

</body>
</html>
