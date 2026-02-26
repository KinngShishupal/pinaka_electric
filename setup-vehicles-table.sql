-- ============================================
-- SETUP VEHICLES TABLE FOR PINAKA ELECTRIC
-- ============================================
-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Create the vehicles table
CREATE TABLE IF NOT EXISTS vehicles (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  image_url TEXT,
  motor TEXT,
  battery TEXT,
  controller TEXT,
  tyre_size TEXT,
  max_speed TEXT,
  net_weight TEXT,
  load_capacity TEXT,
  brake TEXT,
  range TEXT,
  price TEXT,
  is_featured BOOLEAN DEFAULT false,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE vehicles ENABLE ROW LEVEL SECURITY;

-- 3. Create policy for public read access
DROP POLICY IF EXISTS "Enable read access for all users" ON vehicles;
CREATE POLICY "Enable read access for all users" 
ON vehicles 
FOR SELECT 
USING (true);

-- 4. Insert your existing vehicles
INSERT INTO vehicles (
  name, description, image_url, motor, battery, controller, tyre_size, 
  max_speed, net_weight, load_capacity, brake, range, price, is_featured, display_order
) VALUES 
(
  'TurBoX',
  'High-performance electric scooter with advanced features',
  'images/scooter-blue.png',
  '1000W',
  '48/60V, 32Ah',
  '48/60V',
  '10/10 Inches',
  '25 km/h',
  '80 Kg',
  '120 Kg',
  'F Disc / R Drum',
  '50-80 Km per charge',
  'Contact for Price',
  false,
  1
),
(
  'P-BMW',
  'Premium electric scooter with sophisticated design and powerful performance',
  'images/p_bmw.jpeg',
  '1000W',
  '48/60V, 32Ah',
  '48/60V',
  '10/10 Inches',
  '25 km/h',
  '80 Kg',
  '120 Kg',
  'F Disc / R Drum',
  '50-80 Km per charge',
  'Contact for Price',
  true,  -- Featured model
  2
),
(
  'Blaze-Fusion',
  'Advanced electric scooter with superior performance and blazing speed',
  'images/blaze-fusion.png',
  '1000W',
  '48/60V, 32Ah',
  '48/60V',
  '10/10, 12/10 Inches',
  '25 km/h',
  '80 Kg',
  '120 Kg',
  'F Disc / R Drum, F/R Disc',
  '50-80 Km per charge',
  'Contact for Price',
  false,
  3
);

-- 5. Verify the data was inserted
SELECT id, name, is_featured, display_order FROM vehicles ORDER BY display_order;

-- 6. View all vehicles
SELECT * FROM vehicles ORDER BY created_at DESC;

-- ============================================
-- OPTIONAL: Add more vehicles
-- ============================================
/*
INSERT INTO vehicles (
  name, description, image_url, motor, battery, controller, tyre_size,
  max_speed, net_weight, load_capacity, brake, range, price, is_featured, display_order
) VALUES (
  'New Model Name',
  'Description of the new model',
  'images/new-model.png',
  '1500W',
  '60V, 40Ah',
  '60V',
  '12/12 Inches',
  '30 km/h',
  '85 Kg',
  '150 Kg',
  'F/R Disc',
  '60-100 Km per charge',
  '₹65,000',
  false,
  4
);
*/

-- ============================================
-- UPDATE VEHICLE
-- ============================================
/*
UPDATE vehicles 
SET 
  price = '₹55,000',
  range = '60-90 Km per charge',
  is_featured = true
WHERE name = 'TurBoX';
*/

-- ============================================
-- DELETE VEHICLE
-- ============================================
/*
DELETE FROM vehicles WHERE id = 1;
*/

-- ============================================
-- REORDER VEHICLES (change display order)
-- ============================================
/*
UPDATE vehicles SET display_order = 1 WHERE name = 'P-BMW';
UPDATE vehicles SET display_order = 2 WHERE name = 'TurBoX';
UPDATE vehicles SET display_order = 3 WHERE name = 'Blaze-Fusion';
*/
