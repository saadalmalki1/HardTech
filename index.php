<?php
require_once "config.php";
$page_title = "Home";

$categories = $pdo->query("SELECT Category_ID, Category_Name FROM categories ORDER BY Category_Name LIMIT 8")->fetchAll(PDO::FETCH_ASSOC);

$stmt = $pdo->query("
    SELECT i.*, c.Category_Name, s.Seller_Name
    FROM items i
    LEFT JOIN categories c ON c.Category_ID = i.Category_ID
    LEFT JOIN sellers s ON s.Seller_ID = i.Seller_ID
    WHERE i.Status = 'Available'
    ORDER BY i.Created_At DESC
    LIMIT 8
");
$items = $stmt->fetchAll(PDO::FETCH_ASSOC);

require "header.php";
?>
<section class="hero">
    <div>
        <p class="eyebrow">HARDWARE MARKETPLACE</p>
        <h1>Find the right hardware for your setup.</h1>
        <p class="hero-text">A clean and simple marketplace for computers, components and technology products.</p>
        <a class="btn" href="products.php">Browse Products</a>
    </div>
</section>

<section class="section">
    <div class="section-head">
        <div>
            <p class="eyebrow">EXPLORE</p>
            <h2>Categories</h2>
        </div>
    </div>
    <div class="category-grid">
        <?php if (empty($categories)): ?>
            <div class="empty">No categories have been added yet.</div>
        <?php else: ?>
            <?php foreach ($categories as $category): ?>
                <a class="category-card" href="products.php?category=<?php echo (int)$category['Category_ID']; ?>">
                    <span class="category-icon">▦</span>
                    <strong><?php echo e($category['Category_Name']); ?></strong>
                    <small>View products →</small>
                </a>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</section>

<section class="section">
    <div class="section-head">
        <div>
            <p class="eyebrow">LATEST</p>
            <h2>Latest Products</h2>
        </div>
        <a class="text-link" href="products.php">View all →</a>
    </div>

    <?php if (empty($items)): ?>
        <div class="empty">
            <h3>Your database is ready.</h3>
            <p>No products are stored in <code>items</code> yet. Add products to the database and they will appear here automatically.</p>
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
</section>
<?php require "footer.php"; ?>