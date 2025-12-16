# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
CartItem.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

# Create categories
puts "Creating categories..."
electronics = Category.create!(name: "Electronics", description: "Electronic devices and gadgets")
clothing = Category.create!(name: "Clothing", description: "Fashion and apparel")
books = Category.create!(name: "Books", description: "Books and educational materials")
home = Category.create!(name: "Home & Garden", description: "Home improvement and garden supplies")
sports = Category.create!(name: "Sports", description: "Sports and outdoor equipment")

# Create products
puts "Creating products..."
Product.create!([
  # Electronics
  {
    name: "Wireless Headphones",
    description: "High-quality wireless headphones with noise cancellation",
    price: 149.99,
    stock_quantity: 50,
    category: electronics,
    image_url: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500"
  },
  {
    name: "Smart Watch",
    description: "Feature-rich smartwatch with fitness tracking",
    price: 299.99,
    stock_quantity: 30,
    category: electronics,
    image_url: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500"
  },
  {
    name: "Laptop",
    description: "Powerful laptop for work and entertainment",
    price: 999.99,
    stock_quantity: 15,
    category: electronics,
    image_url: "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500"
  },
  
  # Clothing
  {
    name: "Cotton T-Shirt",
    description: "Comfortable cotton t-shirt, available in multiple colors",
    price: 24.99,
    stock_quantity: 100,
    category: clothing,
    image_url: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500"
  },
  {
    name: "Denim Jeans",
    description: "Classic denim jeans with modern fit",
    price: 59.99,
    stock_quantity: 75,
    category: clothing,
    image_url: "https://images.unsplash.com/photo-1542272604-787c3835535d?w=500"
  },
  {
    name: "Winter Jacket",
    description: "Warm winter jacket for cold weather",
    price: 129.99,
    stock_quantity: 40,
    category: clothing,
    image_url: "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500"
  },
  
  # Books
  {
    name: "Programming Guide",
    description: "Comprehensive guide to modern programming",
    price: 49.99,
    stock_quantity: 60,
    category: books,
    image_url: "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500"
  },
  {
    name: "Fiction Novel",
    description: "Bestselling fiction novel",
    price: 19.99,
    stock_quantity: 80,
    category: books,
    image_url: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500"
  },
  
  # Home & Garden
  {
    name: "Coffee Maker",
    description: "Automatic coffee maker with timer",
    price: 79.99,
    stock_quantity: 45,
    category: home,
    image_url: "https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500"
  },
  {
    name: "Plant Pot Set",
    description: "Set of 3 ceramic plant pots",
    price: 34.99,
    stock_quantity: 55,
    category: home,
    image_url: "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=500"
  },
  
  # Sports
  {
    name: "Yoga Mat",
    description: "Non-slip yoga mat with carrying strap",
    price: 29.99,
    stock_quantity: 70,
    category: sports,
    image_url: "https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500"
  },
  {
    name: "Running Shoes",
    description: "Lightweight running shoes for all terrains",
    price: 89.99,
    stock_quantity: 50,
    category: sports,
    image_url: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500"
  }
])

# Create sample users
puts "Creating sample users..."
admin = User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true
)

customer = User.create!(
  name: "John Doe",
  email: "john@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Seed data created successfully!"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Users: #{User.count}"
puts ""
puts "Sample login credentials:"
puts "Email: john@example.com"
puts "Password: password123"
