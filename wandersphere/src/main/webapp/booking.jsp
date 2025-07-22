<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page isELIgnored="true" %>

<html>
<head>
    <title>Package Booking</title>
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

        .container {
            background-color: rgba(255, 255, 255, 0.55);
            padding: 20px;
            border-radius: 10px;
            max-width: 700px;
            width: 90%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
        font-family: 'MyCustomFont5';
            text-align: center;
            color: #000;
            font-size:50px
        }

        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 15px;
        }

        .form-group label {
            flex: 1;
            font-weight: bold;
            margin-right: 10px;
              font-family: 'MyCustomFont1';
              font-size:20px;
        }

        .form-group input,
        .form-group select {
            flex: 2;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[readonly] {
            background-color: #f5f5f5;
        }

.btn {
    margin-top: 25px;
    width: 200px; /* Reduced width */
    background-color: #2c3e50;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    display: block;
    margin-left: auto;
    margin-right: auto;
      font-family: 'MyCustomFont2';
      font-size:20px;
}


        .btn:hover {
            background-color: #34495e;
        }
        @font-face {
    font-family: 'MyCustomFont5';
    src: url('fonts/Smythe/Smythe-Regular.ttf') format('truetype'); /* Adjust path */
} 
        @font-face {
    font-family: 'MyCustomFont1';
    src: url('fonts/TT Drugs Trial Regular.otf') format('truetype'); /* Adjust path */
} 
        @font-face {
    font-family: 'MyCustomFont2';
    src: url('fonts/garet.book.ttf') format('truetype'); /* Adjust path */
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
<a href="search.jsp" class="back-button">
    <img src="back.png" alt="Back" style="height: 50px; vertical-align: middle;">
</a>

<div class="container">
    <h2>Book Your Package</h2>

    <form action="payment.jsp" method="post">

        <div class="form-group">
            <label for="package_id">Package ID:</label>
            <input type="number" id="package_id" name="package_id" required onblur="fetchPackageDetails()">
        </div>

        <div class="form-group">
            <label for="destination">Select Destination:</label>
            <select id="destination" name="destination" required onchange="updateHotelOptions(); fetchPackageDetails();">
                <option value="">Select Destination</option>
                <%  
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT DISTINCT destination FROM packages");
                        while (rs.next()) {
                            String city = rs.getString("destination");
                %>
                            <option value="<%= city %>"><%= city %></option>
                <% 
                        }
                        rs.close(); stmt.close(); conn.close();
                    } catch (Exception e) {
                        out.println("<option>Error Loading Destinations</option>");
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label for="hotel_name">Select Hotel:</label>
            <select id="hotel_name" name="hotel_name" required>
                <option value="">Select Hotel</option>
            </select>
        </div>

        <div class="form-group">
            <label for="duration">Duration (days):</label>
            <input type="text" id="duration" name="duration" readonly required>
        </div>

        <div class="form-group">
            <label for="total_price">Total Price:</label>
            <input type="text" id="total_price" name="total_price" readonly required>
            <input type="hidden" id="raw_total_price" name="hidden_total_price">
        </div>

        <button type="submit" class="btn">Book Now</button>
    </form>
</div>

<script>
    let hotelPriceMap = {};

    function updateHotelOptions() {
        let destination = document.getElementById('destination').value;
        let hotelSelect = document.getElementById('hotel_name');
        hotelSelect.innerHTML = '<option value="">Select Hotel</option>';

        if (destination) {
            fetch('HotelListServlet?destination=' + encodeURIComponent(destination))
                .then(response => response.json())
                .then(data => {
                    hotelPriceMap = {};
                    if (data.length > 0) {
                        data.forEach(hotel => {
                            let option = document.createElement('option');
                            option.value = hotel.hotel_name;
                            option.textContent = `${hotel.hotel_name} (₹${hotel.price_per_night} per night)`;
                            hotelSelect.appendChild(option);

                            hotelPriceMap[hotel.hotel_name] = hotel.price_per_night;
                        });
                    } else {
                        hotelSelect.innerHTML = '<option>No hotels found</option>';
                    }
                })
                .catch(err => console.error('Error loading hotels:', err));
        }
    }

    function fetchPackageDetails() {
        let packageId = document.getElementById('package_id').value;
        if (packageId) {
            fetch(`PackageDetailsServlet?package_id=${encodeURIComponent(packageId)}`)
                .then(response => response.json())
                .then(data => {
                    if (data.destination) {
                        let destinationSelect = document.getElementById('destination');
                        let options = destinationSelect.options;
                        for (let i = 0; i < options.length; i++) {
                            if (options[i].value === data.destination) {
                                destinationSelect.selectedIndex = i;
                                break;
                            }
                        }
                        updateHotelOptions();
                    }

                    if (data.duration) {
                        document.getElementById('duration').value = data.duration;
                        calculateTotalPrice();
                    } else {
                        document.getElementById('duration').value = "";
                    }
                })
                .catch(err => console.error('Error fetching package details:', err));
        }
    }

    function calculateTotalPrice() {
        let selectedHotel = document.getElementById('hotel_name').value;
        let duration = parseInt(document.getElementById('duration').value);

        if (selectedHotel && duration && hotelPriceMap[selectedHotel]) {
            let pricePerNight = hotelPriceMap[selectedHotel];
            document.getElementById('total_price').value = "₹" + (pricePerNight * duration);
            document.getElementById('raw_total_price').value = pricePerNight * duration;
        } else {
            document.getElementById('total_price').value = "";
        }
    }

    document.getElementById('hotel_name').addEventListener('change', calculateTotalPrice);
</script>

</body>
</html>
