package com.wandersphere.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");

            String query = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password); // You should hash this for security

            int rowsInserted = pst.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("successMessage", "Signup successful! Please login.");
                request.getRequestDispatcher("login1.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Signup failed. Try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}
