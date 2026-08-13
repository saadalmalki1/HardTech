<?php
require_once "config.php";
$page_title = "Products";

$category_id = isset($_GET['category']) ? (int)$_GET['category'] : 0;
$search = isset($_GET['q']) ? trim($_GET['q']) : "";

$categories = $pdo->query("SELECT Category_ID, Category_Name FROM categories ORDER BY Category_Name")->fetchAll(PDO::FETCH_ASSOC);

$sql = "SELECT i.*, c.Category_Name, s.Seller_Name
        FROM items i
        LEFT JOIN categories c ON c.Category_ID = i.Category_ID
        LEFT JOIN sellers s ON s.Seller_ID = i.Seller_ID
        WHERE i.Status = 'Available'";
$params = array();

if ($category_id > 0) {
    $sql .= " AND i.Category_ID = ?";
    $params[] = $category_id;
}
if ($search !== "") {
    $sql .= " AND (i.Item_Name LIKE ? OR i.Brand LIKE ? OR i.Model LIKE ?)";
    $like = "%" . $search . "%";
    $params[] = $like; $params[] = $like; $params[] = $like;
}
$sql .= " ORDER BY i.Created_At DESC";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$items = $stmt->fetchAll(PDO::FETCH_ASSOC);

require "header.php";
?>
<section class="page-title">
    <p class="eyebrow">STORE</p>
    <h1>Products</h1>
    <p>Browse the hardware available in your HardTech database.</p>
</section>

<form class="search-box" method="get" action="products.php">
    <input type="text" name="q" value="<?php echo e($search); ?>" placeholder="Search by product, brand or model...">
    <button class="btn" type="submit">Search</button>
</form>

<div class="filter-row">
    <a class="<?php echo $category_id == 0 ? 'active-filter' : ''; ?>" href="products.php">All</a>
    <?php foreach ($categories as $category): ?>
        <a class="<?php echo $category_id == $category['Category_ID'] ? 'active-filter' : ''; ?>"
           href="products.php?category=<?php echo (int)$category['Category_ID']; ?>">
            <?php echo e($category['Category_Name']); ?>
        </a>
    <?php endforeach; ?>
</div>

<?php if (empty($items)): ?>
    <div class="empty">
        <h3>No products found.</h3>
        <p>Try another search, category, or add products to the <code>items</code> table.</p>
    </div>
<?php else: ?>
<div class="product-grid">
<?php foreach ($items as $item): ?>
    <article class="product-card">
        <div class="product-image">HARDTECH</div>
        <div class="product-body">
            <span class="tag"><?php echo e($item['Category_Name']); ?></span>
            <h3><?php echo e($item['Item_Name']); ?></h3>
            <p class="muted"><?php echo e($item['Brand']); ?> <?php echo e($item['Model']); ?></p>
            <div class="product-bottom">
                <strong><?php echo number_format($item['Price'], 2); ?> SAR</strong>
                <a class="small-btn" href="product.php?id=<?php echo (int)$item['Item_ID']; ?>">View</a>
            </div>
        </div>
    </article>
<?php endforeach; ?>
</div>
<?php endif; ?>
<?php require "footer.php"; ?>