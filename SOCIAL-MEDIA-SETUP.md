# 🌐 Dynamic Social Media Links Setup

## ✅ What Was Done

1. ✅ Added proper social media icons (SVG) for all 5 platforms
2. ✅ Added IDs to each social link for dynamic updates
3. ✅ JavaScript function to load links from Supabase
4. ✅ Auto-hide links if not provided (NULL in database)

---

## 🎨 Social Media Platforms Added

1. 📘 **Facebook**
2. 💼 **LinkedIn**
3. 🐦 **Twitter**
4. 📸 **Instagram**
5. 🎥 **YouTube**

All with professional SVG icons!

---

## 🚀 Setup Instructions (2 Minutes)

### Step 1: Create Database Table (1 minute)

1. Go to: **https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new**
2. Open **`setup-socialmedia-table.sql`**
3. Copy ALL the SQL
4. Paste and click **RUN**

This creates the `socialMedia` table with placeholder links.

### Step 2: Update With Your Real Links (1 minute)

In Supabase SQL Editor, run:

```sql
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/yourpage',
  linkedin = 'https://www.linkedin.com/company/yourcompany',
  twitter = 'https://twitter.com/yourhandle',
  instagram = 'https://www.instagram.com/yourhandle',
  youtube = 'https://www.youtube.com/@yourchannel'
WHERE id = 1;
```

**Replace with your actual social media URLs!**

### Step 3: Test It (30 seconds)

1. Refresh your website (`Ctrl + Shift + R`)
2. Open console (`F12`)
3. Should see: `Social media links loaded from Supabase:`
4. Scroll to footer
5. Click on each icon - should open your social media pages!

---

## 📊 Database Structure

```sql
socialMedia table:
├── id (primary key)
├── facebook (text, nullable) - Facebook page URL
├── linkedin (text, nullable) - LinkedIn company URL
├── twitter (text, nullable) - Twitter profile URL
├── instagram (text, nullable) - Instagram profile URL
├── youtube (text, nullable) - YouTube channel URL
└── updated_at (timestamp)
```

---

## 🎯 How It Works

1. Page loads
2. JavaScript fetches from `socialMedia` table
3. Updates each link's `href` with database URL
4. If URL is `NULL` or empty → Icon is hidden
5. All links open in new tab (`target="_blank"`)

---

## 🔧 Managing Social Media Links

### Using Supabase Dashboard (Easiest):

1. Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor
2. Click `socialMedia` table
3. Click on any URL to edit
4. Paste your social media URL
5. Press Enter
6. Refresh website - link updated!

### Hide a Platform:

Set the URL to `NULL` to hide that icon:

```sql
-- Hide Twitter icon
UPDATE "socialMedia" SET twitter = NULL WHERE id = 1;
```

### Show All Platforms:

```sql
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/pinakaelectric',
  linkedin = 'https://www.linkedin.com/company/pinakaelectric',
  twitter = 'https://twitter.com/pinakaelectric',
  instagram = 'https://www.instagram.com/pinakaelectric',
  youtube = 'https://www.youtube.com/@pinakaelectric'
WHERE id = 1;
```

---

## 📱 Social Media URL Formats

### Facebook:
- Page: `https://www.facebook.com/yourpage`
- Profile: `https://www.facebook.com/profile.php?id=123456789`

### LinkedIn:
- Company: `https://www.linkedin.com/company/yourcompany`
- Profile: `https://www.linkedin.com/in/yourname`

### Twitter (X):
- Profile: `https://twitter.com/yourhandle`
- New X: `https://x.com/yourhandle`

### Instagram:
- Profile: `https://www.instagram.com/yourhandle/`

### YouTube:
- Channel: `https://www.youtube.com/@yourchannel`
- Channel ID: `https://www.youtube.com/channel/UCxxxxxxxxx`

---

## 🎨 Icon Styling

The icons are:
- ✅ Proper SVG icons (scalable, crisp)
- ✅ White color by default
- ✅ Hover effects (from CSS)
- ✅ 20x20px size
- ✅ Accessible with tooltips

---

## 🔍 Features

