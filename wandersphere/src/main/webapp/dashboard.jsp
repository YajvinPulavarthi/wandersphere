<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DashBoard</title>
    <link rel="stylesheet" href="dashstyle.css">      
    <script>
        function getCookie(name) {
            let cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                let cookie = cookies[i].trim();
                if (cookie.startsWith(name + "=")) {
                    return cookie.split('=')[1];
                }
            }
            return "0";
        }

        function updateVisitCount() {
            fetch('VisitCounterServlet') 
            .then(response => response.text())
            .then(() => {
                let visitCount = getCookie("visitCount");
                alert("You have visited this site " + visitCount + " times.");
            });
        }

        window.onload = updateVisitCount;
    </script>
</head>
<body>
    <p class="p1">WanderSphere</p>

    <nav>
        <button onmouseover="this.style.background='white'; this.style.color='black';" 
                onmouseout="this.style.background='rgba(255, 255, 255, 0.2)'; this.style.color='white';">
            <a href="login1.jsp">Login</a>
        </button>
        <button onmouseover="this.style.background='white'; this.style.color='black';" 
                onmouseout="this.style.background='rgba(255, 255, 255, 0.2)'; this.style.color='white';">
            <a href="signup.jsp">Sign Up</a>
        </button>
        <button onmouseover="this.style.background='white'; this.style.color='black';" 
                onmouseout="this.style.background='rgba(255, 255, 255, 0.2)'; this.style.color='white';">
            <a href="sessioninfo.jsp">Session Info</a>
        </button>
    </nav>

    <div class="social">
        <a href="https://www.instagram.com/">
            <img class="social-img" src="insta.png" alt="Instagram">
        </a>
        <a href="https://www.x.com/">
            <img class="social-img" src="x.png" alt="X">
        </a>
        <a href="https://www.linkedin.com/">
            <img class="social-img" src="linkedin.png" alt="LinkedIn">
        </a>
        <a href="https://www.youtube.com/">
            <img class="social-img" src="yt.png" alt="YouTube">
        </a>
    </div>

    <p class="p2">
        -Plan your travels, roam with grace, <br>
        Discover wonders in every place.  
        From ancient lands to oceans blue,  
        The world awaits—with dreams for you!<br>
    </p>
</body>
</html>
