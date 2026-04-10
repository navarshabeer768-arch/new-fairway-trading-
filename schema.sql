-- ============================================================
-- NEW FAIR WAY TRADING — Full Supabase Schema
-- Run this in Supabase SQL Editor
-- ============================================================

-- 1. PRODUCTS
CREATE TABLE IF NOT EXISTS products (
  product_id    SERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  category      TEXT DEFAULT '',
  cost_price    NUMERIC(10,2) DEFAULT 0,
  selling_price NUMERIC(10,2) DEFAULT 0,
  stock_quantity INTEGER DEFAULT 0,
  unit          TEXT DEFAULT 'box',
  cases_per_box INTEGER DEFAULT 4,
  low_stock_threshold INTEGER DEFAULT 10,
  icon          TEXT DEFAULT '📦',
  barcode       TEXT,
  photo         TEXT,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. CUSTOMERS
CREATE TABLE IF NOT EXISTS customers (
  customer_id   SERIAL PRIMARY KEY,
  name          TEXT NOT NULL,
  contact_person TEXT DEFAULT '',
  phone         TEXT DEFAULT '',
  address       TEXT DEFAULT '',
  credit_balance NUMERIC(10,2) DEFAULT 0,
  credit_limit  NUMERIC(10,2) DEFAULT 0,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 3. INVOICES
CREATE TABLE IF NOT EXISTS invoices (
  invoice_id    SERIAL PRIMARY KEY,
  customer_id   INTEGER REFERENCES customers(customer_id),
  date          DATE NOT NULL,
  time          TEXT DEFAULT '',
  total_amount  NUMERIC(10,2) DEFAULT 0,
  payment_type  TEXT DEFAULT 'cash',
  cash_paid     NUMERIC(10,2) DEFAULT 0,
  discount      NUMERIC(10,2) DEFAULT 0,
  cheque_number TEXT,
  cheque_date   DATE,
  salesman_name TEXT DEFAULT '',
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 4. INVOICE ITEMS
CREATE TABLE IF NOT EXISTS invoice_items (
  id            SERIAL PRIMARY KEY,
  invoice_id    INTEGER REFERENCES invoices(invoice_id) ON DELETE CASCADE,
  product_id    INTEGER REFERENCES products(product_id),
  name          TEXT NOT NULL,
  quantity      NUMERIC(10,2) DEFAULT 1,
  price         NUMERIC(10,2) DEFAULT 0,
  unit          TEXT DEFAULT 'box',
  total         NUMERIC(10,2) DEFAULT 0
);

-- 5. EXPENSES
CREATE TABLE IF NOT EXISTS expenses (
  id            SERIAL PRIMARY KEY,
  category      TEXT DEFAULT 'General',
  amount        NUMERIC(10,2) DEFAULT 0,
  date          DATE NOT NULL,
  notes         TEXT DEFAULT '',
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 6. INVENTORY (truck stock)
CREATE TABLE IF NOT EXISTS inventory (
  id            SERIAL PRIMARY KEY,
  product_id    INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
  quantity      NUMERIC(10,2) DEFAULT 0,
  last_updated  TIMESTAMPTZ DEFAULT NOW()
);

-- 7. WAREHOUSE STOCK
CREATE TABLE IF NOT EXISTS warehouse_stock (
  id            SERIAL PRIMARY KEY,
  product_id    INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
  quantity      NUMERIC(10,2) DEFAULT 0,
  last_updated  TIMESTAMPTZ DEFAULT NOW()
);

-- 8. ADVANCE ORDERS
CREATE TABLE IF NOT EXISTS advance_orders (
  order_id      SERIAL PRIMARY KEY,
  customer_id   INTEGER REFERENCES customers(customer_id),
  delivery_date DATE,
  items         JSONB DEFAULT '[]',
  notes         TEXT DEFAULT '',
  priority      TEXT DEFAULT 'normal',
  status        TEXT DEFAULT 'pending',
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 9. CREDIT PAYMENTS
CREATE TABLE IF NOT EXISTS credit_payments (
  id            SERIAL PRIMARY KEY,
  customer_id   INTEGER REFERENCES customers(customer_id),
  amount        NUMERIC(10,2) DEFAULT 0,
  payment_type  TEXT DEFAULT 'cash',
  cheque_number TEXT,
  cheque_date   DATE,
  date          DATE NOT NULL,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 10. SETTINGS (key-value store)
CREATE TABLE IF NOT EXISTS settings (
  key           TEXT PRIMARY KEY,
  value         TEXT
);

-- Default PIN
INSERT INTO settings (key, value) VALUES ('app_pin', '1234') ON CONFLICT (key) DO NOTHING;

-- ============================================================
-- ENABLE ROW LEVEL SECURITY (open access for anon — adjust later)
-- ============================================================
ALTER TABLE products        ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers       ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices        ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_items   ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses        ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory       ENABLE ROW LEVEL SECURITY;
ALTER TABLE warehouse_stock ENABLE ROW LEVEL SECURITY;
ALTER TABLE advance_orders  ENABLE ROW LEVEL SECURITY;
ALTER TABLE credit_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings        ENABLE ROW LEVEL SECURITY;

-- Allow full access to anon key (POS app uses anon key)
CREATE POLICY "anon_all" ON products        FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON customers       FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON invoices        FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON invoice_items   FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON expenses        FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON inventory       FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON warehouse_stock FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON advance_orders  FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON credit_payments FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "anon_all" ON settings        FOR ALL TO anon USING (true) WITH CHECK (true);
