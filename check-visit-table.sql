-- ============================================
-- CHECK VISIT TABLE - Quick Diagnostic
-- ============================================
-- Run this to see what's wrong
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Does the table exist?
SELECT EXISTS (
   SELECT FROM information_schema.tables 
   WHERE table_schema = 'public'
   AND table_name = 'visit'
) AS table_exists;
-- Expected: true


-- 2. How many rows are in the table?
SELECT COUNT(*) as total_rows FROM visit;
-- Expected: >= 1
-- If 0: Table is EMPTY - this is your problem!


-- 3. View all data
SELECT * FROM visit;
-- If this returns rows, table has data


-- 4. Is RLS enabled?
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'visit';
-- rowsecurity = true means RLS is ON


-- 5. What policies exist?
SELECT policyname, cmd 
FROM pg_policies 
WHERE tablename = 'visit';
-- Should show at least one SELECT policy


-- ============================================
-- QUICK FIX: Add data if table is empty
-- ============================================
INSERT INTO visit (address, phone, email, working_hours) VALUES (
  E'Garhi Choukhandi\nNear Qipl Building, Sector 68\nNoida, Gautam Buddha Nagar\nUttar Pradesh - 201301',
  '+91 7042182908',
  'pinakaelectric2908@gmail.com',
  'Mon - Sat: 9:00 AM - 7:00 PM'
);

-- Verify it was inserted
SELECT * FROM visit;
