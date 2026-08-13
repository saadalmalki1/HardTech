<?php
require_once "config.php";

if (!isset($_SESSION['cart'])) $_SESSION['cart'] = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = isset($_POST['action']) ? $_POST['action'] : '';

    if ($action === 'add') {
        $id = isset($_POST['item_id']) ? (int)$_POST['item_id'] : 0;
        $qty = isset($_POST['quantity']) ? max(1, (int)$_POST['quantity']) : 1;

        $stmt = $pdo->prepare("SELECT Quantity FROM items WHERE Item_ID = ? AND Status = 'Available'");
        $stmt->execute(array($id));
        $item = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($item) {
            $current = isset($_SESSION['cart'][$id]) ? (int)$_SESSION['cart'][$id] : 0;
            $_SESSION['cart'][$id] = min($current + $qty, (int)$item['Quantity']);
        }
    }

    if ($action === 'remove') {
        $id = isset($_POST['item_id']) ? (int)$_POST['item_id'] : 0;
        unset($_SESSION['cart'][$id]);
    }

    if ($action === 'clear') {
        $_SESSION['cart'] = array();
    }

    header("Location: cart.php");
    exit;
}

$items = array();
if (!empty($_SESSION['cart'])) {
    $ids = array_keys($_SESSION['cart']);
    $placeholders = implode(',', array_fill(0, count($ids), '?'));
    $stmt = $pdo->prepare("
        SELECT Item_ID, Item_Name, Brand, Price, Quantity
        FROM items
        WHERE Item_ID IN ($placeholders)
    ");
    $stmt->execute($ids);
    $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

$total = cart_total($pdo);
$page_title = "Cart";
require "header.php";
?>
<section class="page-title">
    <p class="eyebrow">YOUR SHOPPING CART</p>
    <h1>Cart</h1>
</section>

<?php if (empty($items)): ?>
    <div class="empty">
        <h2>Your cart is empty.</h2>
        <p>Add a product from the store to see it here.</p>
        <a class="btn" href="products.php">Browse Products</a>
    </div>
<?php else: ?>
    <div class="cart-layout">
        <div>
            <?php foreach ($items as $item): ?>
                <div class="cart-item">
                    <div class="mini-image">HT</div>
                    <div class="cart-info">
                        <h3><?php echo e($item['Item_Name']); ?></h3>
                        <p><?php echo e($item['Brand']); ?></p>
                        <strong><?php echo number_format($item['Price'], 2); ?> SAR</strong>
                    </div>
                    <div class="cart-qty">Qty: <?php echo (int)$_SESSION['cart'][$item['Item_ID']]; ?></div>
                    <form method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="item_id" value="<?php echo (int)$item['Item_ID']; ?>">
                        <button class="remove" type="submit">Remove</button>
                    </form>
                </div>
            <?php endforeach; ?>
        </div>

        <aside class="summary">
            <h2>Summary</h2>
            <div><span>Items</span><strong><?php echo cart_count(); ?></strong></div>
            <div class="summary-total"><span>Total</span><strong><?php echo number_format($total, 2); ?> SAR</strong></div>
            <button class="btn full" type="button" disabled>Checkout</button>
            <form method="post">
                <input type="hidden" name="action" value="clear">
                <button class="clear-btn" type="submit">Clear cart</button>
            </form>
        </aside>
    </div>
<?php endif; ?>
<?php require "footer.php"; ?>