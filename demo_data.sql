
INSERT INTO sellers
(Seller_Name, Mobile, ID_Number, ID_Photo, Location, Email, Password_Hash, Account_Status, Verification_Status)
VALUES
('HardTech Store', '0500000000', 'DEMO-1001', 'demo.jpg', 'Saudi Arabia', 'store@example.com', 'demo', 'Active', 'Verified');

INSERT INTO categories (Category_Name) VALUES
('Laptops'), ('Graphics Cards'), ('Processors'), ('Accessories');

INSERT INTO items
(Seller_ID, Category_ID, Item_Name, Description, Brand, Model, Price, Quantity, Condition_Status, Warranty, Status)
VALUES
(1, 1, 'Gaming Laptop', 'A simple demo gaming laptop product.', 'ASUS', 'TUF Gaming', 3999.00, 5, 'New', '1 Year', 'Available'),
(1, 2, 'Graphics Card', 'A demo graphics card product.', 'NVIDIA', 'RTX Series', 2199.00, 3, 'New', '1 Year', 'Available'),
(1, 3, 'Desktop Processor', 'A demo processor product.', 'AMD', 'Ryzen Series', 899.00, 8, 'New', '1 Year', 'Available'),
(1, 4, 'Mechanical Keyboard', 'A simple mechanical keyboard.', 'HardTech', 'KB-01', 249.00, 10, 'New', '6 Months', 'Available');
