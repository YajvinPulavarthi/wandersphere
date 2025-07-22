<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="signstyle.css">
</head>
<body>
    <div class="video-container">
        <video autoplay loop muted>
            <source src="with-blue-sky.3840x2160.mp4" type="video/mp4">
        </video>
    </div>

    <div class="signup-box">
        <h2>SIGN UP</h2>

        <%-- Display error message if available --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red; text-align: center;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <%-- Display success message if available --%>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green; text-align: center;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <form action="SignupServlet1" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Sign Up</button>         
        </form>
        <p>If already registered, <a href="login1.jsp">Login</a></p>
    </div>
</body>
</html>
