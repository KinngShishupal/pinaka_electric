-- ============================================
-- SETUP SPECS TABLE FOR HERO STATS
-- ============================================
-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Create the specs table
CREATE TABLE IF NOT EXISTS specs (
  id BIGSERIAL PRIMARY KEY,
  range INTEGER NOT NULL,
  speed INTEGER NOT NULL,
  charge_time INTEGER NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE specs ENABLE ROW LEVEL SECURITY;

-- 3. Create policy for public read access
DROP POLICY IF EXISTS "Enable read access for all users" ON specs;
CREATE POLICY "Enable read access for all users" 
ON specs 
FOR SELECT 
USING (true);

-- 4. Insert initial specs data
INSERT INTO specs (range, speed, charge_time) VALUES (
  75,   -- km Range
  45,   -- km/h Speed
  3     -- Hours to charge
);

-- 5. Verify the data
SELECT * FROM specs;

-- ============================================
-- UPDATE SPECS (run anytime you want to change)
-- ============================================
/*
UPDATE specs 
SET 
  range = 80,
  speed = 50,
  charge_time = 2.5,
  updated_at = NOW()
WHERE id = 1;
*/

-- ============================================
-- VIEW CURRENT SPECS
-- ============================================
-- SELECT * FROM specs;
