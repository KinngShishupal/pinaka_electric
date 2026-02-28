# 🤝 Become a Dealer Feature - Complete Setup Guide

## ✅ What Was Added

### 1. **"Become a Dealer" Button in Header**
Added next to "Pre-Order Now" button with purple gradient styling

### 2. **Dealer Inquiry Form Section**
Complete form with:
- Name/Company Name
- Email
- Phone
- City & State
- Investment Capacity
- Business Experience Message

### 3. **Database Integration**
Stores all dealer inquiries in Supabase

### 4. **Email Notifications**
Can be set up with Zapier (same as pre-orders)

---

## 🚀 Setup Instructions (3 Steps)

### Step 1: Create Database Table (2 minutes)

1. Go to: **https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/sql/new**
2. Open **`setup-dealer-inquiries.sql`**
3. Copy ALL the SQL
4. Paste and click **RUN**

This creates the `dealer_inquiries` table with all fields.

### Step 2: Test the Feature (1 minute)

1. Open your website
2. Hard refresh: `Ctrl + Shift + R`
3. Click **"Become a Dealer"** button in header
4. Should scroll to dealer form
5. Fill out the form and submit
6. Check Supabase → `dealer_inquiries` table

### Step 3: Setup Email Notifications (5 minutes)

Same process as pre-orders, but for dealer inquiries.

#### Using Zapier:

1. Go to: **https://zapier.com**
2. Create new Zap
3. **Trigger**: Supabase → New Row → `dealer_inquiries` table
4. **Action**: Email by Zapier → Send Email
5. **To**: Your email
6. **Subject**: `New Dealer Inquiry: {{name}} - {{city}}, {{state}}`
7. **Body**:
   ```
   New Dealer Application!
   
   Name: {{name}}
   Email: {{email}}
   Phone: {{phone}}
   City: {{city}}
   State: {{state}}
   Investment: {{investment_capacity}}
   
   Message:
   {{message}}
   
   Received: {{created_at}}
   
   View in Supabase: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor
   ```
8. Test and turn ON

---

## 📊 Database Structure

```sql
dealer_inquiries table:
├── id (primary key)
├── name (text) - Name or Company Name
├── email (text) - Email address
├── phone (text) - Phone number
├── city (text) - City
├── state (text) - State
├── investment_capacity (text) - Investment range
├── message (text) - Business experience
├── status (text) - pending/contacted/approved/rejected
├── created_at (timestamp) - Submission time
├── contacted_at (timestamp) - When contacted
└── notes (text) - Admin notes
```

---

## 🎨 Features

### Header Buttons
- **"Become a Dealer"** - Purple gradient (left)
- **"Pre-Order Now"** - Blue gradient (right)
- Both scroll to their respective sections
- Responsive (hidden on mobile, shown in hamburger menu)

### Dealer Form
- All fields required (except message is required but can be long)
- Investment capacity dropdown
- Clean, professional design
- Success/error messages
- Form resets after submission
- Same styling as pre-order form

### Investment Options
- Under ₹5 Lakhs
- ₹5-10 Lakhs
- ₹10-25 Lakhs
- Above ₹25 Lakhs

---

## 📋 Managing Dealer Inquiries

### View All Inquiries

Go to: https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor

Click `dealer_inquiries` table

### Filter by Status

```sql
-- Pending inquiries
SELECT * FROM dealer_inquiries WHERE status = 'pending' ORDER BY created_at DESC;

-- Contacted inquiries
SELECT * FROM dealer_inquiries WHERE status = 'contacted' ORDER BY created_at DESC;
```

### Update Status

```sql
-- Mark as contacted
UPDATE dealer_inquiries SET status = 'contacted', contacted_at = NOW() WHERE id = 1;

-- Mark as approved
UPDATE dealer_inquiries SET status = 'approved' WHERE id = 1;

-- Mark as rejected
UPDATE dealer_inquiries SET status = 'rejected' WHERE id = 1;
```

### Add Notes

```sql
UPDATE dealer_inquiries 
SET notes = 'Good candidate, has auto sales experience' 
WHERE id = 1;
```

### Export to Excel

1. Go to Table Editor
2. Click `dealer_inquiries` table
3. Click **Export** button
4. Choose **CSV**
5. Open in Excel/Google Sheets

---

## 📊 Analytics Queries

### Count by State
```sql
SELECT state, COUNT(*) as total 
FROM dealer_inquiries 
GROUP BY state 
ORDER BY total DESC;
```

### Count by Investment Capacity
```sql
SELECT investment_capacity, COUNT(*) as total 
FROM dealer_inquiries 
GROUP BY investment_capacity 
ORDER BY total DESC;
```

