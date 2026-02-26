-- ============================================
-- SETUP VISIT TABLE FOR PINAKA ELECTRIC
-- ============================================
-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Create the visit table (if it doesn't exist)
CREATE TABLE IF NOT EXISTS visit (
  id BIGSERIAL PRIMARY KEY,
  address TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT NOT NULL,
  working_hours TEXT NOT NULL,
  map_url TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE visit ENABLE ROW LEVEL SECURITY;

-- 3. Create policy for public read access
DROP POLICY IF EXISTS "Enable read access for all users" ON visit;
CREATE POLICY "Enable read access for all users" 
ON visit 
FOR SELECT 
USING (true);

-- 4. Check if data already exists
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM visit LIMIT 1) THEN
    -- Insert initial office information only if table is empty
    INSERT INTO visit (address, phone, email, working_hours, map_url) VALUES (
      E'Garhi Choukhandi\nNear Qipl Building, Sector 68\nNoida, Gautam Buddha Nagar\nUttar Pradesh - 201301',
      '+91 7042182908',
      'pinakaelectric2908@gmail.com',
      'Mon - Sat: 9:00 AM - 7:00 PM',
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3503.640871889845!2d77.37719067550098!3d28.57738378656421!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce5f99cf56a7f%3A0x3ab5c265c5b7c5e!2sSector%2068%2C%20Noida%2C%20Uttar%20Pradesh%20201301!5e0!3m2!1sen!2sin!4v1706790000000!5m2!1sen!2sin'
    );
    RAISE NOTICE '✅ Initial office data inserted';
  ELSE
    RAISE NOTICE 'ℹ️  Data already exists, skipping insert';
  END IF;
END $$;

-- 5. Verify the data
SELECT * FROM visit;

-- 6. Count total rows
SELECT COUNT(*) as total_rows FROM visit;

-- ============================================
-- QUICK INSERT (if table is empty)
-- ============================================
-- If the above didn't work, manually insert:
/*
INSERT INTO visit (address, phone, email, working_hours) VALUES (
  E'Garhi Choukhandi\nNear Qipl Building, Sector 68\nNoida, Gautam Buddha Nagar\nUttar Pradesh - 201301',
  '+91 7042182908',
  'pinakaelectric2908@gmail.com',
  'Mon - Sat: 9:00 AM - 7:00 PM'
);
*/

-- ============================================
-- UPDATE EXISTING DATA
-- ============================================
/*
UPDATE visit 
SET 
  address = E'New Address Line 1\nNew Address Line 2\nNew Address Line 3\nNew Address Line 4',
  phone = '+91 1234567890',
  email = 'newemail@example.com',
  working_hours = 'Mon - Sun: 10:00 AM - 8:00 PM',
  updated_at = NOW()
WHERE id = 1;
*/

-- ============================================
-- DEBUGGING: Check if RLS is blocking
-- ============================================
-- Check RLS status
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename = 'visit';

-- Check policies
SELECT policyname, roles, cmd 
FROM pg_policies 
WHERE tablename = 'visit';

-- Test as anonymous user
SET ROLE anon;
SELECT * FROM visit;
RESET ROLE;
