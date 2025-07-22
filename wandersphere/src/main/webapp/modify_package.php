<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "wandersphere";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$package_id = $_GET['package_id'] ?? '';
$error = '';
$success = '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $package_id = $_POST["package_id"];
    $source = $_POST["source"];
    $destination = $_POST["destination"];
    $start_date = $_POST["start_date"];
    $end_date = $_POST["end_date"];
    $availability = $_POST["availability"];
    $slots = $_POST["no_of_slots_available"];
    $description = $_POST["description"];
    $services = $_POST["included_service"];
    $duration = $_POST["duration"];
    
    // Update package table
    $update_package = "UPDATE packages SET source=?, destination=?, start_date=?, end_date=? WHERE package_id=?";
    $stmt1 = $conn->prepare($update_package);
    $stmt1->bind_param("ssssi", $source, $destination, $start_date, $end_date, $package_id);
    
    // Update package_availability table
    $update_availability = "UPDATE package_availability SET availability=?, no_of_slots_available=?, description=?, included_service=?, duration=? WHERE package_id=?";
    $stmt2 = $conn->prepare($update_availability);
    $stmt2->bind_param("sissii", $availability, $slots, $description, $services, $duration, $package_id);
    
    if ($stmt1->execute() && $stmt2->execute()) {
        $success = "Package updated successfully.";
    } else {
        $error = "Error updating package: " . $conn->error;
    }
    
    $stmt1->close();
    $stmt2->close();
}

// Fetch existing values
$sql = "SELECT p.*, a.availability, a.no_of_slots_available, a.description, a.included_service, a.duration
        FROM packages p
        JOIN package_availability a ON p.package_id = a.package_id
        WHERE p.package_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $package_id);
$stmt->execute();
$result = $stmt->get_result();
$data = $result->fetch_assoc();
if (!$data) {
    die("<p style='color: red; text-align: center;'>Package with ID $package_id not found.</p>");
}

$stmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Modify Package</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f3f5;
            padding: 30px;
        }

        .form-container {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            width: 600px;
            margin: auto;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .field-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #aaa;
            border-radius: 6px;
            font-size: 15px;
            background-color: #f2f2f2;
        }

        input[readonly], textarea[readonly], select[disabled] {
            background-color: #e8e8e8;
        }

        .edit-icon {
            position: absolute;
            right: 10px;
            top: 35px;
            cursor: pointer;
            color: #2980b9;
        }

        .submit-btn {
            background-color: #27ae60;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            display: block;
            width: 100%;
        }

        .submit-btn:hover {
            background-color: #2ecc71;
        }

        .message {
            text-align: center;
            margin-top: 15px;
            color: red;
        }

        .success {
            color: green;
        }
    </style>

    <script>
        function enableEdit(id) {
            const input = document.getElementById(id);
            if (input.hasAttribute('readonly') || input.disabled) {
                input.removeAttribute('readonly');
                input.disabled = false;
                input.focus();
            }
        }
    </script>
</head>
<body>


<div class="form-container">
    <h2>Modify Package</h2>
    <form method="POST">
        <input type="hidden" name="package_id" value="<?= htmlspecialchars($data['package_id']) ?>">

        <?php
        function field($id, $label, $value, $type = 'text') {
            echo "
            <div class='field-group'>
                <label for='$id'>$label</label>
                <input type='$type' name='$id' id='$id' value=\"" . htmlspecialchars($value) . "\" readonly>
                <span class='edit-icon' onclick=\"enableEdit('$id')\">✏️</span>
            </div>";
        }

        field("source", "Source", $data['source']);
        field("destination", "Destination", $data['destination']);
        field("start_date", "Start Date", $data['start_date'], 'date');
        field("end_date", "End Date", $data['end_date'], 'date');

        echo "
        <div class='field-group'>
            <label for='availability'>Availability</label>
            <select name='availability' id='availability' disabled>
                <option value='yes' " . ($data['availability'] == 'yes' ? 'selected' : '') . ">Yes</option>
                <option value='no' " . ($data['availability'] == 'no' ? 'selected' : '') . ">No</option>
            </select>
            <span class='edit-icon' onclick=\"enableEdit('availability')\">✏️</span>
        </div>";

        field("no_of_slots_available", "No. of Slots Available", $data['no_of_slots_available'], 'number');

        echo "
        <div class='field-group'>
            <label for='description'>Description</label>
            <textarea name='description' id='description' rows='3' readonly>" . htmlspecialchars($data['description']) . "</textarea>
            <span class='edit-icon' onclick=\"enableEdit('description')\">✏️</span>
        </div>";

        echo "
        <div class='field-group'>
            <label for='included_service'>Included Service</label>
            <textarea name='included_service' id='included_service' rows='3' readonly>" . htmlspecialchars($data['included_service']) . "</textarea>
            <span class='edit-icon' onclick=\"enableEdit('included_service')\">✏️</span>
        </div>";

        field("duration", "Duration (Days)", $data['duration'], 'number');
        ?>

        <button type="submit" class="submit-btn">Update Package</button>

        <?php
        if ($error) echo "<div class='message'>$error</div>";
        if ($success) echo "<div class='message success'>$success</div>";
        ?>
    </form>
</div>
<a href="packages.php" style="
    display: inline-block;
    margin: 20px;
    padding: 10px 20px;
    background-color: #7f8c8d;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: bold;
    transition: background-color 0.3s ease;
">← Back to Packages</a>

</body>
</html>
