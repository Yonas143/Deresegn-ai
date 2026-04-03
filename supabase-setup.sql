-- ============================================
-- ScanLogic Supabase Setup Script
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Create receipts table
CREATE TABLE IF NOT EXISTS receipts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  telegram_id TEXT NOT NULL,
  message_id TEXT,
  merchant TEXT,
  total NUMERIC,
  currency TEXT,
  date DATE,
  category TEXT,
  items JSONB,
  file_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_receipts_telegram_id ON receipts(telegram_id);
CREATE INDEX IF NOT EXISTS idx_receipts_merchant ON receipts(merchant);
CREATE INDEX IF NOT EXISTS idx_receipts_created_at ON receipts(created_at DESC);

-- 3. Enable Row Level Security
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

-- 4. Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Service role can do everything" ON receipts;
DROP POLICY IF EXISTS "Allow bot to insert and select" ON receipts;

-- 5. Create policies for the bot
CREATE POLICY "Service role can do everything"
ON receipts
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow bot to insert and select"
ON receipts
FOR ALL
TO anon
USING (true)
WITH CHECK (true);

-- 6. Storage policies for 'deresegn' bucket
-- Note: Run these separately if you get errors

-- Allow public read access to photos
DROP POLICY IF EXISTS "Public Access" ON storage.objects;
CREATE POLICY "Public Access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'deresegn');

-- Allow bot to upload photos
DROP POLICY IF EXISTS "Allow uploads" ON storage.objects;
CREATE POLICY "Allow uploads"
ON storage.objects FOR INSERT
TO anon
WITH CHECK (bucket_id = 'deresegn');

-- Allow bot to delete photos (optional)
DROP POLICY IF EXISTS "Allow deletes" ON storage.objects;
CREATE POLICY "Allow deletes"
ON storage.objects FOR DELETE
TO anon
USING (bucket_id = 'deresegn');

-- ============================================
-- Verification Queries
-- ============================================

-- Check if table was created
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'receipts';

-- Check if indexes were created
SELECT indexname 
FROM pg_indexes 
WHERE tablename = 'receipts';

-- Check RLS is enabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'receipts';

-- ============================================
-- Done! Your database is ready.
-- ============================================
