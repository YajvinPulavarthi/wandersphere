<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Package Search Results</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        position: relative;
        min-height: 100vh;
        background: url('bo3.jpg') no-repeat center center fixed;
        background-size: cover;
    }
    

    /* Overlay to darken background for readability */
    body::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: -1;
    }

    .container {
        max-width: 1200px;
        margin: auto;
        padding: 40px 20px;
    }

    h2 {
        text-align: center;
        color: #fff;
        margin-bottom: 30px;
        font-size: 40px;
        letter-spacing: 1px;
        font-family:MyCustomFont1;
    }

    .card-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }

    .card {
        background-color: rgba(255, 255, 255, 0.6);
        border-radius: 16px;
        padding: 20px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.3);
        width: 300px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
    }

    .card h3 {
        margin-top: 0;
        color: #2c3e50;
        font-size: 20px;
        font-family:MyCustomFont2;
    }

    .card p {
        margin: 6px 0;
        font-size: 14px;
        color: #333;
        font-family:MyCustomFont3;
        font-size:20px;
     }

    .book-btn {
        margin-top: 12px;
        display: inline-block;
        background-color: #2C3E50;
        color: white;
        padding: 10px 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        font-size: 14px;
    }
        .back-button {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 30px;
            text-decoration: none;
          
            color: #fff;
            padding: 10px 15px;
            border-radius: 25px;
            z-index: 1000;
          
        }

        .back-button:hover {
            background-color: #34495E;
        }
    .book-btn:hover {
        background-color: #1A242F;
    }
    @font-face {
    font-family: 'MyCustomFont1';
    src: url('fonts/Copperplate Gothic Std 29 AB/Copperplate Gothic Std 29 AB.otf') format('truetype'); /* Adjust path */
} 
    @font-face {
    font-family: 'MyCustomFont2';
    src: url('fonts/norwester.otf') format('truetype'); /* Adjust path */
} 
    @font-face {
    font-family: 'MyCustomFont3';
    src: url('fonts/Bebas_Neue/BebasNeue-Regular.ttf') format('truetype'); /* Adjust path */
} 

</style>

</head>
<body>
<a href="search.jsp" class="back-button">
    <img src="back.png" alt="Back" style="height: 50px; vertical-align: middle;">
</a>

<div class="container">
    <h2>Packages from <%= request.getAttribute("source") %> to <%= request.getAttribute("destination") %>:</h2>

    <%
        List<Map<String, Object>> packages = (List<Map<String, Object>>) request.getAttribute("packages");
        if (packages == null || packages.isEmpty()) {
    %>
        <p style="color:white; text-align:center;">No packages found for the selected criteria.</p>
    <%
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>
        <div class="card-container">
            <% for (Map<String, Object> row : packages) { %>
                <div class="card">
                    <h3>Package ID: <%= row.get("package_id") %></h3>
                    <p><strong>From:</strong> <%= row.get("source") %></p>
                    <p><strong>To:</strong> <%= row.get("destination") %></p>
                    <p><strong>Start:</strong> <%= sdf.format(row.get("start_date")) %></p>
                    <p><strong>End:</strong> <%= sdf.format(row.get("end_date")) %></p>
                    <p><strong>Slots:</strong> <%= row.get("slots") %></p>
                    <p><strong>Duration:</strong> <%= row.get("duration") %> days</p>
                    <p><strong>Services:</strong> <%= row.get("services") %></p>
                    <p><strong>Description:</strong> <%= row.get("description") %></p>
                    <form action="booking.jsp" method="get">
                        <input type="hidden" name="package_id" value="<%= row.get("package_id") %>">
                        <button class="book-btn" type="submit">Book Now</button>
                    </form>
                </div>
            <% } %>
        </div>
    <%
        }
    %>
</div>

</body>
</html>
