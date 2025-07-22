<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(to right, #d3cce3, #e9e4f0);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .users-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .user-container {
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            width: calc(50% - 30px);
            box-sizing: border-box;
            transition: transform 0.2s ease;
        }

        .user-container:hover {
            transform: scale(1.01);
        }

        .user-detail {
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
    </style>
</head>
<body>

<h1>All Users</h1>

<?php
$servername = "localhost";
$username = "root"; // use your DB username
$password = "";     // use your DB password
$dbname = "wandersphere";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("<p style='text-align:center; color:red;'>Connection failed: " . $conn->connect_error . "</p>");
}

// Delete user if delete button is clicked
if (isset($_GET['delete_id'])) {
    $delete_id = $_GET['delete_id'];

    // Delete the user with the given ID
    $sql_delete = "DELETE FROM users WHERE user_id = $delete_id";

    if ($conn->query($sql_delete) === TRUE) {
        echo "<p style='text-align:center;'>User deleted successfully.</p>";
    } else {
        echo "<p style='text-align:center;'>Error deleting user: " . $conn->error . "</p>";
    }
}

// Fetch existing users
$sql = "SELECT * FROM users";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<div class='users-wrapper'>"; // Begin wrapper

    while ($row = $result->fetch_assoc()) {
        echo "<div class='user-container'>";
        echo "<div class='user-detail'><strong>User ID:</strong> " . $row["user_id"] . "</div>";
        echo "<div class='user-detail'><strong>Username:</strong> " . $row["username"] . "</div>";
        echo "<div class='user-detail'><strong>Email:</strong> " . $row["email"] . "</div>";
        echo "<div class='user-detail'><strong>Role:</strong> " . $row["role"] . "</div>";
        echo "<a class='modify-button' href='modify_user.php?user_id=" . $row["user_id"] . "'>Modify</a>";
        echo "<a class='delete-button' href='users.php?delete_id=" . $row["user_id"] . "'>Delete</a>";
        echo "</div>";
    }

    echo "</div>"; // End wrapper
} else {
    echo "<p style='text-align:center;'>No users found.</p>";
}

$conn->close();
?>

</body>
</html>
