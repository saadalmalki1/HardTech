<?php
if (session_id() == '') {
    session_start();
}

function e($value) {
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function cart_count() {
    if (!isset($_SESSION['cart'])) return 0;
    $count = 0;
    foreach ($_SESSION['cart'] as $qty) $count += (int)$qty;
    return $count;
}

function cart_total($pdo) {
    if (!isset($_SESSION['cart']) || empty($_SESSION['cart'])) return 0;
    $ids = array_keys($_SESSION['cart']);
    $placeholders = implode(',', array_fill(0, count($ids), '?'));
    $stmt = $pdo->prepare("SELECT Item_ID, Price FROM items WHERE Item_ID IN ($placeholders)");
    $stmt->execute($ids);
    $total = 0;
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $total += ((float)$row['Price']) * (int)$_SESSION['cart'][$row['Item_ID']];
    }
    return $total;
}
?>