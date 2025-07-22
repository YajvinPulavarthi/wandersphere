<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.net.URLEncoder, java.net.URLDecoder" %>

<%
    String sessionId = session.getId();
    Date currentDate = new Date();
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentLogin = formatter.format(currentDate);

    // Get previous login from cookie
    String previousLogin = "First login!";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("lastLogin".equals(c.getName())) {
                previousLogin = URLDecoder.decode(c.getValue(), "UTF-8");
            }
        }
    }

    // Set current login as cookie for next time
    Cookie loginCookie = new Cookie("lastLogin", URLEncoder.encode(currentLogin, "UTF-8"));
    loginCookie.setMaxAge(60 * 60 * 24); // 1 day
    response.addCookie(loginCookie);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Session Information</title>
    <style>
        body {
            background: linear-gradient(to right, #2980b9, #6dd5fa);
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 100px;
        }
        .info {
            background: rgba(0,0,0,0.5);
            padding: 30px;
            display: inline-block;
            border-radius: 10px;
        }
        h1 {
            font-size: 32px;
            margin-bottom: 20px;
        }
        p {
            font-size: 20px;
            margin: 10px 0;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #fff;
            background: #3498db;
            padding: 10px 20px;
            border-radius: 8px;
            transition: 0.3s;
        }
        a:hover {
            background: #1abc9c;
        }
    </style>
</head>
<body>
    <div class="info">
        <h1>Session Information</h1>
        <p><strong>Session ID:</strong> <%= sessionId %></p>
        <p><strong>Current Login:</strong> <%= currentLogin %></p>
        <p><strong>Previous Login:</strong> <%= previousLogin %></p>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
