/*
  # Create products and categories tables

  1. New Tables
    - `categories`
      - `id` (uuid, primary key)
      - `name` (text, unique)
      - `slug` (text, unique)
      - `created_at` (timestamp)
    
    - `products`
      - `id` (uuid, primary key)
      - `name` (text)
      - `description` (text)
      - `price` (decimal)
      - `image_url` (text)
      - `category_id` (uuid, foreign key)
      - `created_at` (timestamp)
      - `stock` (integer)

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access
*/

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  price decimal(10,2) NOT NULL,
  image_url text NOT NULL,
  category_id uuid REFERENCES categories(id),
  created_at timestamptz DEFAULT now(),
  stock integer NOT NULL DEFAULT 0
);

-- Enable RLS
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access for categories"
  ON categories
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access for products"
  ON products
  FOR SELECT
  TO public
  USING (true);

-- Insert sample categories
INSERT INTO categories (name, slug) VALUES
  ('Electronics', 'electronics'),
  ('Clothing', 'clothing'),
  ('Books', 'books'),
  ('Home & Kitchen', 'home-kitchen');

-- Insert sample products
INSERT INTO products (name, description, price, image_url, category_id, stock) VALUES
  ('Wireless Headphones', 'High-quality wireless headphones with noise cancellation', 199.99, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e', (SELECT id FROM categories WHERE slug = 'electronics'), 50),
  ('Smart Watch', 'Feature-rich smartwatch with health tracking', 299.99, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30', (SELECT id FROM categories WHERE slug = 'electronics'), 30),
  ('Cotton T-Shirt', 'Comfortable 100% cotton t-shirt', 24.99, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab', (SELECT id FROM categories WHERE slug = 'clothing'), 100),
  ('Denim Jeans', 'Classic fit denim jeans', 59.99, 'https://images.unsplash.com/photo-1542272604-787c3835535d', (SELECT id FROM categories WHERE slug = 'clothing'), 75),
  ('Programming Guide', 'Comprehensive programming guide for beginners', 39.99, 'https://images.unsplash.com/photo-1532012197267-da84d127e765', (SELECT id FROM categories WHERE slug = 'books'), 25),
  ('Coffee Maker', 'Automatic drip coffee maker', 79.99, 'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6', (SELECT id FROM categories WHERE slug = 'home-kitchen'), 40);