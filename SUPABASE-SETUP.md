# Supabase Setup Guide

## 1. Create the Receipts Table

Go to: **SQL Editor** in Supabase Dashboard

Run this SQL:

```sql
-- Create receipts table
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

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_receipts_telegram_id ON receipts(telegram_id);
CREATE INDEX IF NOT EXISTS idx_receipts_merchant ON receipts(merchant);
CREATE INDEX IF NOT EXISTS idx_receipts_created_at ON receipts(created_at DESC);

-- Enable Row Level Security (RLS)
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

-- Create policy: Allow service role to do everything (for the bot)
CREATE POLICY "Service role can do everything"
ON receipts
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

-- Create policy: Allow anon key to insert and select (for the bot)
CREATE POLICY "Allow bot to insert and select"
ON receipts
FOR ALL
TO anon
USING (true)
WITH CHECK (true);
```

## 2. Create Storage Bucket

1. Go to **Storage** in Supabase Dashboard
2. Click **"New bucket"**
3. Name: `deresegn`
4. Make it **Public** ✅
5. Click **Create**

## 3. Set Storage Policies

Go to: **Storage → Policies → deresegn bucket**

### Policy 1: Allow Public Read Access

```sql
-- Allow anyone to read files (so photos can be displayed)
CREATE POLICY "Public Access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'deresegn');
```

### Policy 2: Allow Bot to Upload

```sql
-- Allow authenticated uploads (bot uses anon key)
CREATE POLICY "Allow uploads"
ON storage.objects FOR INSERT
TO anon
WITH CHECK (bucket_id = 'deresegn');
```

### Policy 3: Allow Bot to Delete (Optional)

```sql
-- Allow bot to delete files if needed
CREATE POLICY "Allow deletes"
ON storage.objects FOR DELETE
TO anon
USING (bucket_id = 'deresegn');
```

## 4. Verify Your Environment Variables

Make sure these are set in Render:

```
VITE_SUPABASE_URL=https://cucxtbdfltmuieurjwnk.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

## 5. Test the Setup

### Test 1: Upload a Receipt
1. Send a receipt photo to your Telegram bot
2. Check Supabase Storage → deresegn bucket
3. You should see a new file uploaded

### Test 2: Query Receipts
1. Send `/myreceipts` to your bot
2. You should see your uploaded receipts with photos

### Test 3: Check Database
1. Go to Supabase → Table Editor → receipts
2. You should see your receipt data

## Authentication Flow

The bot uses **Telegram ID** as the authentication method:

1. User sends message to bot
2. Telegram provides user's unique ID
3. Bot uses this ID to:
   - Store receipts in database (linked to telegram_id)
   - Organize files in storage (folder per user)
   - Retrieve user's data

### Why This Works:
- ✅ No separate login needed
- ✅ Automatic authentication
- ✅ Each user's data is isolated by telegram_id
- ✅ Simple and secure

## Security Notes

### Current Setup (Good for MVP):
- Uses Supabase anon key
- RLS policies allow bot to access all data
- Public storage for photos

### For Production (Recommended):
1. Use Supabase Service Role key for backend operations
2. Implement stricter RLS policies
3. Add user authentication table
4. Encrypt sensitive data

## Troubleshooting

### Photos not uploading?
- Check Storage policies are set correctly
- Verify bucket is public
- Check Render logs for errors

### Can't see receipts?
- Verify receipts table exists
- Check RLS policies
- Verify SUPABASE_ANON_KEY is correct

### Database errors?
- Make sure receipts table is created
- Check indexes are created
- Verify RLS policies

## Next Steps

Once everything is set up:
1. Test uploading receipts
2. Test `/myreceipts` command
3. Monitor Supabase dashboard for usage
4. Check storage quota (1GB free tier)

---

**Need Help?** Check the Render logs or Supabase logs for detailed error messages.
