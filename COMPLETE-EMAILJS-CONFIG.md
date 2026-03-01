# ✅ Complete EmailJS Setup - With Your Service ID

## 🎯 Your Service ID: `service_d6cdezm`

Your service ID is already configured! Now you just need 3 more things:

---

## 📋 What You Need (5 Minutes)

### 1️⃣ Get Your Public Key (1 min)

1. Go to: **https://dashboard.emailjs.com/admin/account**
2. Look for **"API Keys"** section
3. **Copy your Public Key** (13-15 characters)
4. Example: `a1b2c3d4e5f6g`

### 2️⃣ Create Pre-Order Template (2 min)

1. Go to: **https://dashboard.emailjs.com/admin/templates**
2. Click **"Create New Template"**
3. **Template Name**: `Pre-Order Notification`

**Subject Line:**
```
New Pre-Order: {{from_name}} - {{model}}
```

**Email Content (paste this):**
```html
<h2>🛵 New Pre-Order Received!</h2>

<h3>Customer Information</h3>
<p><strong>Name:</strong> {{from_name}}</p>
<p><strong>Email:</strong> {{from_email}}</p>
<p><strong>Phone:</strong> {{phone}}</p>

<h3>Order Details</h3>
<p><strong>Model:</strong> {{model}}</p>
<p><strong>Message:</strong> {{message}}</p>

<h3>Received</h3>
<p>{{date}}</p>

<p>Form Type: {{form_type}}</p>
```

**Settings:**
- **To Email**: `{{to_email}}`
- **From Name**: `Pinaka Electric Website`
- **Reply To**: `{{from_email}}`

4. Click **Save**
5. **Copy the Template ID** (like: `template_abc123`)

### 3️⃣ Create Dealer Inquiry Template (2 min)

1. Click **"Create New Template"** again
2. **Template Name**: `Dealer Inquiry Notification`

**Subject Line:**
```
New Dealer Inquiry: {{from_name}} from {{city}}, {{state}}
```

**Email Content:**
```html
<h2>🤝 New Dealer Application!</h2>

<h3>Contact Information</h3>
<p><strong>Name/Company:</strong> {{from_name}}</p>
<p><strong>Email:</strong> {{from_email}}</p>
<p><strong>Phone:</strong> {{phone}}</p>

<h3>Location</h3>
<p><strong>City:</strong> {{city}}</p>
<p><strong>State:</strong> {{state}}</p>

<h3>Investment Capacity</h3>
<p><strong>{{investment}}</strong></p>

<h3>Business Experience</h3>
<p>{{message}}</p>

<h3>Received</h3>
<p>{{date}}</p>

<p>Form Type: {{form_type}}</p>
```

**Settings:**
- **To Email**: `{{to_email}}`
- **From Name**: `Pinaka Electric Website`
- **Reply To**: `{{from_email}}`

3. Click **Save**
4. **Copy the Template ID** (like: `template_xyz789`)

---

## 4️⃣ Update Your main.js File (1 min)

Open `main.js` and find lines 11-14:

**Replace these:**
```javascript
const EMAILJS_PUBLIC_KEY = 'YOUR_PUBLIC_KEY_HERE';
const EMAILJS_SERVICE_ID = 'service_d6cdezm';
const EMAILJS_PREORDER_TEMPLATE_ID = 'YOUR_PREORDER_TEMPLATE_ID';
const EMAILJS_DEALER_TEMPLATE_ID = 'YOUR_DEALER_TEMPLATE_ID';
```

**With your actual values:**
```javascript
const EMAILJS_PUBLIC_KEY = 'paste_your_public_key';
const EMAILJS_SERVICE_ID = 'service_d6cdezm';  // ✅ Already set!
const EMAILJS_PREORDER_TEMPLATE_ID = 'template_abc123';  // From step 2
const EMAILJS_DEALER_TEMPLATE_ID = 'template_xyz789';  // From step 3
```

---

## ✅ Test It!

1. Save `main.js`
2. Refresh website (`Ctrl + Shift + R`)
3. Open console (`F12`)
4. Should see: `✅ EmailJS initialized with service: service_d6cdezm`

