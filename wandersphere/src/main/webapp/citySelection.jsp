<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>City Selection</title>
  <link rel="stylesheet" type="text/css" href="Selectionstyle.css">
  <script src="Selectionscript.js" defer></script>
  <style>
    .image-button {
      position: fixed;
      bottom: 10px;
      left: 10px;
    }

    .image-button img {
      width: 50px;
      height: 50px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Select Source and Destination</h2>
    <form onsubmit="return handleSelection(event)">
      <label for="source">Source:</label>
      <select id="source" name="source" required>
        <option value="">--Select Source--</option>
        <option value="Delhi">Delhi</option>
        <option value="Mumbai">Mumbai</option>
        <option value="Chennai">Chennai</option>
        <option value="Kolkata">Kolkata</option>
        <option value="Bangalore">Bangalore</option>
      </select>

      <label for="destination">Destination:</label>
      <select id="destination" name="destination" required>
        <option value="">--Select Destination--</option>
        <option value="Delhi">Delhi</option>
        <option value="Mumbai">Mumbai</option>
        <option value="Chennai">Chennai</option>
        <option value="Kolkata">Kolkata</option>
        <option value="Bangalore">Bangalore</option>
      </select>

      <div class="buttons">
        <input type="submit" value="Submit">
        <button type="button" onclick="goBack()">Back</button>
        <button type="button" onclick="logout()">Logout</button>
      </div>

      <p id="statusMessage" class="success-message"></p>
    </form>
  </div>

  <<div class="image-button">
  <img src="your-image.png" alt="Button" onclick="window.location.href='chatbot.jsp'">
</div>

</body>
</html>
