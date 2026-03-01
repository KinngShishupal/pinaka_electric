# 📊 Dynamic Hero Stats Setup

## ✅ What Was Done

The hero stats section (Range, Speed, Charge Time) now loads dynamically from Supabase!

---

## 🚀 Setup Instructions (2 Minutes)

### Step 1: Create Database Table (1 minute)

1. Go to: **https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new**
2. Open **`setup-specs-table.sql`**
3. Copy ALL the SQL
4. Paste and click **RUN**

This creates the `specs` table with your current values:
- Range: 75 km
- Speed: 45 km/h
- Charge Time: 3 hours

### Step 2: Test It (1 minute)

1. Refresh your website (`Ctrl + Shift + R`)
2. Open console (`F12`)
3. Should see: `Hero stats loaded from Supabase: [...]`
4. Watch the numbers count up on the hero section! 🎬

---

## 📊 Database Structure

```sql
specs table:
├── id (primary key)
├── range (integer) - Range in kilometers
├── speed (integer) - Speed in km/h
├── charge_time (integer or decimal) - Hours to charge
└── updated_at (timestamp)
```

---

## 🎨 How It Works

1. Page loads
2. JavaScript fetches from `specs` table
3. Updates the `data-target` attributes
4. Numbers animate from 0 to target value (counting effect)
5. Looks professional! ✨

---

## 🔧 How to Update Stats

### Using Supabase Dashboard (Easiest):

1. Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor
2. Click `specs` table
3. Click on any number to edit
4. Change the value
5. Press Enter
6. Refresh your website - see new numbers!

### Using SQL:

```sql
UPDATE specs 
SET 
  range = 80,
  speed = 50,
  charge_time = 2.5,
  updated_at = NOW()
WHERE id = 1;
```

---

## 📈 Example Updates

### Increase Range to 100km:
```sql
UPDATE specs SET range = 100 WHERE id = 1;
```

### Update Speed to 60 km/h:
```sql
UPDATE specs SET speed = 60 WHERE id = 1;
```

### Faster Charging (2 hours):
```sql
UPDATE specs SET charge_time = 2 WHERE id = 1;
```

### Update All at Once:
```sql
UPDATE specs 
SET range = 100, speed = 55, charge_time = 2.5 
WHERE id = 1;
```

---

## ✅ Benefits

✅ **Easy Updates** - Change specs without touching code  
✅ **Instant Updates** - Refresh website to see changes  
✅ **No Deployment** - Update anytime from Supabase  
✅ **Professional Animation** - Numbers count up smoothly  
✅ **Multiple Models** - Can show different specs for each model  

---

## 🎯 What Data is Shown

### Hero Section Stats:
- **Range**: How far the scooter can go (km)
- **Speed**: Maximum speed (km/h)
- **Charge Time**: How long to fully charge (hours)

These are pulled from the first row of the `specs` table.

---

## 🔍 Advanced: Multiple Spec Sets

If you want different specs for different models, you can:

1. Add a `model_name` column:
```sql
ALTER TABLE specs ADD COLUMN model_name TEXT;
```

2. Insert specs for each model:
```sql
INSERT INTO specs (model_name, range, speed, charge_time) VALUES
('TurBoX', 75, 45, 3),
('P-BMW', 80, 50, 2.5),
('Blaze-Fusion', 85, 55, 2);
```

3. Update JavaScript to fetch specific model or average:
```javascript
// Get average of all models
const { data, error } = await supabaseClient
    .from('specs')
    .select('range, speed, charge_time');

const avgRange = Math.round(data.reduce((sum, s) => sum + s.range, 0) / data.length);
const avgSpeed = Math.round(data.reduce((sum, s) => sum + s.speed, 0) / data.length);
const avgCharge = Math.round(data.reduce((sum, s) => sum + s.charge_time, 0) / data.length);
```

---

## 🧪 Testing

### Check if it's working:

1. Open console (F12)
2. Refresh page
3. Look for: `Hero stats loaded from Supabase:`
4. Look for: `✅ Hero stats updated successfully`

### Manual test in console:
```javascript
// Check if elements exist
console.log({
    range: document.getElementById('statRange'),
    speed: document.getElementById('statSpeed'),
    charge: document.getElementById('statCharge')
});
```

### Update test:
```sql
-- Change range to 100
UPDATE specs SET range = 100 WHERE id = 1;
```
Then refresh website - should show 100 km range!

---

## 🐛 Troubleshooting

### Stats show 0 and don't animate
**Issue**: Table is empty or RLS blocking  
**Fix**: Run `setup-specs-table.sql` to add data and policy

### Console error: "specs table doesn't exist"
**Issue**: Table not created  
**Fix**: Run the SQL file

### Stats don't update after changing in Supabase
**Issue**: Browser cache  
**Fix**: Hard refresh (`Ctrl + Shift + R`)

---

## 📝 Current Values

Default values set in database:
- **Range**: 75 km
- **Speed**: 45 km/h
- **Charge Time**: 3 hours

Change these anytime in Supabase dashboard!

---

**Your hero stats are now fully dynamic!** 🎉

Update them anytime from Supabase without touching code! 🚀
