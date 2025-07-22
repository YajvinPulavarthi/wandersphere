<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Packages</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 20px;
            background: url('ss.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        h1 {
            text-align: center;
            color: #00000;
        }

        .packages-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .package-container {
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            width: calc(50% - 30px);
            box-sizing: border-box;
            transition: transform 0.2s ease;
        }

        .package-container:hover {
            transform: scale(1.01);
        }

        .package-detail {
            margin: 5px 0;
            font-size: 16px;
        }

        .modify-button, .delete-button {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #2980b9;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .modify-button:hover {
            background-color: #1abc9c;
        }

        .delete-button {
            background-color: #e74c3c;
            margin-left: 10px;
        }

        .delete-button:hover {
            background-color: #c0392b;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border-radius: 12px;
            width: 50%;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .submit-btn {
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            border: none;
        }

        .submit-btn:hover {
            background-color: #1abc9c;
        }
    </style>
</head>
<body>

<h1>Available Packages</h1>

<!-- Back Button -->
<div style="text-align: left; margin-top: 40px;">
    <button onclick="window.location.href='http://localhost:8080/wandersphere/admin.jsp'" class="submit-btn" style="background-color: #888;">
        ⬅ Back
    </button>
</div>

<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wandersphere";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("<p style='text-align:center; color:red;'>Connection failed: " . $conn->connect_error . "</p>");
}

// Handle Delete
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];
    $sql_delete = "DELETE FROM packages WHERE package_id = $delete_id";
    if ($conn->query($sql_delete) === TRUE) {
        echo "<p style='text-align:center;'>Package deleted successfully.</p>";
    } else {
        echo "<p style='text-align:center;'>Error deleting package: " . $conn->error . "</p>";
    }
}

// Handle Add
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $source = $_POST['source'];
    $destination = $_POST['destination'];
    $start_date = $_POST['start_date'];
    $end_date = $_POST['end_date'];

    $sql_insert = "INSERT INTO packages (source, destination, start_date, end_date)
                   VALUES ('$source', '$destination', '$start_date', '$end_date')";

    if ($conn->query($sql_insert) === TRUE) {
        echo "<p style='text-align:center;'>Package added successfully.</p>";
    } else {
        echo "<p style='text-align:center;'>Error adding package: " . $conn->error . "</p>";
    }
}

// Display Packages
$sql = "SELECT * FROM packages";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<div class='packages-wrapper'>";
    while ($row = $result->fetch_assoc()) {
        echo "<div class='package-container'>";
        echo "<div class='package-detail'><strong>Package ID:</strong> " . $row["package_id"] . "</div>";
        echo "<div class='package-detail'><strong>Source:</strong> " . $row["source"] . "</div>";
        echo "<div class='package-detail'><strong>Destination:</strong> " . $row["destination"] . "</div>";
        echo "<div class='package-detail'><strong>Start Date:</strong> " . $row["start_date"] . "</div>";
        echo "<div class='package-detail'><strong>End Date:</strong> " . $row["end_date"] . "</div>";
        echo "<a class='modify-button' href='modify_package.php?package_id=" . $row["package_id"] . "'>Modify</a>";
        echo "<a class='delete-button' href='packages.php?delete_id=" . $row["package_id"] . "'>Delete</a>";
        echo "</div>";
    }
    echo "</div>";
} else {
    echo "<p style='text-align:center;'>No packages found.</p>";
}

$conn->close();
?>

<!-- Add Package Button -->
<button id="addPackageBtn" class="submit-btn" style="display:block; margin: 20px auto;">Add Package</button>

<!-- Modal to Add Package -->
<div id="addPackageModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Add a New Package</h2>
        <form action="" method="POST">
            <input type="text" name="source" class="modal-input" placeholder="Source" required>
            <input type="text" name="destination" class="modal-input" placeholder="Destination" required>
            <input type="date" name="start_date" class="modal-input" required>
            <input type="date" name="end_date" class="modal-input" required>
            <button type="submit" class="submit-btn">Add Package</button>
        </form>
    </div>
</div>

<script>
// Modal functionality
var modal = document.getElementById("addPackageModal");
var btn = document.getElementById("addPackageBtn");
var span = document.getElementsByClassName("close")[0];

btn.onclick = function() {
    modal.style.display = "block";
}
span.onclick = function() {
    modal.style.display = "none";
}
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

</body>
</html>
