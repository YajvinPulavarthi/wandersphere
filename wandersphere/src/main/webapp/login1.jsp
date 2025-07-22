<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="loginstyle.css">
</head>
<body>
    <div class="video-container">
        <video autoplay loop muted>
            <source src="with-blue-sky.3840x2160.mp4" type="video/mp4">
        </video>
    </div>

    <div class="login-box">
        <h2 style="font-family: MyCustomFont1;">LOGIN</h2>

        <%-- Display error message if available --%>
        <% String errorMessage = (String) request.getAttribute("errorMessage");
           if (errorMessage != null) { %>
            <p style="color: red; text-align: center;"><%= errorMessage %></p>
        <% } %>

        <%-- Display success message if available --%>
        <% String successMessage = (String) request.getAttribute("successMessage");
           if (successMessage != null) { %>
            <p style="color: green; text-align: center;"><%= successMessage %></p>
        <% } %>

        <form action="LoginServlet1" method="post">
            <div class="input-box">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required>
            </div>

            <button type="submit" class="login-btn">LOGIN</button>
        </form>
        
        <p>If new user <a href="signup.jsp">Sign Up</a></p>
    </div>
</body>
</html>
