-- ============================================
-- DATABASE DIAGNOSTIC - Run these queries one by one
-- ============================================
-- Run in: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- ============================================
-- 1. CHECK IF TABLE EXISTS
-- ============================================
SELECT EXISTS (
   SELECT FROM information_schema.tables 
   WHERE table_schema = 'public'
   AND table_name = 'reviews'
) AS table_exists;
-- Expected: true
-- If false: Table doesn't exist, run setup-reviews-table.sql


-- ============================================
-- 2. CHECK TABLE STRUCTURE
-- ============================================
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'reviews'
ORDER BY ordinal_position;
-- Expected: id, name, title, review_text, rating, created_at


-- ============================================
-- 3. COUNT TOTAL ROWS
-- ============================================
SELECT COUNT(*) as total_reviews FROM reviews;
-- Expected: > 0
-- If 0: Table is empty, add data below


-- ============================================
-- 4. VIEW ALL REVIEWS
-- ============================================
SELECT * FROM reviews ORDER BY created_at DESC;
-- This shows all your reviews


-- ============================================
-- 5. CHECK RLS (Row Level Security) STATUS
-- ============================================
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename = 'reviews';
-- rowsecurity = true means RLS is enabled


-- ============================================
-- 6. CHECK RLS POLICIES
-- ============================================
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
FROM pg_policies
WHERE tablename = 'reviews';
-- Should show a policy that allows SELECT for public/anon role


-- ============================================
-- 7. TEST QUERY AS ANONYMOUS USER
-- ============================================
-- This simulates what your website sees
SET ROLE anon;
SELECT * FROM reviews;
RESET ROLE;
-- If this fails or returns empty, your RLS policy is blocking


-- ============================================
-- FIXES
-- ============================================

-- ============================================
-- FIX 1: If table is empty, add sample data
-- ============================================
INSERT INTO reviews (name, title, review_text, rating) VALUES
('Rajesh Kumar', 'Daily Commuter', 'This scooter has transformed my commute!', 5),
('Priya Sharma', 'Tech Professional', 'Amazing battery life and build quality!', 5),
('Amit Patel', 'Environmental Advocate', 'Eco-friendly and powerful!', 5);


-- ============================================
-- FIX 2: If RLS is blocking, create proper policy
-- ============================================
-- Drop existing policies
DROP POLICY IF EXISTS "Enable read access for all users" ON reviews;

-- Create new policy that allows public reads
CREATE POLICY "Enable read access for all users" 
ON reviews 
FOR SELECT 
USING (true);


-- ============================================
-- FIX 3: If still not working, temporarily disable RLS (NOT recommended for production)
-- ============================================
ALTER TABLE reviews DISABLE ROW LEVEL SECURITY;
-- CAUTION: This makes the table publicly readable without any restrictions
-- Use only for testing, then re-enable with proper policies:
-- ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;


-- ============================================
-- FIX 4: Enable RLS with proper policy (recommended)
-- ============================================
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- Allow anonymous users to read all reviews
CREATE POLICY "Public reviews are viewable by everyone" 
ON reviews 
FOR SELECT 
TO anon, authenticated
USING (true);


-- ============================================
-- VERIFICATION: Test everything works
-- ============================================
-- Run this to verify your setup
DO $$
DECLARE
    review_count INTEGER;
    rls_enabled BOOLEAN;
    policy_count INTEGER;
BEGIN
    -- Check row count
    SELECT COUNT(*) INTO review_count FROM reviews;
    RAISE NOTICE 'Total reviews: %', review_count;
    
    -- Check RLS status
    SELECT rowsecurity INTO rls_enabled 
    FROM pg_tables 
    WHERE tablename = 'reviews' AND schemaname = 'public';
    RAISE NOTICE 'RLS enabled: %', rls_enabled;
    
    -- Check policy count
    SELECT COUNT(*) INTO policy_count 
    FROM pg_policies 
    WHERE tablename = 'reviews';
    RAISE NOTICE 'Active policies: %', policy_count;
    
    -- Summary
    IF review_count = 0 THEN
        RAISE WARNING '⚠️  Table is empty! Add data using INSERT statements above';
    ELSIF review_count > 0 AND rls_enabled AND policy_count = 0 THEN
        RAISE WARNING '⚠️  RLS is ON but no policies exist! Add policy or disable RLS';
    ELSE
        RAISE NOTICE '✅ Setup looks good!';
    END IF;
END $$;
