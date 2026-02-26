-- ============================================
-- QUICK INSERT VEHICLES - Copy and Run
-- ============================================
-- Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- Make sure RLS policy exists first:
CREATE POLICY IF NOT EXISTS "Enable read access for all users" 
ON vehicles FOR SELECT USING (true);

-- Insert your 3 vehicles:
INSERT INTO vehicles (
  name, description, image_url, motor, battery, controller, tyre_size,
  max_speed, net_weight, load_capacity, brake, range, price, is_featured
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
  false
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
  true
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
  false
);

-- Verify:
SELECT * FROM vehicles;
