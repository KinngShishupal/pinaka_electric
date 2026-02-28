-- ============================================
-- SETUP DEALER INQUIRIES TABLE FOR PINAKA ELECTRIC
-- ============================================
-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Create the dealer_inquiries table
CREATE TABLE IF NOT EXISTS dealer_inquiries (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  investment_capacity TEXT NOT NULL,
  message TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  contacted_at TIMESTAMPTZ,
  notes TEXT
);

-- 2. Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_dealer_inquiries_created_at ON dealer_inquiries(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_dealer_inquiries_status ON dealer_inquiries(status);
CREATE INDEX IF NOT EXISTS idx_dealer_inquiries_email ON dealer_inquiries(email);
CREATE INDEX IF NOT EXISTS idx_dealer_inquiries_state ON dealer_inquiries(state);

-- 3. Enable Row Level Security
ALTER TABLE dealer_inquiries ENABLE ROW LEVEL SECURITY;

-- 4. Create policy for INSERT (allow anyone to submit)
DROP POLICY IF EXISTS "Enable insert for all users" ON dealer_inquiries;
CREATE POLICY "Enable insert for all users" 
ON dealer_inquiries 
FOR INSERT 
WITH CHECK (true);

-- 5. Create policy for SELECT (only authenticated users can view)
DROP POLICY IF EXISTS "Enable read for authenticated users only" ON dealer_inquiries;
CREATE POLICY "Enable read for authenticated users only" 
ON dealer_inquiries 
FOR SELECT 
TO authenticated
USING (true);

-- 6. Create policy for UPDATE (only authenticated users can update)
DROP POLICY IF EXISTS "Enable update for authenticated users only" ON dealer_inquiries;
CREATE POLICY "Enable update for authenticated users only" 
ON dealer_inquiries 
FOR UPDATE 
TO authenticated
USING (true)
WITH CHECK (true);

-- 7. Verify table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'dealer_inquiries' 
ORDER BY ordinal_position;

-- ============================================
-- TEST: Insert a sample dealer inquiry
-- ============================================
/*
INSERT INTO dealer_inquiries (name, email, phone, city, state, investment_capacity, message) 
VALUES (
  'Test Dealer Company', 
  'dealer@example.com', 
  '+91 9876543210', 
  'Mumbai', 
  'Maharashtra',
  '10-25-lakh',
  'I have 5 years of experience in automobile sales and want to become a dealer in Mumbai area.'
);

-- View all dealer inquiries
SELECT * FROM dealer_inquiries ORDER BY created_at DESC;
*/

-- ============================================
-- MANAGEMENT QUERIES
-- ============================================

-- View today's dealer inquiries
SELECT id, name, email, phone, city, state, investment_capacity, created_at 
FROM dealer_inquiries 
WHERE created_at::date = CURRENT_DATE 
ORDER BY created_at DESC;

-- Count inquiries by state
SELECT state, COUNT(*) as total 
FROM dealer_inquiries 
GROUP BY state 
ORDER BY total DESC;

-- Count inquiries by investment capacity
SELECT investment_capacity, COUNT(*) as total 
FROM dealer_inquiries 
GROUP BY investment_capacity 
ORDER BY total DESC;

-- Count inquiries by status
SELECT status, COUNT(*) as total 
FROM dealer_inquiries 
GROUP BY status;

-- View pending inquiries
SELECT id, name, email, phone, city, state, created_at
FROM dealer_inquiries 
WHERE status = 'pending'
ORDER BY created_at DESC;

-- Mark inquiry as contacted
UPDATE dealer_inquiries 
SET status = 'contacted', contacted_at = NOW() 
WHERE id = 1;

-- Mark inquiry as approved
UPDATE dealer_inquiries 
SET status = 'approved' 
WHERE id = 1;

-- Mark inquiry as rejected
UPDATE dealer_inquiries 
SET status = 'rejected' 
WHERE id = 1;

-- Add notes to inquiry
UPDATE dealer_inquiries 
SET notes = 'Promising candidate, good experience in auto sales' 
WHERE id = 1;

-- ============================================
-- ANALYTICS QUERIES
-- ============================================

-- This month's inquiries
SELECT COUNT(*) as this_month 
FROM dealer_inquiries 
WHERE created_at >= DATE_TRUNC('month', CURRENT_DATE);

-- This week's inquiries
SELECT COUNT(*) as this_week 
FROM dealer_inquiries 
WHERE created_at >= DATE_TRUNC('week', CURRENT_DATE);

-- High investment capacity leads (above 25 lakh)
SELECT id, name, email, phone, city, state 
FROM dealer_inquiries 
WHERE investment_capacity = 'above-25-lakh'
ORDER BY created_at DESC;

-- State-wise distribution
SELECT 
  state,
  COUNT(*) as total_inquiries,
  COUNT(CASE WHEN status = 'approved' THEN 1 END) as approved,
  COUNT(CASE WHEN status = 'pending' THEN 1 END) as pending
FROM dealer_inquiries 
GROUP BY state 
ORDER BY total_inquiries DESC;

-- ============================================
-- CLEANUP (Optional)
-- ============================================
-- Delete old test data
-- DELETE FROM dealer_inquiries WHERE email LIKE '%test%' OR email LIKE '%example%';

-- ============================================
-- EXPORT DATA
-- ============================================
-- Export all dealer inquiries to CSV (run in Supabase dashboard)
-- Go to Table Editor → dealer_inquiries → Export → CSV
