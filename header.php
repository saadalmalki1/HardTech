<?php require_once "functions.php"; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($page_title) ? e($page_title) . " - " : ""; ?>HardTech</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<header class="topbar">
    <div class="container nav">
        <a class="logo" href="index.php">Hard<span>Tech</span></a>
        <nav>
            <a href="index.php">Home</a>
            <a href="products.php">Products</a>
            <a href="cart.php">Cart <b class="cart-badge"><?php echo cart_count(); ?></b></a>
        </nav>
    </div>
</header>
<main class="container">
