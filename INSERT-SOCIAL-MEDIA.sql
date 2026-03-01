-- ============================================
-- QUICK INSERT - Social Media Links
-- ============================================
-- Copy and run this in Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new

-- Add your social media links (replace with your actual URLs):
INSERT INTO "socialMedia" (facebook, linkedin, twitter, instagram, youtube) VALUES (
  'https://www.facebook.com/pinakaelectric',
  'https://www.linkedin.com/company/pinakaelectric',
  'https://twitter.com/pinakaelectric',
  'https://www.instagram.com/pinakaelectric',
  'https://www.youtube.com/@pinakaelectric'
);

-- Verify it was inserted:
SELECT * FROM "socialMedia";
