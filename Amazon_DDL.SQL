
Step 1: Creating Tables

CREATE TABLE Customers (
    customerID INT AUTO_INCREMENT,
    customer_first_name VARCHAR(255) NOT NULL,
    customer_last_name VARCHAR(255) NOT NULL,
    address_line VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(15),
    PRIMARY KEY (customerID)
);

CREATE TABLE Vendors (
    vendorID INT AUTO_INCREMENT,
    vendor_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (vendorID)
);

CREATE TABLE Products (
    productID INT AUTO_INCREMENT,
    vendorID INT,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    product_price DECIMAL(10,2),
    PRIMARY KEY (productID),
    FOREIGN KEY (vendorID) REFERENCES Vendors(vendorID)
);

CREATE TABLE Orders (
    orderID INT AUTO_INCREMENT,
    customerID INT,
    order_date DATE,
    shipping_date DATE,
    status VARCHAR(50),
    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE OrderItems (
    orderitemID INT AUTO_INCREMENT,
    orderID INT,
    productID INT,
    quantity_ordered INT,
    PRIMARY KEY (orderitemID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (productID) REFERENCES Products(productID)
);

CREATE TABLE Reviews (
    reviewID INT AUTO_INCREMENT,
    productID INT,
    customerID INT,
    review_date DATE,
    rating DECIMAL(2,1),
    comment TEXT,
    PRIMARY KEY (reviewID),
    FOREIGN KEY (productID) REFERENCES Products(productID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE ShoppingCart (
    shoppingcartID INT AUTO_INCREMENT,
    customerID INT,
    PRIMARY KEY (shoppingcartID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE ShoppingCartItems (
    shopping_cart_itemID INT AUTO_INCREMENT,
    shoppingcartID INT,
    productID INT,
    quantity_in_cart INT,
    PRIMARY KEY (shopping_cart_itemID),
    FOREIGN KEY (shoppingcartID) REFERENCES ShoppingCart(shoppingcartID),
    FOREIGN KEY (productID) REFERENCES Products(productID)
);

Step 2: Inserting Data into Database

# Insert data into Customers 
INSERT INTO Customers (customer_first_name, customer_last_name, address_line, city, 
state, country, phone) VALUES 
('Abdul', 'Aroworamimo', '123 Quebec St', 'Quebec City', 'Quebec', 'CA', '+14168889900'),
('Chien', 'Lieu', '124 Montreal Rd', 'Montreal', 'Quebec', 'CA', '+14168889901'),
('Jingwen', 'He', '125 Sherbrooke Av', 'Sherbrooke', 'Quebec', 'CA', '+14168889902'),
('Boyan', 'Li', '126 Laval Pl', 'Laval', 'Quebec', 'CA', '+14168889903'),
('Tomy', 'Pelletier', '127 Saguenay Dr', 'Saguenay', 'Quebec', 'CA', '+14168889904'),
('Om','Sangwan', '845 Rue Sherbrooke', 'Toronto', 'Ontario','Country','+5877890461');

# Insert data into Vendors
INSERT INTO Vendors (vendor_name) VALUES 
('Sean Clarke Electronics'),
('Om Sangwan Books'),
('Blaise Mbu Fashion'),
('Lionel Messi Sports'),
('Xiarong Tian Foods');

# Insert data into Products
INSERT INTO Products (vendorID, product_name, product_description, product_price) 
VALUES 
(1, 'Electron X', 'Latest electronic gadget', 299.99),
(2, 'Historical Novel', 'A novel based on history', 19.99),
(3, 'Designer Shirt', 'Shirt with unique design', 49.99),
(4, 'Soccer Ball', 'Top quality soccer ball', 24.99),
(5, 'Organic Noodles', 'Noodles made with organic ingredients', 4.99), 
(1, 'Electron Y', 'Previous version of Electron gadget', 199.99),
(2, 'Romantic Novel', 'A romantic based story', 25.99),
(3, 'Designer Pants', 'Pants with unique design', 59.99),
(4, 'Running Shoes', 'Shoes for professional runners', 129.99),
(5, 'Organic Rice', 'Rice made with organic ingredients', 9.99),
(1, 'iPhone 14', 'Latest Apple smartphone', 999.99),
(2, 'The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 15.99),
(3, 'Levi Jeans', 'Classic straight cut jeans', 69.99),
(4, 'Nike Air Max', 'Popular running shoe', 149.99),
(5, 'Organic Oatmeal', 'Healthy breakfast choice', 5.99),
(1, 'Macbook Pro', 'Apple laptop with M2 chip', 1299.99),
(2, 'The Alchemist', 'Novel by Paulo Coelho', 10.99),
(3, 'Ray-Ban Sunglasses', 'Stylish shades for the summer', 139.99),
(4, 'Adidas Superstar', 'Classic Adidas shoe', 79.99),
(5, 'Gluten-free Pasta', 'Pasta alternative for gluten-sensitive', 6.99),
(1, 'iPad Air', 'Portable tablet by Apple', 599.99),
(2, '1984', 'Dystopian novel by George Orwell', 12.99),
(3, 'Calvin Klein T-shirt', 'Comfortable white t-shirt', 29.99),
(4, 'Puma Sports Shorts', 'Breathable shorts for sports activities', 39.99),
(5, 'Quinoa Grain Pack', 'High protein grain', 7.99),
(1, 'AlphaSmart Keyboard', 'Portable word processing keyboard', 45.99),
(2, 'Zephyr Mouse', 'Wireless computer mouse', 19.99),
(3, 'Galaxy Earbuds', 'Bluetooth earbuds', 59.99),
(4, 'Lunar Charger', 'Universal device charger', 29.99),
(5, 'Solar Backpack', 'Backpack with solar charging panel', 79.99),
(2, 'HP Spectre x360', 'A high-end convertible laptop with powerful specs', 1300),
(3, 'Logitech G502 Mouse', 'A versatile gaming mouse with customizable weights', 50),
(4, 'Sony WH-1000XM4', 'Noise-cancelling wireless headphones', 350),
(1, 'Canon EOS M50', 'Mirrorless digital camera for budding photographers', 650),
(5, 'Samsung Galaxy Tab S7', 'A tablet with a smooth 120Hz display', 650);

# Insert data into Orders
INSERT INTO Orders (customerID, order_date, shipping_date, status) VALUES 
(1, '2023-08-01', '2023-08-03', 'Shipped'),
(2, '2023-08-02', '2023-08-04', 'Shipped'),
(3, '2023-08-02', NULL, 'Processing'),
(4, '2023-08-03', NULL, 'Processing'),
(5, '2023-08-04', '2023-08-07', 'Shipped'),
(1, '2023-08-06', '2023-08-08', 'Shipped'),
(2, '2023-08-07', NULL, 'Processing'),
(3, '2023-08-08', '2023-08-10', 'Shipped'),
(4, '2023-08-09', NULL, 'Processing'),
(5, '2023-08-10', NULL, 'Processing'),
(1, '2023-08-15', '2023-08-18', 'Shipped'),
(2, '2023-08-16', '2023-08-19', 'Shipped'),
(3, '2023-08-17', NULL, 'Processing'),
(4, '2023-08-18', '2023-08-21', 'Shipped'),
(5, '2023-08-19', NULL, 'Processing'),
(1, '2023-08-20', '2023-08-23', 'Shipped'),
(2, '2023-08-21', NULL, 'Processing'),
(3, '2023-08-22', '2023-08-25', 'Shipped'),
(4, '2023-08-23', '2023-08-26', 'Shipped'),
(5, '2023-08-24', NULL, 'Processing'),
(1, '2023-08-27', '2023-08-29', 'Shipped'),
(1, '2023-08-28', '2023-08-30', 'Shipped'),
(3, '2023-08-29', '2023-08-31', 'Shipped'),
(3, '2023-08-30', '2023-09-01', 'Shipped'),
(3, '2023-08-31', '2023-09-02', 'Shipped'),
(1, '2023-07-15', '2023-07-18', 'Shipped'),
(2, '2023-07-22', '2023-07-24', 'Shipped'),
(3, '2023-08-01', '2023-08-03', 'Shipped'),
(4, '2023-08-05', NULL, 'Processing'),
(5, '2023-08-02', '2023-08-05', 'Shipped'),
(6, '2023-08-18', '2023-08-21', 'Shipped');


# Insert data into OrderItems
INSERT INTO OrderItems (orderID, productID, quantity_ordered) VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 3, 4),
(4, 4, 2),
(5, 5, 5), 
(6, 6, 1),
(7, 7, 2),
(8, 8, 3),
(9, 9, 1),
(10, 10, 5),
(11, 11, 1),
(12, 12, 1),
(13, 13, 2),
(14, 14, 1),
(15, 15, 3),
(16, 16, 1),
(17, 17, 2),
(18, 18, 1),
(19, 19, 1),
(20, 20, 2),
(21, 21, 2),
(22, 22, 1),
(23, 23, 3),
(24, 24, 2),
(25, 25, 4),
(26, 26, 1),
(26, 27, 2),
(27, 28, 1),
(27, 29, 1),
(28, 30, 1),
(29, 26, 3),
(30, 27, 2),
(31, 27, 2);
# Insert data into Reviews
INSERT INTO Reviews (productID, customerID, review_date, rating, comment) VALUES 
(1, 1, '2023-08-05', 5, 'Great product!'),
(2, 2, '2023-08-06', 4, 'Interesting read.'),
(3, 3, '2023-08-07', 3, 'Nice design but can be improved.'),
(4, 4, '2023-08-08', 4, 'Good quality!'),
(5, 5, '2023-08-09', 4, 'Tasty and healthy.'),
(6, 2, '2023-08-09', 4, 'I preferred the previous version.'),
(7, 3, '2023-08-10', 5, 'Heartwarming story!'),
(8, 4, '2023-08-11', 4, 'Comfortable wear.'),
(9, 1, '2023-08-12', 5, 'Perfect for my morning runs.'),
(10, 5, '2023-08-13', 5, 'Very fresh and tasty.'),
(11, 5, '2023-08-25', 4, 'Still prefer the older model.'),
(12, 4, '2023-08-26', 5, 'A captivating classic.'),
(13, 3, '2023-08-27', 5, 'Perfect fit and comfortable.'),
(14, 2, '2023-08-28', 5, 'Excellent for daily runs.'),
(15, 1, '2023-08-29', 4, 'Tasty, but I prefer the regular one.'),
(16, 5, '2023-08-30', 5, 'Best laptop on the market.'),
(17, 4, '2023-08-31', 4, 'Inspiring story!'),
(18, 3, '2023-09-01', 5, 'Looks great and protects from the sun.'),
(19, 2, '2023-09-02', 4, 'Stylish but feels a bit tight.'),
(20, 1, '2023-09-03', 5, 'Delicious alternative to regular pasta.'),
(21, 4, '2023-09-01', 5, 'Super portable and easy to use.'),
(22, 2, '2023-09-02', 4, 'Thought-provoking read.'),
(23, 5, '2023-09-03', 4, 'Looks elegant. A bit overpriced.'),
(24, 1, '2023-09-04', 3, 'Decent shorts but they run a size smaller.'),
(25, 3, '2023-09-05', 5, 'Super nutritious and easy to cook.');

# Insert data into ShoppingCart
INSERT INTO ShoppingCart (customerID) VALUES 
(1),
(2),
(3),
(4),
(5);

# Insert data into ShoppingCartItems
INSERT INTO ShoppingCartItems (shoppingcartID, productID, quantity_in_cart) VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 3), 
(1, 6, 1),
(2, 7, 2),
(3, 8, 1),
(4, 9, 1),
(5, 10, 2),
(1, 16, 1),
(2, 17, 1),
(3, 18, 1),
(4, 19, 2),
(5, 20, 3),
(1, 11, 1),
(2, 12, 1),
(3, 13, 2),
(4, 14, 1),
(5, 15, 1),
(1, 22, 1),
(2, 23, 2),
(3, 21, 1),
(4, 24, 1),
(5, 25, 2);