### High-Value Leads (Above ₹25 Lakhs)
```sql
SELECT name, email, phone, city, state 
FROM dealer_inquiries 
WHERE investment_capacity = 'above-25-lakh' 
ORDER BY created_at DESC;
```

### This Month's Inquiries
```sql
SELECT COUNT(*) 
FROM dealer_inquiries 
WHERE created_at >= DATE_TRUNC('month', CURRENT_DATE);
```

### State-wise Report
```sql
SELECT 
  state,
  COUNT(*) as total,
  COUNT(CASE WHEN status = 'approved' THEN 1 END) as approved,
  COUNT(CASE WHEN status = 'pending' THEN 1 END) as pending
FROM dealer_inquiries 
GROUP BY state 
ORDER BY total DESC;
```

---

## 🎯 Benefits Listed on Form

1. ✓ Exclusive Territory Rights
2. ✓ Marketing Support
3. ✓ Training Programs
4. ✓ Attractive Margins

(You can customize these in `index.html`)

---

## 🔧 Customization

### Change Button Text

In `index.html` line ~37:
```html
<a href="#dealer" class="cta-button dealer-btn">Become a Partner</a>
```

### Change Button Colors

In `styles.css`:
```css
.dealer-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

### Add More Form Fields

1. Add field in HTML
2. Update JavaScript `formData` object
3. Add column to database (ALTER TABLE)

### Change Investment Options

In `index.html`, update the dropdown options:
```html
<option value="custom-range">Your Custom Range</option>
```

---

## 📱 Mobile Responsiveness

- Buttons hidden in header on mobile
- Can be added to hamburger menu
- Form is fully responsive
- All fields stack vertically on mobile

---

## 🔍 Troubleshooting

### Form doesn't submit
- Check browser console for errors
- Verify Supabase client is initialized
- Check RLS policy allows INSERT

### Button doesn't scroll
- Hard refresh browser (Ctrl + Shift + R)
- Check console for smooth scroll messages
- Verify `#dealer` section exists

### No email received
- Check spam folder
- Verify Zapier is turned ON
- Test Zap manually
- Check webhook connection

---

## 📧 Email Template (HTML Version)

For Zapier/Make, use this HTML template:

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    body { font-family: Arial, sans-serif; }
    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; }
    .content { padding: 20px; }
    .info { background: #f5f5f5; padding: 15px; margin: 10px 0; border-radius: 5px; }
    .label { font-weight: bold; color: #667eea; }
    .highlight { background: #fff3cd; padding: 10px; border-left: 4px solid #ffc107; margin: 10px 0; }
  </style>
</head>
<body>
  <div class="header">
    <h1>🤝 New Dealer Application</h1>
  </div>
  <div class="content">
    <div class="info">
      <p><span class="label">Name/Company:</span> {{name}}</p>
      <p><span class="label">Email:</span> {{email}}</p>
      <p><span class="label">Phone:</span> {{phone}}</p>
      <p><span class="label">Location:</span> {{city}}, {{state}}</p>
    </div>
    
    <div class="highlight">
      <p><span class="label">Investment Capacity:</span> {{investment_capacity}}</p>
    </div>
    
    <div class="info">
      <p><span class="label">Business Experience:</span></p>
      <p>{{message}}</p>
    </div>
    
    <p><strong>Received:</strong> {{created_at}}</p>
    <p><a href="https://supabase.com/dashboard/project/zqjeoqvstvbzvikwsftv/editor" style="background: #667eea; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">View in Dashboard</a></p>
  </div>
</body>
</html>
```

---

## ✅ Testing Checklist

After setup:

- [ ] Created `dealer_inquiries` table in Supabase
- [ ] Set up RLS policies
- [ ] "Become a Dealer" button visible in header
- [ ] Button scrolls to dealer form
- [ ] Form accepts all required fields
- [ ] Form validates before submission
- [ ] Test submission (data appears in Supabase)
- [ ] Success message shown after submission
- [ ] Form resets after submission
- [ ] Set up email notifications (Zapier/Make)
- [ ] Test email notification (received?)
- [ ] Tested on mobile (responsive?)
- [ ] Tested button hover effects
- [ ] Verified console shows no errors

---

## 🎉 Summary

You now have:
- ✅ Dealer inquiry button in header
- ✅ Professional dealer application form
- ✅ Database storage for all inquiries
- ✅ Status tracking (pending/contacted/approved/rejected)
- ✅ Email notifications (when set up)
- ✅ Analytics and reporting queries
- ✅ Export to Excel capability
- ✅ Fully responsive design

---

## 📞 Next Steps

1. **Run** `setup-dealer-inquiries.sql` in Supabase
2. **Test** the form by submitting a test inquiry
3. **Setup** email notifications with Zapier
4. **Customize** the form fields if needed
5. **Monitor** inquiries in Supabase dashboard

**Your dealer recruitment system is ready!** 🚀
