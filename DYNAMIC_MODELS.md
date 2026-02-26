# 🚗 Dynamic Vehicle Models Setup

## What Was Done

I've made your **Models section** fully dynamic - all scooter models now load from Supabase!

### Changes Made:

1. ✅ **HTML Updated** - Added ID to models container
2. ✅ **JavaScript Added** - New `loadVehicles()` and `createVehicleCard()` functions
3. ✅ **SQL Created** - Complete vehicles table with your 3 current models

---

## 🚀 Setup (2 Minutes)

### Step 1: Create the Database Table

1. Go to: **https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new**
2. Open `setup-vehicles-table.sql`
3. Copy ALL the SQL
4. Paste into Supabase SQL Editor
5. Click **RUN**

You should see:
```
✅ Table created: vehicles
✅ RLS policy created
✅ 3 rows inserted (TurBoX, P-BMW, Blaze-Fusion)
```

### Step 2: Test Your Website

1. Open your website
2. Hard refresh: `Ctrl + Shift + R`
3. Press `F12` → Console
4. Look for: `Vehicles loaded from Supabase: [...]`
5. Scroll to Models section - should show your 3 scooters

---

## 📊 Database Structure

```javascript
vehicles table columns:
├── id (primary key)
├── name (text) - Model name (e.g., "TurBoX")
├── description (text) - Short description
├── image_url (text) - Path to image (e.g., "images/scooter-blue.png")
├── motor (text) - Motor spec (e.g., "1000W")
├── battery (text) - Battery spec (e.g., "48/60V, 32Ah")
├── controller (text) - Controller spec
├── tyre_size (text) - Tyre size
├── max_speed (text) - Maximum speed
├── net_weight (text) - Weight
├── load_capacity (text) - Load capacity
├── brake (text) - Brake type
├── range (text) - Range per charge
├── price (text) - Price or "Contact for Price"
├── is_featured (boolean) - Show as premium/featured
├── display_order (integer) - Order to display (1, 2, 3...)
└── created_at (timestamp) - Creation date
```

### Query Used

```javascript
const { data, error } = await supabase
    .from('vehicles')
    .select('*')
    .order('created_at', { ascending: false });
```

This returns an array of all vehicles, newest first.

---

## 🎨 Features

### ✅ Featured Models
Set `is_featured = true` to display with premium badge and styling:
```sql
UPDATE vehicles SET is_featured = true WHERE name = 'P-BMW';
```

### ✅ Display Order
Control the order models appear:
```sql
UPDATE vehicles SET display_order = 1 WHERE name = 'TurBoX';
UPDATE vehicles SET display_order = 2 WHERE name = 'P-BMW';
UPDATE vehicles SET display_order = 3 WHERE name = 'Blaze-Fusion';
```

Then update JavaScript to order by `display_order`:
```javascript
.order('display_order', { ascending: true });
```

### ✅ Dynamic Specs
All specifications are pulled from database - update anytime!

---

## 🔧 How to Manage Vehicles

### Add New Vehicle

```sql
INSERT INTO vehicles (
  name, description, image_url, motor, battery, controller, tyre_size,
  max_speed, net_weight, load_capacity, brake, range, price, is_featured
) VALUES (
  'Thunder X',
  'Ultra-high performance electric scooter',
  'images/thunder-x.png',
  '1500W',
  '60V, 40Ah',
  '60V',
  '12/12 Inches',
  '30 km/h',
  '85 Kg',
  '150 Kg',
  'F/R Disc',
  '70-100 Km per charge',
  '₹75,000',
  false
);
```

### Update Existing Vehicle

```sql
UPDATE vehicles 
SET 
  price = '₹55,000',
  range = '60-90 Km per charge',
  max_speed = '28 km/h'
WHERE name = 'TurBoX';
```

### Delete Vehicle

```sql
DELETE FROM vehicles WHERE name = 'Old Model Name';
```

### Mark as Featured

```sql
UPDATE vehicles SET is_featured = true WHERE name = 'P-BMW';
UPDATE vehicles SET is_featured = false WHERE name = 'TurBoX';
```

---

## 🖼️ Image Management

### Upload Images
1. Put images in your `images/` folder
2. Update the `image_url` column:
```sql
UPDATE vehicles SET image_url = 'images/new-scooter.png' WHERE name = 'TurBoX';
```

