# 📧 Pre-Order Email Template (Without Model Selection)

Since you removed the model selection field, use this updated template:

---

## Create Template in EmailJS

1. Go to: **https://dashboard.emailjs.com/admin/templates**
2. Click **"Create New Template"**
3. **Template Name**: `Pre-Order Notification`

---

## Template Configuration

### Subject Line:
```
New Pre-Order Inquiry: {{from_name}}
```

### Email Content:

**Simple Version:**
```
New Pre-Order Inquiry Received!

Customer Information:
Name: {{from_name}}
Email: {{from_email}}
Phone: {{phone}}

Message:
{{message}}

Received: {{date}}
```

**Professional HTML Version:**
```html
<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
  <div style="background: linear-gradient(135deg, #00d4ff 0%, #4facfe 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
    <h1 style="margin: 0; font-size: 24px;">🛵 New Pre-Order Inquiry!</h1>
    <p style="margin: 10px 0 0 0;">Pinaka Electric</p>
  </div>
  
  <div style="background: #f9f9f9; padding: 30px;">
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #00d4ff;">
      <h2 style="margin-top: 0; color: #00d4ff; font-size: 18px;">📋 Customer Details</h2>
      <table style="width: 100%; border-collapse: collapse;">
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">Name:</td>
          <td style="padding: 8px 0;">{{from_name}}</td>
        </tr>
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">Email:</td>
          <td style="padding: 8px 0;"><a href="mailto:{{from_email}}" style="color: #00d4ff;">{{from_email}}</a></td>
        </tr>
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">Phone:</td>
          <td style="padding: 8px 0;"><a href="tel:{{phone}}" style="color: #00d4ff;">{{phone}}</a></td>
        </tr>
      </table>
    </div>
    
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #4facfe;">
      <h2 style="margin-top: 0; color: #4facfe; font-size: 18px;">💬 Customer Message</h2>
      <p style="white-space: pre-wrap; color: #333;">{{message}}</p>
    </div>
    
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #888;">
      <h2 style="margin-top: 0; color: #666; font-size: 18px;">⏰ Submission Details</h2>
      <p><strong>Received:</strong> {{date}}</p>
      <p><strong>Form Type:</strong> {{form_type}}</p>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
      <a href="tel:{{phone}}" style="display: inline-block; background: #00d4ff; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; font-weight: bold;">
        Call Customer
      </a>
      <a href="mailto:{{from_email}}" style="display: inline-block; background: #4facfe; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-left: 10px;">
        Reply via Email
      </a>
    </div>
  </div>
  
  <div style="text-align: center; padding: 20px; color: #777; font-size: 12px;">
    <p>This is an automated notification from Pinaka Electric</p>
    <p>Pre-Order Inquiry System</p>
  </div>
</div>
```

### Settings:

**To Email**: `{{to_email}}`  
**From Name**: `Pinaka Electric Website`  
**From Email**: `noreply@pinakaelectric.com` (or your domain)  
**Reply To**: `{{from_email}}`

---

## Template Variables Used

The form now sends these variables:

- `{{to_email}}` - Your email (pinakaelectric2908@gmail.com)
- `{{from_name}}` - Customer name
- `{{from_email}}` - Customer email
- `{{phone}}` - Customer phone
- `{{message}}` - Customer message
- `{{form_type}}` - "Pre-Order"
- `{{date}}` - Submission timestamp

**Note:** `{{model}}` variable removed since there's no model selection anymore.

---

## ✅ Save and Copy Template ID

1. Click **"Save"**
2. **Copy the Template ID** (looks like: `template_abc123`)
3. Paste in `main.js` line 13:
   ```javascript
   const EMAILJS_PREORDER_TEMPLATE_ID = 'template_abc123';
   ```

---

## 📧 What You'll Receive

**Subject:** New Pre-Order Inquiry: [Customer Name]

**Body:**
```
New Pre-Order Inquiry Received!

Customer Details:
Name: John Doe
Email: john@example.com
Phone: +91 9876543210

Customer Message:
I'm interested in purchasing your electric scooter...

Received: 26 Feb 2026, 3:45 PM
```

---

**Use this template since you removed the model selection field!** ✅
