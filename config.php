<?php
// Database connection
$host = "localhost";
$db   = "hardtech";
$user = "root";
$pass = "";

try {
    $pdo = new PDO(
        "mysql:host=" . $host . ";dbname=" . $db . ";charset=utf8",
        $user,
        $pass,
        array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION)
    );
} catch (PDOException $e) {
    die("Database connection failed. Please check config.php");
}
?>