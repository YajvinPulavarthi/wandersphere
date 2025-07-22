<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*, java.util.*" %>
<%@ page isELIgnored="true" %>
<%
String packageIdStr = request.getParameter("package_id");
String hotelName = request.getParameter("hotel_name");
String totalPriceStr = request.getParameter("hidden_total_price");
String durationStr = request.getParameter("duration");
String destination = request.getParameter("destination");

String source = "";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
    PreparedStatement stmt = conn.prepareStatement("SELECT source FROM packages WHERE package_id = ?");
    stmt.setInt(1, Integer.parseInt(packageIdStr));
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        source = rs.getString("source");
    }
    rs.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    source = "Unavailable";
}
%>

<html>
<head>
    <title>Payment Page</title>
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
            background: url('bo3.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .main {
            display: flex;
            justify-content: space-between;
            gap: 30px; /* space between containers */
            max-width: 1000px;
            margin: auto;
        }
        .payment-options, .booking-summary {
            padding: 30px;
            width: 50%;
            background-color: rgba(255, 255, 255, 0.9); /* slightly transparent white */
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-top:100px;
            margin-right:50px;
        }
        .payment-options {
            border-right: 1px solid #ddd;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
             font-family: 'MyCustomFont2';
             font-size:35px;
            
        }
                @font-face {
    font-family: 'MyCustomFont1';
    src: url('fonts/garet.book.ttf') format('truetype'); /* Adjust path */
} 
    @font-face {
    font-family: 'MyCustomFont2';
    src: url('fonts/norwester.otf') format('truetype'); /* Adjust path */
} 
        @font-face {
    font-family: 'MyCustomFont3';
    src: url('fonts/TT Drugs Trial Light.otf') format('truetype'); /* Adjust path */
} 
  
        label {
        font-family: 'MyCustomFont1';
            font-weight: bold;
            display: block;
            margin-top: 15px;
            font-size:20px;
        }
        p{
        font-familt:'MyCustomFont3';
        }
        
        input[type="radio"] {
            margin-right: 10px;
        }
        .booking-summary label {
            font-weight: bold;
        }
        .info-box {
            margin-bottom: 10px;
        }
        .info-box span {
            font-weight: normal;
            color: #555;
        }
        .btn {
            margin-top: 20px;
            width: 100%;
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #34495e;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            position: relative;
            text-align: center;
        }
        .modal-content input {
            width: 100%;
            margin: 10px 0;
            padding: 10px;
        }
        .modal-content a {
            display: block;
            margin: 10px 0;
            padding: 10px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .modal-content a:hover {
            background: #2980b9;
        }
        .close-btn {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 24px;
            cursor: pointer;
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
    </style>
</head>
<body>
<a href="booking.jsp" class="back-button">
    <img src="back.png" alt="Back" style="height: 50px; vertical-align: middle;">
</a>

<div class="main">
    <div class="payment-options">
        <h2>Select Payment Method</h2>
        <form id="paymentForm">
            <label><input type="radio" name="payment_method" value="UPI" required onclick="togglePaymentOption('UPI')"> UPI</label>
            <label><input type="radio" name="payment_method" value="Credit Card" onclick="togglePaymentOption('Card')"> Credit Card</label>
            <label><input type="radio" name="payment_method" value="Debit Card" onclick="togglePaymentOption('Card')"> Debit Card</label>
            <label><input type="radio" name="payment_method" value="Net Banking" onclick="togglePaymentOption('NetBanking')"> Net Banking</label>

            <label for="num_people">Number of People:</label>
            <input type="number" name="num_people" id="num_people" min="1" value="1" required onchange="updateTotalPrice()">

            <input type="hidden" name="package_id" value="<%= packageIdStr %>">
            <input type="hidden" name="hotel_name" value="<%= hotelName %>">
            <input type="hidden" name="total_price" id="hidden_total_price" value="<%= totalPriceStr %>">
            <input type="hidden" name="duration" value="<%= durationStr %>">
            <input type="hidden" name="destination" value="<%= destination %>">
            <input type="hidden" name="source" value="<%= source %>">

            <button type="submit" class="btn">Pay Now</button>
            <div id="errorMsg" style="color: red; margin-top: 10px;"></div>
        </form>
    </div>

    <div class="booking-summary">
        <h2>Booking Summary</h2>
        <div class="info-box"><label>Package ID: <span><%= packageIdStr %></span></label></div>
        <div class="info-box"><label>Source: <span><%= source %></span></label></div>
        <div class="info-box"><label>Destination: <span><%= destination %></span></label></div>
        <div class="info-box"><label>Hotel: <span><%= hotelName %></span></label></div>
        <div class="info-box"><label>Duration: <span><%= durationStr %> days</span></label></div>
        <div class="info-box"><label>Base Total Price: <span id="total_price_display">₹<%= totalPriceStr %></span></label></div>
    </div>
</div>

<!-- Modals -->
<div id="upi-qr-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal('upi-qr-modal')">×</span>
        <h3>Scan the QR Code to pay:</h3>
        <img src="qr.png" alt="QR Code" style="width: 100%; height: auto;">
    </div>
</div>

<div id="card-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal('card-modal')">×</span>
        <h3>Enter Card Details</h3>
        <label>Card Number:</label>
        <input type="text" maxlength="16" placeholder="1234 5678 9012 3456">
        <label>CVV:</label>
        <input type="text" maxlength="3" placeholder="123">
        <label>Expiry Date:</label>
        <input type="month">
    </div>
</div>

<div id="netbanking-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal('netbanking-modal')">×</span>
        <h3>Select Your Bank</h3>
        <a href="https://www.hdfcbank.com/">HDFC Bank</a>
        <a href="https://www.icicibank.com/">ICICI Bank</a>
        <a href="https://onlinesbi.sbi/">State Bank of India</a>
        <a href="https://www.axisbank.com/">Axis Bank</a>
    </div>
</div>

<script>
function togglePaymentOption(option) {
    closeAllModals();
    if (option === 'UPI') openModal('upi-qr-modal');
    else if (option === 'Card') openModal('card-modal');
    else if (option === 'NetBanking') openModal('netbanking-modal');
}

function openModal(id) {
    document.getElementById(id).style.display = 'block';
}

function closeModal(id) {
    document.getElementById(id).style.display = 'none';
}

function closeAllModals() {
    closeModal('upi-qr-modal');
    closeModal('card-modal');
    closeModal('netbanking-modal');
}

function updateTotalPrice() {
    let basePrice = parseFloat('<%= totalPriceStr %>');
    let numPeople = document.getElementById('num_people').value;
    if (isNaN(numPeople) || numPeople <= 0) numPeople = 1;
    let totalPrice = basePrice * parseInt(numPeople);
    document.getElementById('total_price_display').textContent = "₹" + totalPrice;
    document.getElementById('hidden_total_price').value = totalPrice.toFixed(2);
}

document.getElementById("paymentForm").addEventListener("submit", function(e) {
    e.preventDefault();

    const form = e.target;
    const formData = new FormData(form);

    fetch("ConfirmPaymentServlet", {
        method: "POST",
        body: formData
    })
    .then(response => {
        if (response.redirected) {
            window.location.href = response.url;
        } else {
            return response.text();
        }
    })
    .then(data => {
        if (data) {
            document.getElementById("errorMsg").innerHTML = data;
        }
    })
    .catch(error => {
        document.getElementById("errorMsg").innerHTML = "An unexpected error occurred.";
        console.error("AJAX error:", error);
    });
});
</script>

</body>
</html>