### Image Requirements
- Format: PNG, JPG, or JPEG
- Recommended size: 800x600px
- Background: Transparent or white
- Location: `/images/` folder

### Fallback Image
If image_url is missing or broken, it uses: `images/scooter-default.png`

---

## 📝 Using Supabase Dashboard (Easy Way)

### Visual Editing:
1. Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor
2. Click `vehicles` table
3. Click any cell to edit
4. Make changes
5. Press Enter or click ✓
6. Refresh website - see changes instantly!

### Add Row:
1. Click **Insert row** button
2. Fill in all fields
3. Click **Save**

### Delete Row:
1. Click the row number
2. Click **Delete**
3. Confirm

---

## 🎯 Benefits

✅ **Easy Updates** - Change specs/prices without touching code  
✅ **Add New Models** - Launch new scooters instantly  
✅ **No Redeployment** - Changes appear immediately  
✅ **Featured Models** - Highlight premium models  
✅ **Custom Order** - Control display sequence  
✅ **SEO Friendly** - Server-side data loading  

---

## 🧪 Testing Checklist

After running the SQL:

- [ ] Open website and hard refresh (Ctrl+Shift+R)
- [ ] Check console: "Vehicles loaded from Supabase"
- [ ] Verify 3 models appear (TurBoX, P-BMW, Blaze-Fusion)
- [ ] Verify P-BMW shows as featured (premium badge)
- [ ] Verify all specs display correctly
- [ ] Verify images load properly
- [ ] Test: Edit price in Supabase dashboard
- [ ] Test: Refresh website - see updated price
- [ ] Test: Add new vehicle
- [ ] Test: Mark new vehicle as featured

---

## 🔍 Troubleshooting

### "No vehicles found in database"
**Solution:** Run `setup-vehicles-table.sql` to insert data

### Models not appearing
**Solution:** Check RLS policy exists:
```sql
CREATE POLICY "Enable read access for all users" 
ON vehicles FOR SELECT USING (true);
```

### Images not loading
**Solution:** 
1. Verify image exists in `images/` folder
2. Check `image_url` path in database
3. Use forward slashes: `images/scooter.png` not `images\scooter.png`

### Featured badge not showing
**Solution:** Make sure `is_featured = true` in database

---

## 🚀 Advanced Features (Optional)

### 1. Sort by Display Order Instead of Date
Change in `main.js`:
```javascript
.order('display_order', { ascending: true });
```

### 2. Show Only Active Vehicles
Add `is_active` column:
```sql
ALTER TABLE vehicles ADD COLUMN is_active BOOLEAN DEFAULT true;
```

Update query:
```javascript
.select('*')
.eq('is_active', true)
.order('created_at', { ascending: false });
```

### 3. Add Categories
Add category column:
```sql
ALTER TABLE vehicles ADD COLUMN category TEXT DEFAULT 'standard';
```

Filter by category:
```javascript
.select('*')
.eq('category', 'premium')
.order('created_at', { ascending: false });
```

### 4. Add Price as Number (for sorting)
```sql
ALTER TABLE vehicles ADD COLUMN price_numeric INTEGER;
UPDATE vehicles SET price_numeric = 55000 WHERE name = 'TurBoX';
```

Sort by price:
```javascript
.order('price_numeric', { ascending: true });
```

---

## 📖 Quick Reference

**View all vehicles:**
```sql
SELECT id, name, is_featured, price FROM vehicles ORDER BY display_order;
```

**Count vehicles:**
```sql
SELECT COUNT(*) as total FROM vehicles;
```

**Featured vehicles only:**
```sql
SELECT * FROM vehicles WHERE is_featured = true;
```

**Update price for all:**
```sql
UPDATE vehicles SET price = 'Contact for Price';
```

**Bulk update specs:**
```sql
UPDATE vehicles SET motor = '1200W' WHERE motor = '1000W';
```

---

## 🎉 What's Next?

Your models are now fully dynamic! You can:
1. ✅ Add unlimited scooters
2. ✅ Update specs anytime
3. ✅ Change prices instantly
4. ✅ Feature premium models
5. ✅ Reorder display sequence

**No code changes ever needed!** 🚀
