# 📧 Dealer Inquiry Email Template (Without Investment Field)

Since you removed the investment capacity field, use this updated template:

---

## Update Your EmailJS Template

1. Go to: **https://dashboard.emailjs.com/admin/templates**
2. Find your dealer template: `template_zf8ed2k`
3. Click **Edit**
4. Update the template (remove `{{investment}}` references)

---

## Updated Template Configuration

### Subject Line:
```
New Dealer Inquiry: {{from_name}} from {{city}}, {{state}}
```

### Email Content:

**Simple Version:**
```
New Dealer Application!

Contact Information:
Name/Company: {{from_name}}
Email: {{from_email}}
Phone: {{phone}}

Location:
City: {{city}}
State: {{state}}

Business Experience:
{{message}}

Received: {{date}}
```

**Professional HTML Version:**
```html
<div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
  <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0;">
    <h1 style="margin: 0; font-size: 24px;">🤝 New Dealer Application!</h1>
    <p style="margin: 10px 0 0 0;">Pinaka Electric - Dealer Network</p>
  </div>
  
  <div style="background: #f9f9f9; padding: 30px;">
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #667eea;">
      <h2 style="margin-top: 0; color: #667eea; font-size: 18px;">📋 Contact Information</h2>
      <table style="width: 100%; border-collapse: collapse;">
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555; width: 120px;">Name/Company:</td>
          <td style="padding: 8px 0;">{{from_name}}</td>
        </tr>
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">Email:</td>
          <td style="padding: 8px 0;"><a href="mailto:{{from_email}}" style="color: #667eea;">{{from_email}}</a></td>
        </tr>
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">Phone:</td>
          <td style="padding: 8px 0;"><a href="tel:{{phone}}" style="color: #667eea;">{{phone}}</a></td>
        </tr>
      </table>
    </div>
    
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #764ba2;">
      <h2 style="margin-top: 0; color: #764ba2; font-size: 18px;">📍 Location Details</h2>
      <table style="width: 100%; border-collapse: collapse;">
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555; width: 120px;">City:</td>
          <td style="padding: 8px 0;">{{city}}</td>
        </tr>
        <tr>
          <td style="padding: 8px 0; font-weight: bold; color: #555;">State:</td>
          <td style="padding: 8px 0;">{{state}}</td>
        </tr>
      </table>
    </div>
    
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #2196F3;">
      <h2 style="margin-top: 0; color: #2196F3; font-size: 18px;">💼 Business Experience & Interest</h2>
      <p style="white-space: pre-wrap; color: #333; line-height: 1.6;">{{message}}</p>
    </div>
    
    <div style="background: white; padding: 20px; margin: 15px 0; border-radius: 8px; border-left: 4px solid #888;">
      <h2 style="margin-top: 0; color: #666; font-size: 18px;">⏰ Submission Details</h2>
      <p><strong>Received:</strong> {{date}}</p>
      <p><strong>Form Type:</strong> {{form_type}}</p>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
      <a href="tel:{{phone}}" style="display: inline-block; background: #667eea; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; font-weight: bold;">
        Call Applicant
      </a>
      <a href="mailto:{{from_email}}" style="display: inline-block; background: #764ba2; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-left: 10px;">
        Reply via Email
      </a>
    </div>
  </div>
  
  <div style="text-align: center; padding: 20px; color: #777; font-size: 12px;">
    <p>This is an automated notification from Pinaka Electric</p>
    <p>Dealer Application System</p>
  </div>
</div>
```

### Settings:

**To Email**: `{{to_email}}`  
**From Name**: `Pinaka Electric Website`  
**Reply To**: `{{from_email}}`

---

## Template Variables Used (Updated)

The dealer form now sends:

- `{{to_email}}` - Your email (pinakaelectric2908@gmail.com)
- `{{from_name}}` - Applicant name/company
- `{{from_email}}` - Applicant email
- `{{phone}}` - Phone number
- `{{city}}` - City
- `{{state}}` - State
- `{{message}}` - Business experience message
- `{{form_type}}` - "Dealer Inquiry"
- `{{date}}` - Submission timestamp

**Note:** `{{investment}}` variable removed.

---

## 📧 What You'll Receive

**Subject:** New Dealer Inquiry: ABC Motors from Mumbai, Maharashtra

**Body:**
```
New Dealer Application!

Contact Information:
Name/Company: ABC Motors
Email: dealer@abcmotors.com
Phone: +91 9876543210

Location:
City: Mumbai
State: Maharashtra

Business Experience:
We have 10 years of experience in automobile sales...

Received: 26 Feb 2026, 4:30 PM
```

---

## ✅ Update Your EmailJS Template

1. Go to: https://dashboard.emailjs.com/admin/templates
2. Click on template: `template_zf8ed2k`
3. Click **"Edit"**
4. **Remove** any reference to `{{investment}}`
5. Use the template above
6. Click **"Save"**

---

**Your dealer form is now simpler without the investment capacity field!** ✅
