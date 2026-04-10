# 🏪 New Fair Way Trading — POS System

**نيو فيرفي تريدينغ — Doha, Qatar**

A complete mobile-first Point of Sale and Finance management system for New Fair Way Trading.

---

## 📱 Files

| File | Description |
|------|-------------|
| `index.html` | Main POS App — Sales, Inventory, Customers, Truck Load, Reports |
| `finance.html` | Finance Dashboard — P&L, Balance Sheet, Assets, Payables, Ledger |

---

## 🚀 Live App (GitHub Pages)

After enabling GitHub Pages, your app will be live at:

```
https://<your-username>.github.io/<repo-name>/
https://<your-username>.github.io/<repo-name>/finance.html
```

---

## 🗄️ Supabase Setup

### 1. Run the Schema
Go to your Supabase project → **SQL Editor** → paste and run `schema.sql`

### 2. Tables Created
- `products` — Product catalog with pricing and stock
- `customers` — Customer list with credit balances
- `invoices` — All sales invoices
- `invoice_items` — Line items for each invoice
- `expenses` — Business expenses
- `inventory` — Truck stock levels
- `warehouse_stock` — Warehouse stock levels
- `advance_orders` — Pre-orders from shops
- `credit_payments` — Customer credit collections
- `settings` — App configuration (PIN, company info, etc.)

---

## 🔐 Default PIN

```
1234
```

Change it in **Settings → Security** after first login.

---

## ✨ Features

### POS App (`index.html`)
- 🛒 Point of Sale with product grid
- 📦 Inventory management (truck + warehouse)
- 👥 Customer management with credit tracking
- 🧾 Invoice generation with PDF export
- 🚛 Truck load management
- 📋 Advance orders
- 💰 Daily collection & settlement
- 💵 Cash handover system
- 🎯 Sales targets
- 📊 Reports & P&L
- 🔍 Audit log
- ✅ Load approval system
- 👤 Employee PIN login

### Finance App (`finance.html`)
- 📈 Profit & Loss statements
- ⚖️ Balance Sheet
- 📒 Customer ledger
- 🏭 Purchase management
- 📦 Inventory valuation (COGS)
- 🏢 Asset register with depreciation
- 💳 Liabilities & payables
- 📉 Financial charts

---

## 🌐 Hosting on GitHub Pages

1. Go to your repo → **Settings** → **Pages**
2. Source: **Deploy from a branch**
3. Branch: **main** → **/ (root)**
4. Click **Save**
5. Wait ~1 minute, then visit your Pages URL

---

## 🛠️ Tech Stack

- **Frontend:** Vanilla HTML/CSS/JS (no framework, works offline)
- **Database:** Supabase (PostgreSQL)
- **Local Cache:** IndexedDB (offline support)
- **PDF:** jsPDF + html2pdf.js
- **Charts:** Chart.js
- **Fonts:** Google Fonts (Cairo + Barlow Condensed)

---

*Built for New Fair Way Trading — Doha, Qatar* 🇶🇦
