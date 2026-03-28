-- USERS (Domain)
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_name VARCHAR(100),
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ACCOUNT
CREATE TABLE accounts (
    account_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id),
    account_name VARCHAR(100),
    type VARCHAR(50),
    balance DECIMAL(15,2),
    currency VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CATEGORY
-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE icons (
  icon_id uuid NOT NULL DEFAULT gen_random_uuid(),
  name character varying NOT NULL,
  icon_code character varying NOT NULL,
  category character varying,
  tags ARRAY,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT icons_pkey PRIMARY KEY (icon_id)
);

CREATE TABLE categories (
  category_id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  category_name character varying NOT NULL,
  type character varying,
  icon_id uuid,
  color character varying,
  is_system boolean NOT NULL DEFAULT false,
  created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT categories_pkey PRIMARY KEY (category_id),
  CONSTRAINT categories_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES category_service.icons(icon_id)
);



-- TRANSACTION
CREATE TABLE transactions (
    trans_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES accounts(account_id),
    category_id UUID REFERENCES categories(category_id),
    amount DECIMAL(15,2),
    transaction_type VARCHAR(50),
    description VARCHAR(255),
    date DATE,
    note VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (user_id, user_name, email)
VALUES
('5324c950-d209-44b7-9e1b-2c3d859a17af', 'Bảo', 'bao0704@gmail.com'),
('e67f2863-5f03-4dff-b247-478b140ab6c4', 'Tâm', 'tamthan@gmail.com'),
('cd83a6d0-8422-417d-845f-f9633cd6099e', 'Phúc', 'phuc0312@gmail.com'),
('901ce87f-db7d-4ab2-a644-5b529b8a790b', 'Đạt', 'dat1607@gmail.com');


INSERT INTO accounts (account_id, user_id, account_name, type, balance, currency)
VALUES
('e8217da4-46b7-434f-ba84-69aab89f0dd0', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Bank', 'bank', 500000, 'VND'),
('7dc770af-615f-48a7-9c24-8baa3caf5571', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Tiền mặt', 'cash', 100000, 'VND'),
('e5217da4-46b7-434f-ba84-69aab89f0dd2', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Momo', 'ewallet', 600000, 'VND'),

('a534f72c-cac3-4387-8ec6-358438385953', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'Tiền mặt', 'cash', 80000, 'VND'),
('a834f72c-cac3-4387-8ec6-358438385954', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'ACB Bank', 'bank', 300000, 'VND'),
('a934f72c-cac3-4387-8ec6-358438385955', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'VCB', 'credit', 300000, 'VND'),

('92408ebb-8c11-4bdf-a008-8ad2fcbc3686', 'cd83a6d0-8422-417d-845f-f9633cd6099e', 'Tiền mặt', 'cash', 120000, 'VND'),
('93408ebb-8c11-4bdf-a008-8ad2fcbc3687', 'cd83a6d0-8422-417d-845f-f9633cd6099e', 'ViettinBank', 'bank', 3200000, 'VND'),

('d722044d-7259-4a95-9a9f-930935073828', '901ce87f-db7d-4ab2-a644-5b529b8a790b', 'Tiền mặt', 'cash', 60000, 'VND'),
('d4ffbef0-8bcc-445e-9ea3-7bc854e2ad76', '901ce87f-db7d-4ab2-a644-5b529b8a790b', 'TP Bank', 'bank', 200000, 'VND'),
('d922044d-7259-4a95-9a9f-930935073821', '901ce87f-db7d-4ab2-a644-5b529b8a790b', 'MB Bank', 'bank', 700000, 'VND');

INSERT INTO icons (icon_id, name, icon_code, category, is_active)
VALUES
('29307775-f865-4f36-9466-419b67323860', 'Salary Icon', 'salary_code', 'income', TRUE),
('16896264-924d-476c-9410-b960927e6992', 'Food Icon', 'food_code', 'expense', TRUE),
('556f8f1c-4b67-4228-863a-8673a88636e0', 'Transport Icon', 'trans_code', 'expense', TRUE),
('a0595304-706f-45e0-8f92-5e4d94d8d179', 'Shopping Icon', 'shop_code', 'expense', TRUE),
('b4297121-657d-4541-9494-013e87848417', 'Entertainment Icon', 'ent_code', 'expense', TRUE),
('f1995874-297d-460c-882d-136585918831', 'Bills Icon', 'bill_code', 'expense', TRUE);

INSERT INTO categories (category_id, user_id, category_name, type, icon_id, color, is_system)
VALUES
-- User 1
('d8588605-fa23-4b66-a81a-babc39f54ab8', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Salary', 'income', '29307775-f865-4f36-9466-419b67323860', 'green', FALSE),
('970eb25c-2af8-44f3-a762-a4b9a218668e', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Food', 'expense', '16896264-924d-476c-9410-b960927e6992', 'red', FALSE),
('7b926e06-f682-4e15-a412-554daa9b012d', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Transport', 'expense', '556f8f1c-4b67-4228-863a-8673a88636e0', 'blue', FALSE),
('87880d53-4827-4f06-8b0c-9c62de6692d9', '5324c950-d209-44b7-9e1b-2c3d859a17af', 'Shopping', 'expense', 'a0595304-706f-45e0-8f92-5e4d94d8d179', 'purple', FALSE),

-- User 2
('9dec18f6-2f93-4ee9-a402-9e6ae2cce8f8', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'Freelance', 'income', '29307775-f865-4f36-9466-419b67323860', 'green', FALSE),
('13a008d9-04c7-498f-9557-8dcbed643cb1', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'Coffee', 'expense', '16896264-924d-476c-9410-b960927e6992', 'brown', FALSE),
('1117481a-dd27-4615-9201-9a1cfec45c0e', 'e67f2863-5f03-4dff-b247-478b140ab6c4', 'Bills', 'expense', 'f1995874-297d-460c-882d-136585918831', 'orange', FALSE),

-- User 3
('18af69dc-a994-4213-aef1-a0c3e51ce711', 'cd83a6d0-8422-417d-845f-f9633cd6099e', 'Salary', 'income', '29307775-f865-4f36-9466-419b67323860', 'green', FALSE),
('c8798f26-d478-4bd7-a1bc-7335850d8dd0', 'cd83a6d0-8422-417d-845f-f9633cd6099e', 'Food', 'expense', '16896264-924d-476c-9410-b960927e6992', 'red', FALSE),

-- User 4
('cf4dfdab-3dda-4ae1-a1b2-09364b6c5d01', '901ce87f-db7d-4ab2-a644-5b529b8a790b', 'Salary', 'income', '29307775-f865-4f36-9466-419b67323860', 'green', FALSE),
('9b870dba-7323-4dfe-9da5-54dfef366f52', '901ce87f-db7d-4ab2-a644-5b529b8a790b', 'Entertainment', 'expense', 'b4297121-657d-4541-9494-013e87848417', 'pink', FALSE);