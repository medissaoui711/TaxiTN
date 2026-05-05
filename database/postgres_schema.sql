-- TaxiTN PostgreSQL Database Schema
-- Version: 1.0.0
-- Database: PostgreSQL 15+ with PostGIS extension

-- Enable PostGIS extension for geospatial queries
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    avatar_url VARCHAR(500),
    role VARCHAR(20) NOT NULL CHECK (role IN ('customer', 'driver', 'restaurant', 'admin')),
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    fcm_token VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- User preferences
CREATE TABLE user_preferences (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    language VARCHAR(10) DEFAULT 'ar',
    notifications_enabled BOOLEAN DEFAULT TRUE,
    dark_mode BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Driver profiles
CREATE TABLE driver_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'suspended', 'rejected')),
    vehicle_type VARCHAR(20) NOT NULL CHECK (vehicle_type IN ('taxi', 'go', 'business', 'max')),
    vehicle_make VARCHAR(100),
    vehicle_model VARCHAR(100),
    vehicle_year INTEGER,
    vehicle_color VARCHAR(50),
    license_plate VARCHAR(50) NOT NULL,
    license_number VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1) DEFAULT 5.0 CHECK (rating >= 0 AND rating <= 5),
    total_rides INTEGER DEFAULT 0,
    total_earnings DECIMAL(10,2) DEFAULT 0.00,
    is_online BOOLEAN DEFAULT FALSE,
    current_location GEOGRAPHY(POINT, 4326),
    last_location_update TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Driver documents
CREATE TABLE driver_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    driver_id UUID REFERENCES driver_profiles(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    url VARCHAR(500) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    uploaded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Restaurants
CREATE TABLE restaurants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_id UUID REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    cuisine_type VARCHAR(100),
    description TEXT,
    phone VARCHAR(20),
    email VARCHAR(255),
    logo_url VARCHAR(500),
    cover_url VARCHAR(500),
    location GEOGRAPHY(POINT, 4326) NOT NULL,
    address TEXT NOT NULL,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    delivery_time_min INTEGER,
    delivery_fee DECIMAL(8,2) DEFAULT 0.00,
    min_order_amount DECIMAL(8,2) DEFAULT 0.00,
    is_open BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    opening_hours JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Menu categories
CREATE TABLE menu_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Menu items
CREATE TABLE menu_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE CASCADE,
    category_id UUID REFERENCES menu_categories(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(8,2) NOT NULL,
    image_url VARCHAR(500),
    is_available BOOLEAN DEFAULT TRUE,
    is_popular BOOLEAN DEFAULT FALSE,
    options JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Rides
CREATE TABLE rides (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID REFERENCES users(id) ON DELETE SET NULL,
    driver_id UUID REFERENCES driver_profiles(id) ON DELETE SET NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'driver_arrived', 'in_progress', 'completed', 'cancelled')),
    service_type VARCHAR(20) NOT NULL CHECK (service_type IN ('taxi', 'go', 'business', 'max')),
    pickup_location GEOGRAPHY(POINT, 4326) NOT NULL,
    pickup_address TEXT NOT NULL,
    destination_location GEOGRAPHY(POINT, 4326) NOT NULL,
    destination_address TEXT NOT NULL,
    estimated_distance_km DECIMAL(6,2),
    estimated_duration_min INTEGER,
    estimated_fare DECIMAL(8,2),
    actual_distance_km DECIMAL(6,2),
    actual_duration_min INTEGER,
    actual_fare DECIMAL(8,2),
    cancellation_reason TEXT,
    cancelled_by VARCHAR(20) CHECK (cancelled_by IN ('customer', 'driver', 'system')),
    payment_method VARCHAR(20) CHECK (payment_method IN ('cash', 'wallet', 'card')),
    payment_status VARCHAR(20) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
    promo_code VARCHAR(50),
    discount_amount DECIMAL(8,2) DEFAULT 0.00,
    customer_rating INTEGER CHECK (customer_rating >= 1 AND customer_rating <= 5),
    driver_rating INTEGER CHECK (driver_rating >= 1 AND driver_rating <= 5),
    customer_notes TEXT,
    driver_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    accepted_at TIMESTAMP WITH TIME ZONE,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE
);

