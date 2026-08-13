<?php
require_once "config.php";
$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

$stmt = $pdo->prepare("
    SELECT i.*, c.Category_Name, s.Seller_Name, s.Avg_Rating
    FROM items i
    LEFT JOIN categories c ON c.Category_ID = i.Category_ID
    LEFT JOIN sellers s ON s.Seller_ID = i.Seller_ID
    WHERE i.Item_ID = ?
");
$stmt->execute(array($id));
$item = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$item) {
    $page_title = "Product not found";
    require "header.php";
    echo '<div class="empty"><h2>Product not found.</h2><p>The requested product does not exist.</p><a class="btn" href="products.php">Back to products</a></div>';
    require "footer.php";
    exit;
}

$page_title = $item['Item_Name'];
require "header.php";
?>
<div class="product-detail">
    <div class="detail-image">HARDTECH</div>
    <div class="detail-info">
        <span class="tag"><?php echo e($item['Category_Name']); ?></span>
        <h1><?php echo e($item['Item_Name']); ?></h1>
        <p class="price"><?php echo number_format($item['Price'], 2); ?> SAR</p>
        <p class="description"><?php echo nl2br(e($item['Description'])); ?></p>

        <div class="specs">
            <div><span>Brand</span><strong><?php echo e($item['Brand']); ?></strong></div>
            <div><span>Model</span><strong><?php echo e($item['Model']); ?></strong></div>
            <div><span>Condition</span><strong><?php echo e($item['Condition_Status']); ?></strong></div>
            <div><span>Warranty</span><strong><?php echo e($item['Warranty']); ?></strong></div>
            <div><span>Stock</span><strong><?php echo (int)$item['Quantity']; ?></strong></div>
            <div><span>Seller</span><strong><?php echo e($item['Seller_Name']); ?></strong></div>
        </div>

        <?php if ((int)$item['Quantity'] > 0): ?>
        <form class="add-form" method="post" action="cart.php">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="item_id" value="<?php echo (int)$item['Item_ID']; ?>">
            <input type="number" name="quantity" min="1" max="<?php echo (int)$item['Quantity']; ?>" value="1">
            <button class="btn" type="submit">Add to Cart</button>
        </form>
        <?php else: ?>
            <p class="sold-out">Out of stock</p>
        <?php endif; ?>
    </div>
</div>
<?php require "footer.php"; ?>