### Test Pre-Order Form:
1. Scroll to "Ready to Ride?" section
2. Fill out form
3. Click "Pre-Order Now"
4. Console should show: `✅ Pre-order email sent successfully! 200`
5. **Check your email:** pinakaelectric2908@gmail.com

### Test Dealer Form:
1. Click "Become a Dealer" button
2. Fill out form
3. Click "Submit Application"
4. Console should show: `✅ Dealer inquiry email sent successfully! 200`
5. **Check your email**

---

## 📧 What You'll Receive

### Pre-Order Email:
```
Subject: New Pre-Order: [Customer Name] - [Model]

Body:
🛵 New Pre-Order Received!

Customer: John Doe
Email: john@example.com
Phone: +91 9876543210
Model: TurBoX
Message: Want to buy immediately
```

### Dealer Inquiry Email:
```
Subject: New Dealer Inquiry: [Name] from [City], [State]

Body:
🤝 New Dealer Application!

Name: ABC Motors
Email: abc@motors.com
Phone: +91 9876543210
City: Mumbai
State: Maharashtra
Investment: ₹10-25 Lakhs
Message: We have 10 years experience...
```

---

## 🔗 Quick Links

**Get Public Key**: https://dashboard.emailjs.com/admin/account  
**Create Templates**: https://dashboard.emailjs.com/admin/templates  
**View Services**: https://dashboard.emailjs.com/admin  

---

## 📊 EmailJS Variables Used

Both templates use these variables (sent from your forms):

**Common:**
- `{{to_email}}` - Your email (pinakaelectric2908@gmail.com)
- `{{from_name}}` - Customer/Dealer name
- `{{from_email}}` - Customer/Dealer email
- `{{phone}}` - Phone number
- `{{message}}` - Their message
- `{{date}}` - Submission date/time
- `{{form_type}}` - "Pre-Order" or "Dealer Inquiry"

**Pre-Order Specific:**
- `{{model}}` - Selected scooter model

**Dealer Specific:**
- `{{city}}` - City
- `{{state}}` - State
- `{{investment}}` - Investment capacity

---

## 🐛 Troubleshooting

### Console Error: "EmailJS is not defined"
**Fix:** Check if CDN is loaded in HTML:
```html
<script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>
```

### Console Error: "User ID is invalid"
**Fix:** Public Key is wrong. Check: https://dashboard.emailjs.com/admin/account

### Console Error: "Template ID is invalid"
**Fix:** Template ID is wrong. Check: https://dashboard.emailjs.com/admin/templates

### Console Error: "Service ID is invalid"
**Fix:** Service ID should be `service_d6cdezm` (already correct in your case)

### No email received but no errors
**Fix:**
1. Check spam folder
2. Verify Gmail is connected in EmailJS dashboard
3. Check EmailJS dashboard → Stats for failed emails
4. Try disconnecting and reconnecting Gmail service

### Form submits but shows error
**Fix:** One of your IDs is wrong. Double-check all 3 IDs in main.js

---

## 📱 Test from EmailJS Dashboard

Before testing on website:

1. Go to: https://dashboard.emailjs.com/admin/templates
2. Click on your template
3. Click **"Test It"** button
4. Fill in test values
5. Click **"Send Test Email"**
6. Check your inbox

This confirms the template works!

---

## ✅ Quick Checklist

- [ ] Opened EmailJS dashboard
- [ ] Copied Public Key
- [ ] Created Pre-Order template
- [ ] Copied Pre-Order Template ID
- [ ] Created Dealer template
- [ ] Copied Dealer Template ID
- [ ] Updated main.js lines 11-14
- [ ] Saved main.js
- [ ] Hard refreshed website (Ctrl+Shift+R)
- [ ] Console shows "EmailJS initialized"
- [ ] Tested pre-order form
- [ ] Received pre-order email
- [ ] Tested dealer form
- [ ] Received dealer email

---

## 🎉 You're Almost Done!

**Current Status:**
- ✅ Service ID configured: `service_d6cdezm`
- ⏳ Need: Public Key
- ⏳ Need: Pre-Order Template ID
- ⏳ Need: Dealer Template ID

**Just 3 more values and you're done!** 🚀

Copy them from EmailJS dashboard and paste into `main.js`.