-- Orders (Food/Grocery)
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID REFERENCES users(id) ON DELETE SET NULL,
    restaurant_id UUID REFERENCES restaurants(id) ON DELETE SET NULL,
    driver_id UUID REFERENCES driver_profiles(id) ON DELETE SET NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'preparing', 'ready_for_pickup', 'picked_up', 'delivering', 'completed', 'cancelled')),
    order_type VARCHAR(20) NOT NULL CHECK (order_type IN ('delivery', 'pickup')),
    delivery_location GEOGRAPHY(POINT, 4326),
    delivery_address TEXT,
    subtotal DECIMAL(8,2) NOT NULL,
    delivery_fee DECIMAL(8,2) DEFAULT 0.00,
    tax_amount DECIMAL(8,2) DEFAULT 0.00,
    discount_amount DECIMAL(8,2) DEFAULT 0.00,
    total_amount DECIMAL(8,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'pending',
    estimated_delivery_time TIMESTAMP WITH TIME ZONE,
    actual_delivery_time TIMESTAMP WITH TIME ZONE,
    customer_notes TEXT,
    cancellation_reason TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Order items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id UUID REFERENCES menu_items(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(8,2) NOT NULL,
    total_price DECIMAL(8,2) NOT NULL,
    options JSONB,
    notes TEXT
);

-- Wallets
CREATE TABLE wallets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    balance DECIMAL(10,2) DEFAULT 0.00,
    currency VARCHAR(3) DEFAULT 'TND',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Wallet transactions
CREATE TABLE wallet_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE,
    type VARCHAR(20) NOT NULL CHECK (type IN ('credit', 'debit', 'refund')),
    amount DECIMAL(10,2) NOT NULL,
    balance_after DECIMAL(10,2) NOT NULL,
    description TEXT,
    reference_id UUID,
    reference_type VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Payment methods
CREATE TABLE payment_methods (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(20) NOT NULL CHECK (type IN ('card', 'wallet', 'cash')),
    provider VARCHAR(50),
    last_four VARCHAR(4),
    expiry_month INTEGER,
    expiry_year INTEGER,
    is_default BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    token VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Promo codes
CREATE TABLE promo_codes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(50) UNIQUE NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('percentage', 'fixed_amount')),
    value DECIMAL(8,2) NOT NULL,
    min_order_amount DECIMAL(8,2) DEFAULT 0.00,
    max_discount_amount DECIMAL(8,2),
    usage_limit INTEGER,
    usage_count INTEGER DEFAULT 0,
    valid_from TIMESTAMP WITH TIME ZONE,
    valid_until TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Notifications
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    data JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_fcm_token ON users(fcm_token);

CREATE INDEX idx_driver_profiles_user_id ON driver_profiles(user_id);
CREATE INDEX idx_driver_profiles_status ON driver_profiles(status);
CREATE INDEX idx_driver_profiles_is_online ON driver_profiles(is_online);
CREATE INDEX idx_driver_profiles_location ON driver_profiles USING GIST(current_location);

CREATE INDEX idx_restaurants_location ON restaurants USING GIST(location);
CREATE INDEX idx_restaurants_cuisine ON restaurants(cuisine_type);
CREATE INDEX idx_restaurants_is_open ON restaurants(is_open);

CREATE INDEX idx_menu_items_restaurant ON menu_items(restaurant_id);
CREATE INDEX idx_menu_items_category ON menu_items(category_id);
CREATE INDEX idx_menu_items_is_available ON menu_items(is_available);

CREATE INDEX idx_rides_customer ON rides(customer_id);
CREATE INDEX idx_rides_driver ON rides(driver_id);
CREATE INDEX idx_rides_status ON rides(status);
CREATE INDEX idx_rides_created_at ON rides(created_at);
CREATE INDEX idx_rides_pickup_location ON rides USING GIST(pickup_location);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_driver ON orders(driver_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);

CREATE INDEX idx_wallet_transactions_wallet ON wallet_transactions(wallet_id);
CREATE INDEX idx_wallet_transactions_created_at ON wallet_transactions(created_at);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);

-- Functions and Triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger to all tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_driver_profiles_updated_at BEFORE UPDATE ON driver_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_restaurants_updated_at BEFORE UPDATE ON restaurants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_menu_items_updated_at BEFORE UPDATE ON menu_items
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_rides_updated_at BEFORE UPDATE ON rides
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_wallets_updated_at BEFORE UPDATE ON wallets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
