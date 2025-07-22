<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/wandersphere";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE user_id = ?");
            ps.setInt(1, Integer.parseInt(deleteId));
            ps.executeUpdate();
            ps.close();
            conn.close();
            response.sendRedirect("users.jsp");
            return;
        } catch (Exception e) {
            out.println("Error deleting user: " + e.getMessage());
        }
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM users");
%>
<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: url('2.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: transparent;
            z-index: -1;
        }

        h2 {
            text-align: center;
            color: #000;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px auto;
            width: 80%;
        }

        .add-btn {
            padding: 10px 20px;
            background: #3f51b5;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-box {
            width: 250px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #aaa;
        }

        .users-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .user-container {
            background: rgba(255, 255, 255, 0.85);
            border-left: 5px solid #3f51b5;
            width: 45%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .user-container:hover {
            transform: scale(1.02);
        }

        .user-container h3 { margin: 0 0 10px; }
        .user-info p { margin: 5px 0; color: #555; }

        .action-buttons {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }

        .user-action-btn {
            width: 80px;
            height: 40px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
        }

        .modify-btn {
            background-color: #4CAF50;
        }

        .delete-btn {
            background-color: #f44336;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 10;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.95);
            margin: 8% auto;
            padding: 20px;
            width: 50%;
            border-radius: 8px;
            position: relative;
        }

        .close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 20px;
            cursor: pointer;
            color: red;
        }

        .form-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .form-group input {
            flex: 1;
            padding: 8px;
            border: 1px solid #aaa;
            border-radius: 4px;
        }

        .form-group i {
            margin-left: 10px;
            color: #888;
            cursor: pointer;
        }

        .form-group input[readonly] {
            background-color: #f0f0f0;
            border: none;
        }

        .submit-btn {
            background: #3f51b5;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>

    <script>
        function openModal(userId, username, email, role) {
            document.getElementById('modal').style.display = 'block';
            document.getElementById('uid').value = userId;
            document.getElementById('username').value = username;
            document.getElementById('email').value = email;
            document.getElementById('role').value = role;
        }

        function openAddModal() {
            document.getElementById('addModal').style.display = 'block';
        }

        function closeModal(id) {
            document.getElementById(id).style.display = 'none';
        }

        function enableEdit(fieldId) {
            document.getElementById(fieldId).removeAttribute('readonly');
            document.getElementById(fieldId).focus();
        }

        function filterUsers() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let users = document.getElementsByClassName("user-container");
            for (let user of users) {
                let username = user.querySelector("h3").innerText.toLowerCase();
                user.style.display = username.includes(input) ? "block" : "none";
            }
        }
    </script>
</head>
<body>

<h2>User Management</h2>

<div class="top-bar">
    <div>
        <button class="add-btn" style="background-color: #888;" onclick="window.location.href='admin.jsp'">⬅ Back</button>
    </div>
    <input type="text" id="searchInput" class="search-box" placeholder="Search username..." onkeyup="filterUsers()" />
    <div>
        <button class="add-btn" onclick="openAddModal()">➕ Add User</button>
    </div>
</div>

<div class="users-grid">
<%
    while (rs.next()) {
%>
    <div class="user-container">
        <h3><%= rs.getString("username") %></h3>
        <div class="user-info">
            <p>Email: <%= rs.getString("email") %></p>
            <p>Role: <%= rs.getString("role") %></p>
        </div>
        <div class="action-buttons">
            <button class="user-action-btn modify-btn" onclick="openModal('<%= rs.getInt("user_id") %>', '<%= rs.getString("username") %>', '<%= rs.getString("email") %>', '<%= rs.getString("role") %>')">Modify</button>
            <form method="get" action="users.jsp" onsubmit="return confirm('Are you sure?');" style="flex: 1;">
                <input type="hidden" name="deleteId" value="<%= rs.getInt("user_id") %>">
                <button class="user-action-btn delete-btn" type="submit">Delete</button>
            </form>
        </div>
    </div>
<%
    }
%>
</div>

<!-- Update Modal -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('modal')">&times;</span>
        <h3>Modify User</h3>
        <form method="post" action="updateUser.jsp">
            <input type="hidden" name="user_id" id="uid" />
            <div class="form-group">
                <input type="text" name="username" id="username" readonly />
                <i class="fa fa-pencil" onclick="enableEdit('username')"></i>
            </div>
            <div class="form-group">
                <input type="email" name="email" id="email" readonly />
                <i class="fa fa-pencil" onclick="enableEdit('email')"></i>
            </div>
            <div class="form-group">
                <input type="text" name="role" id="role" readonly />
                <i class="fa fa-pencil" onclick="enableEdit('role')"></i>
            </div>
            <button type="submit" class="submit-btn">Update</button>
        </form>
    </div>
</div>

<!-- Add Modal -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('addModal')">&times;</span>
        <h3>Add New User</h3>
        <form method="post" action="addUser.jsp">
            <div class="form-group">
                <input type="text" name="username" placeholder="Username" required />
            </div>
            <div class="form-group">
                <input type="email" name="email" placeholder="Email" required />
            </div>
            <div class="form-group">
                <input type="password" name="password" placeholder="Password" required />
            </div>
            <div class="form-group">
                <input type="text" name="role" placeholder="Role" value="user" required />
            </div>
            <button type="submit" class="submit-btn">Add User</button>
        </form>
    </div>
</div>

</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
