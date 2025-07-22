package com.wandersphere.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet1 extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String dbURL = "jdbc:mysql://localhost:3306/wandersphere";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query only by username
            String sql = "SELECT password, role FROM users WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);

            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String role = rs.getString("role");

                // Password validation
                if (storedPassword != null && storedPassword.equals(password)) {
                    // Normalize role to lowercase
                    if (role != null) {
                        role = role.toLowerCase();
                    }

                    // Store user info in session
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // Role-based redirection
                    if ("admin".equals(role)) {
                        response.sendRedirect("admin.jsp");
                    } else if ("user".equals(role)) {
                        response.sendRedirect("search.jsp");
                    } else {
                        // If role is unknown
                        response.sendRedirect("login1.jsp?error=roleunknown");
                    }

                } else {
                    // Password mismatch
                    response.sendRedirect("login1.jsp?error=invalid");
                }

            } else {
                // Username not found
                response.sendRedirect("login1.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login1.jsp?error=exception");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