### Auto-Hide Empty Links
If a social media URL is not provided (NULL), that icon won't show:

```sql
-- Only show Facebook and Instagram
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/pinakaelectric',
  linkedin = NULL,
  twitter = NULL,
  instagram = 'https://www.instagram.com/pinakaelectric',
  youtube = NULL
WHERE id = 1;
```

Result: Only Facebook and Instagram icons visible.

### Security
- All links open in new tab (`target="_blank"`)
- `rel="noopener noreferrer"` for security
- Prevents tab-napping attacks

### Tooltips
Hover over icons to see platform name (Facebook, LinkedIn, etc.)

---

## 📊 Quick Update Commands

### Update Single Platform:
```sql
UPDATE "socialMedia" SET facebook = 'https://www.facebook.com/newpage' WHERE id = 1;
UPDATE "socialMedia" SET instagram = 'https://www.instagram.com/newhandle' WHERE id = 1;
```

### Update Multiple:
```sql
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/page',
  instagram = 'https://www.instagram.com/handle'
WHERE id = 1;
```

### View Current Links:
```sql
SELECT * FROM "socialMedia";
```

---

## 🧪 Testing Checklist

- [ ] Created `socialMedia` table in Supabase
- [ ] Set up RLS policy (public read)
- [ ] Added your real social media URLs
- [ ] Refreshed website (Ctrl+Shift+R)
- [ ] Console shows: "Social media links loaded"
- [ ] All 5 icons visible in footer
- [ ] Clicked Facebook - opens your page
- [ ] Clicked LinkedIn - opens your page
- [ ] Clicked Twitter - opens your page
- [ ] Clicked Instagram - opens your page
- [ ] Clicked YouTube - opens your channel
- [ ] Icons have hover effects
- [ ] All links open in new tab

---

## 🐛 Troubleshooting

### Icons don't show
**Fix:** Check if `socialLinks` div exists in footer

### Links don't update
**Fix:** 
1. Hard refresh (`Ctrl + Shift + R`)
2. Check console for errors
3. Verify RLS policy exists

### Icon goes to wrong page
**Fix:** Check URL in Supabase, make sure it's correct format

### Icon missing
**Fix:** Check if that platform's URL is set (not NULL)

---

## 🎨 Customize Icon Appearance

Icons are styled in `styles.css`. To change:

### Icon Size:
```css
.social-link svg {
    width: 24px;
    height: 24px;
}
```

### Icon Color:
```css
.social-link {
    color: #00d4ff; /* Change to your brand color */
}
```

### Hover Effect:
```css
.social-link:hover {
    color: #ffffff;
    transform: translateY(-3px);
}
```

---

## 📈 Benefits

✅ **Easy Updates** - Change links without touching code  
✅ **Add/Remove Platforms** - Just update database  
✅ **Professional Icons** - SVG icons (scalable, crisp)  
✅ **Auto-Hide** - Empty links don't show  
✅ **Secure** - Opens in new tab safely  
✅ **Mobile Friendly** - Works on all devices  

---

## 🎯 Example: Your Social Media

Update with your actual pages:

```sql
UPDATE "socialMedia" 
SET 
  facebook = 'https://www.facebook.com/pinakaelectric',
  linkedin = 'https://www.linkedin.com/company/pinaka-electric-pvt-ltd',
  twitter = 'https://twitter.com/pinaka_electric',
  instagram = 'https://www.instagram.com/pinakaelectric.official/',
  youtube = 'https://www.youtube.com/@pinakaelectricofficial'
WHERE id = 1;
```

---

## 🚀 Advanced: Add More Platforms

Want to add WhatsApp, Telegram, etc.?

1. Add column to table:
```sql
ALTER TABLE "socialMedia" ADD COLUMN whatsapp TEXT;
```

2. Update the link:
```sql
UPDATE "socialMedia" SET whatsapp = 'https://wa.me/917042182908' WHERE id = 1;
```

3. Add HTML icon (copy pattern from existing icons)

4. Add JavaScript (copy pattern from existing code)

---

**Your social media links are now fully dynamic!** 🌐

Update them anytime from Supabase dashboard! 🚀
