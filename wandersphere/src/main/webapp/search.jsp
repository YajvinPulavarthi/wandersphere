<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Search Packages</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: url('bo3.jpg') no-repeat center center fixed; /* Replace with your image */
            background-size: cover;
        }

        h2 {
            color: #000000;
            font-size:40px;
            margin-bottom: 20px;
            font-family: 'MyCustomFont1';
        }

        .container {
            width: 60%;
            background-color: rgba(255, 255, 255, 0.6); /* More translucent */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .row {
            display: flex;
            gap: 20px;
        }

        .col {
            flex: 1;
        }

        label {
            font-size: 16px;
            margin-bottom: 5px;
            display: block;
        }

        select, input[type="date"], input[type="text"].tall-input {
            padding: 8px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #2C3E50;
            color: #fff;
            cursor: pointer;
            border: none;
            width: 150px; /* Reduced width */
            height: 40px; /* Taller button */
            margin-left: 350px;
            font-family: 'MyCustomFont2';
            font-size:25px; /* Moves the button to the right */
        }

        input[type="submit"]:hover {
            background-color: #34495E;
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

        .chatbot-icon {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background-image: url('chatbot.png');
            background-size: cover;
            
            cursor: pointer;
         
            z-index: 1000;
        }

        .chatbot-icon:hover {
            opacity: 0.8;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1001;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            width: 80%;
            height: 80%;
       
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .modal iframe {
            width: 100%;
            height: 100%;
            border: none;
            background-image: url('bot.jpg');
            
            border-radius: 8px;
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 30px;
            color: #333;
            cursor: pointer;
            z-index: 1002;
        }

        .close-btn:hover {
            color: #E74C3C;
        }
        @font-face {
    font-family: 'MyCustomFont1';
    src: url('fonts/norwester.otf') format('truetype'); /* Adjust path */
} 
        @font-face {
    font-family: 'MyCustomFont2';
    src: url('fonts/Findel-Display-Regular.otf') format('truetype'); /* Adjust path */
} 
        @font-face {
    font-family: 'MyCustomFont3';
    src: url('fonts/Copperplate Gothic Std 29 AB/Copperplate Gothic Std 29 AB.otf') format('truetype'); /* Adjust path */
} 
    </style>
    <script>
        function openChatbot() {
            document.getElementById('chatbotModal').style.display = 'flex';
        }
        function closeChatbot() {
            document.getElementById('chatbotModal').style.display = 'none';
        }
    </script>
</head>
<body>

    <!-- Back Button -->
   <!-- Back Button -->
<a href="dashboard.jsp" class="back-button">
    <img src="back.png" alt="Back" style="height: 50px; vertical-align: middle;">
</a>


    <!-- Title -->
    <h2>Travel Packages</h2>

    <!-- Form Container -->
    <div class="container">
        <form action="SearchServlet" method="post">
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="source"style ="font-family:MyCustomFont3;font-size:35px">Source:</label>
                        <select name="source" id="source">
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT DISTINCT source FROM packages");
                                    while(rs.next()) {
                                        String city = rs.getString("source");
                            %>
                                            <option value="<%= city %>"><%= city %></option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch(Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="start_date"style ="font-family:MyCustomFont3;font-size:20px">Start Date: </label>
                        <input type="date" name="start_date" id="start_date">
                    </div>
                </div>

                <div class="col">
                    <div class="form-group">
                        <label for="destination"style ="font-family:MyCustomFont3;font-size:35px">Destination:</label>
                        <select name="destination" id="destination">
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT DISTINCT destination FROM packages");
                                    while(rs.next()) {
                                        String city = rs.getString("destination");
                            %>
                                            <option value="<%= city %>"><%= city %></option>
                            <%
                                    }
                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch(Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="end_date"style ="font-family:MyCustomFont3;font-size:20px">End Date:</label>
                        <input type="date" name="end_date" id="end_date">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <input type="submit" value="Search">
            </div>
        </form>
    </div>

    <!-- Chatbot icon -->
    <div class="chatbot-icon" onclick="openChatbot()" title="Chat with us"></div>

    <!-- Modal for the chatbot -->
    <div id="chatbotModal" class="modal">
        <div class="modal-content">
            <iframe src="chatbot.jsp"></iframe>
            <span class="close-btn" onclick="closeChatbot()">×</span>
        </div>
    </div>

</body>
</html>
