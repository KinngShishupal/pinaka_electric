-- ============================================
-- SETUP SOCIAL MEDIA TABLE FOR PINAKA ELECTRIC
-- ============================================
-- Run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- 1. Create the socialMedia table
CREATE TABLE IF NOT EXISTS "socialMedia" (
  id BIGSERIAL PRIMARY KEY,
  facebook TEXT,
  linkedin TEXT,
  twitter TEXT,
  instagram TEXT,
  youtube TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE "socialMedia" ENABLE ROW LEVEL SECURITY;

-- 3. Create policy for public read access
DROP POLICY IF EXISTS "Enable read access for all users" ON "socialMedia";
CREATE POLICY "Enable read access for all users" 
ON "socialMedia" 
FOR SELECT 
USING (true);

-- 4. Insert initial social media links (replace with your actual links)
INSERT INTO "socialMedia" (facebook, linkedin, twitter, instagram, youtube) VALUES (
  'https://www.facebook.com/pinakaelectric',
  'https://www.linkedin.com/company/pinakaelectric',
  'https://twitter.com/pinakaelectric',
  'https://www.instagram.com/pinakaelectric',
  'https://www.youtube.com/@pinakaelectric'
);

-- 5. Verify the data
SELECT * FROM "socialMedia";

-- ============================================
-- UPDATE SOCIAL MEDIA LINKS (run anytime)
-- ============================================
/*
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/yourpage',
  linkedin = 'https://www.linkedin.com/company/yourcompany',
  twitter = 'https://twitter.com/yourhandle',
  instagram = 'https://www.instagram.com/yourhandle',
  youtube = 'https://www.youtube.com/@yourchannel',
  updated_at = NOW()
WHERE id = 1;
*/

-- ============================================
-- HIDE A SOCIAL MEDIA LINK (set to NULL)
-- ============================================
/*
-- Hide Facebook (won't show on website)
UPDATE "socialMedia" SET facebook = NULL WHERE id = 1;

-- Hide Twitter
UPDATE "socialMedia" SET twitter = NULL WHERE id = 1;
*/

-- ============================================
-- VIEW CURRENT LINKS
-- ============================================
-- SELECT * FROM "socialMedia";

-- ============================================
-- EXAMPLE: Real social media URLs
-- ============================================
/*
-- Update with your actual social media pages:
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/pinakaelectric',
  linkedin = 'https://www.linkedin.com/company/pinaka-electric',
  twitter = 'https://twitter.com/pinaka_electric',
  instagram = 'https://www.instagram.com/pinakaelectric/',
  youtube = 'https://www.youtube.com/@pinakaelectric'
WHERE id = 1;
*/
