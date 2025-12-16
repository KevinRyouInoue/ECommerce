# E-Commerce Web App

A simple e-commerce platform built with Rails 8.1 and MySQL.

## System Design

### Architecture Overview
```
┌─────────────┐      ┌──────────────┐      ┌──────────────┐
│   Browser   │─────▶│ Rails App    │─────▶│  MySQL DB    │
│  (Views)    │◀─────│ (MVC)        │◀─────│              │
└─────────────┘      └──────────────┘      └──────────────┘
                            │
                            ▼
                     ┌──────────────┐
                     │  Sessions    │
                     │  (Auth)      │
                     └──────────────┘
```

### Database Schema
```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│ Categories  │       │  Products   │       │   Users     │
├─────────────┤       ├─────────────┤       ├─────────────┤
│ id          │◀──┐   │ id          │       │ id          │
│ name        │   └───│ category_id │       │ name        │
│ description │       │ name        │       │ email       │
└─────────────┘       │ price       │       │ password    │
                      │ stock_qty   │       │ admin       │
                      └─────────────┘       └─────────────┘
                            │                      │
                            │                      │
                      ┌─────┴──────┬──────────────┘
                      ▼            ▼
                ┌─────────────┐  ┌─────────────┐
                │ CartItems   │  │   Orders    │
                ├─────────────┤  ├─────────────┤
                │ id          │  │ id          │
                │ product_id  │  │ user_id     │
                │ user_id     │  │ total       │
                │ session_id  │  │ status      │
                │ quantity    │  │ address     │
                └─────────────┘  └─────────────┘
                                       │
                                       ▼
                                 ┌─────────────┐
                                 │ OrderItems  │
                                 ├─────────────┤
                                 │ id          │
                                 │ order_id    │
                                 │ product_id  │
                                 │ quantity    │
                                 │ price       │
                                 └─────────────┘
```

## Key Features

- **Product Browsing**: Search and filter products by category
- **Shopping Cart**: Session-based (guests) and user-based (logged in)
- **User Auth**: Sign up, login with bcrypt encryption
- **Checkout**: Create orders, track history
- **Admin Ready**: User model has admin flag for future admin features

## Structure

### MVC Breakdown

**Models** (`app/models/`)
- `User` - Authentication with has_secure_password
- `Product`, `Category` - Catalog management
- `CartItem` - Handles both guest and user carts
- `Order`, `OrderItem` - Order processing

**Controllers** (`app/controllers/`)
- `ProductsController` - Browse, search products
- `CartController` - Add/remove items, update quantities
- `OrdersController` - Checkout, order history
- `SessionsController` - Login/logout
- `UsersController` - Registration

**Views** (`app/views/`)
- Inline-styled ERB templates (no external CSS framework)
- Responsive grid layouts for products
- Forms for checkout and authentication

### Request Flow Example (Add to Cart)
```
1. User clicks "Add to Cart" button
   └─▶ POST /cart/add/:product_id
   
2. CartController#add_item
   ├─▶ Find product
   ├─▶ Check if logged in
   │   ├─ Yes: Use user_id
   │   └─ No: Use session_id
   ├─▶ Create/update CartItem
   └─▶ Redirect to cart
   
3. Cart page loads
   └─▶ Query CartItems (by user_id or session_id)
```

## Tech Stack

- **Framework**: Ruby on Rails 8.1
- **Database**: MySQL 5.7+
- **Authentication**: bcrypt
- **Frontend**: Turbo, Stimulus (Hotwire)
- **Assets**: Propshaft

## Setup

```bash
# Install dependencies
bundle install

# Create database
rails db:create db:migrate db:seed

# Start server
rails server
```

Visit: http://localhost:3000

**Test User**: 
- Email: `john@example.com`
- Password: `password123`

## Database Config

Edit `config/database.yml` for your MySQL setup:
- Default username: `root`
- Password: (set in database.yml)
- Database: `noticeboard_development`

## Models Relationships

```ruby
Category
  has_many :products

Product
  belongs_to :category

User
  has_many :cart_items
  has_many :orders

CartItem
  belongs_to :product
  belongs_to :user (optional - for guests)

Order
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

OrderItem
  belongs_to :order
  belongs_to :product
```

## Future Enhancements

- Admin dashboard (CRUD for products)
- Payment integration
- Product reviews
- Image uploads
- Email notifications
