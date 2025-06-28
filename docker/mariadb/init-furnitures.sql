CREATE DATABASE IF NOT EXISTS `idyie_api_development` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `idyie_api_development`;

-- Create customers table
CREATE TABLE IF NOT EXISTS `customers` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100),
  `email` VARCHAR(100),
  `address` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Create products table
CREATE TABLE IF NOT EXISTS `products` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100),
  `category` VARCHAR(50),
  `color` VARCHAR(30),
  `price` DECIMAL(10, 2),
  `stock` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Create orders table
CREATE TABLE IF NOT EXISTS `orders` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT,
    `product_id` INT,
    `quantity` INT,
    `order_date` DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Insert customers
INSERT INTO `customers` (`name`, `email`, `address`) VALUES
('Alice Martin', 'alice.martin@example.com', '12 Lilas Street, Paris'),
('Jean Dupont', 'jean.dupont@example.com', '24 Victor Hugo Avenue, Lyon'),
('Sophie Durand', 'sophie.durand@example.com', '8 Haussmann Boulevard, Marseille'),
('Luc Moreau', 'luc.moreau@example.com', '56 Lafayette Street, Bordeaux'),
('Chloé Bernard', 'chloe.bernard@example.com', '91 Oberkampf Street, Strasbourg');

-- Insert products
INSERT INTO `products` (`name`, `category`, `color`, `price`, `stock`) VALUES
('3-Seater Sofa', 'Living Room', 'Gray', 599.99, 10),
('Oak Table', 'Dining Room', 'Light Brown', 349.00, 5),
('Designer Chair', 'Dining Room', 'White', 89.90, 25),
('Double Bed', 'Bedroom', 'Black', 499.00, 7),
('2-Door Wardrobe', 'Bedroom', 'Beige', 299.99, 3),
('Scandinavian Sideboard', 'Dining Room', 'Oak', 399.00, 4),
('High Stool', 'Kitchen', 'Red', 59.90, 15),
('Glass Desk', 'Office', 'Transparent', 229.00, 8),
('Coffee Table', 'Living Room', 'Matte Black', 129.99, 12),
('3-Drawer Dresser', 'Bedroom', 'White', 199.99, 6),
('Ergonomic Office Chair', 'Office', 'Black', 179.50, 9),
('Wall Shelf', 'Living Room', 'Walnut', 89.00, 10),
('TV Stand', 'Living Room', 'Dark Gray', 259.90, 4),
('Bedside Table', 'Bedroom', 'White', 89.99, 11),
('Recliner Chair', 'Living Room', 'Navy Blue', 349.90, 3);

-- Insert orders
INSERT INTO `orders` (`customer_id`, `product_id`, `quantity`, `order_date`) VALUES
(1, 1, 1, '2025-06-01'),
(2, 3, 4, '2025-06-03'),
(3, 4, 1, '2025-06-05'),
(1, 2, 1, '2025-06-06'),
(2, 5, 1, '2025-06-07'),
(4, 6, 1, '2025-06-08'),
(5, 7, 2, '2025-06-09'),
(1, 8, 1, '2025-06-10'),
(3, 9, 1, '2025-06-11'),
(4, 10, 1, '2025-06-12'),
(5, 11, 1, '2025-06-13'),
(2, 12, 2, '2025-06-14'),
(3, 13, 1, '2025-06-15'),
(1, 14, 2, '2025-06-16'),
(5, 15, 1, '2025-06-17');
