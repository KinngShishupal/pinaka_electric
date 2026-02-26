# 🏢 Dynamic Office Information Setup

## What Was Done

I've made your office address, phone, email, and working hours **dynamic** - they now load from Supabase!

### Changes Made:

1. ✅ **HTML Updated** - Added IDs to contact elements:
   - `#officeAddress` - Address section
   - `#officePhone` - Phone number
   - `#officeEmail` - Email address
   - `#workingHours` - Working hours

2. ✅ **JavaScript Added** - New `loadOfficeInfo()` function in `main.js`:
   - Fetches office info from Supabase using `.single()`
   - Updates all contact elements dynamically
   - Handles multi-line addresses (splits by `\n`)

3. ✅ **SQL Created** - `setup-office-info.sql` to create the database table

---

## Setup Steps (2 Minutes)

### Step 1: Create the Database Table

1. Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new
2. Open `setup-office-info.sql` file
3. Copy ALL the SQL
4. Paste into Supabase SQL Editor
5. Click **RUN**

You should see:
```
✅ Table created: office_info
✅ RLS policy created
✅ 1 row inserted with your current office details
```

### Step 2: Test Your Website

1. Open your website
2. Hard refresh: `Ctrl + Shift + R`
3. Press `F12` → Console
4. Look for: `Office info loaded from Supabase: {address: "...", phone: "...", ...}`

---

## How It Works

### Database Structure

```sql
office_info table:
├── id (primary key)
├── address (text) - Multi-line address (use \n for new lines)
├── phone (text) - Phone number
├── email (text) - Email address
├── working_hours (text) - Working hours
├── map_url (text, optional) - Google Maps embed URL
└── updated_at (timestamp) - Last update time
```

### Query Used

```javascript
const { data, error } = await supabase
    .from('office_info')
    .select('*')
    .limit(1)
    .single();
```

- `.limit(1)` - Get only 1 record
- `.single()` - Return object instead of array

### Multi-line Address Format

In the database, use `\n` for new lines:
```
Garhi Choukhandi\nNear Qipl Building, Sector 68\nNoida, Gautam Buddha Nagar\nUttar Pradesh - 201301
```

JavaScript automatically splits this and creates separate `<p>` tags for each line.

---

## How to Update Office Info

### Option 1: Using Supabase Dashboard (Easiest)

1. Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor
2. Click `office_info` table
3. Click on any cell to edit
4. Make your changes
5. Click ✓ to save
6. Refresh your website - changes appear instantly!

### Option 2: Using SQL

Run this in SQL Editor:
```sql
UPDATE office_info 
SET 
  address = E'New Address\nLine 2\nLine 3',
  phone = '+91 9876543210',
  email = 'newemail@example.com',
  working_hours = 'Mon - Sun: 10:00 AM - 8:00 PM',
  updated_at = NOW()
WHERE id = 1;
```

---

## Benefits

✅ **Easy Updates** - Change office info without touching code  
✅ **No Redeployment** - Updates appear instantly  
✅ **Consistent Data** - Same info across all pages  
✅ **Version Control** - Track changes via `updated_at`  
✅ **Multiple Locations** - Can add multiple offices (just remove `.limit(1).single()`)

---

## Testing Checklist

After running the SQL:

- [ ] Open website and hard refresh (Ctrl+Shift+R)
- [ ] Check browser console for: "Office info loaded from Supabase"
- [ ] Verify address displays correctly (all 4 lines)
- [ ] Verify phone number is clickable (tel: link)
- [ ] Verify email is clickable (mailto: link)
- [ ] Verify working hours display correctly
- [ ] Test: Edit data in Supabase dashboard
- [ ] Test: Refresh website - see changes immediately

---

## Troubleshooting

### "No office info found in database"
**Solution:** Run `setup-office-info.sql` to insert initial data

### Empty fields on website
**Solution:** Check RLS policy exists:
```sql
CREATE POLICY "Enable read access for all users" 
ON office_info FOR SELECT USING (true);
```

### Console shows error
**Solution:** Check if table exists:
```sql
SELECT * FROM office_info;
```

---

## Future Enhancements (Optional)

### 1. Multiple Office Locations
Remove `.limit(1).single()` to support multiple offices:
```javascript
const { data, error } = await supabase
    .from('office_info')
    .select('*')
    .order('id');
// Returns array of all offices
```

### 2. Social Media Links
Add columns to table:
```sql
ALTER TABLE office_info 
ADD COLUMN facebook TEXT,
ADD COLUMN instagram TEXT,
ADD COLUMN twitter TEXT;
```

### 3. Admin Panel
Create a form on your website to update office info without accessing Supabase dashboard.

---

## Quick Reference

**View current data:**
```sql
SELECT * FROM office_info;
```

**Update phone:**
```sql
UPDATE office_info SET phone = '+91 NEW_NUMBER' WHERE id = 1;
```

**Update email:**
```sql
UPDATE office_info SET email = 'newemail@example.com' WHERE id = 1;
```

**Update working hours:**
```sql
UPDATE office_info SET working_hours = 'New hours here' WHERE id = 1;
```

**Update address:**
```sql
UPDATE office_info SET address = E'Line 1\nLine 2\nLine 3\nLine 4' WHERE id = 1;
```

---

**Your office information is now fully dynamic! 🎉**
