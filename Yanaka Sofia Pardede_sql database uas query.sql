--1. Tampilkan nama dan harga produk dari kategori kopi 
SELECT product_name, price FROM products WHERE category = 'coffee';

--2. Tampilkan data pelanggan yang memiliki poin di atas 100
SELECT* FROM members WHERE points > 100;

--3. Tampilkan 3 produk terlaris berdasarkan total quantity
SELECT product_id FROM sales_items
GROUP BY product_id
ORDER BY SUM(quantity) LIMIT 3;

--4. Tampilkan nama 5 pegawai dengan total transaksi terbanyak. Urutkan dari total transaksi paling tinggi
SELECT full_name, COUNT(*) AS total_transaksi FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY full_name ORDER BY total_transaksi DESC LIMIT 5;

--5. Berapa total penjualan per cabang pada bulan November 2025
SELECT branch_name, SUM(subtotal) total_penjualan FROM sales 
JOIN sales_items USING(sale_id) JOIN branches USING(branch_id)
WHERE sale_time BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY branch_name;

--6. Buat VIEW bernama view_daily_revenue untuk menampilkan total pendapatan per hari
CREATE VIEW view_daily_revenue 
SELECT DATE(sale_time) AS tanggal, SUM(subtotal) AS total_pendapatan FROM sales 
JOIN sales_items si USING (sale_id)
GROUP BY DATE(sale_time);
--SAYA LAKUKAN UNTUK MENGECEK ISI
SELECT * FROM view_daily_revenue;

--7. Buat STORED PROCEDURE untuk memasukkan produk baru
CREATE OR REPLACE PROCEDURE tambah_produk(p_name VARCHAR, p_category VARCHAR, p_price NUMERIC)
BEGIN
    INSERT INTO products (product_name, category, price)
    VALUES (p_name, p_category, p_price);

CALL tambah_produk('Onion Ring', 'snack', 22000);
--MENAMPILKAN PRODUK YANG BARU DI TAMBAH
SELECT * FROM products;

--8. Buat TRIGGER yang otomatis menambah poin member setiap transaksi berhasil ditambahkan (+1 poin per transaksi senilai Rp.10.000,-
CREATE OR REPLACE FUNCTION add_member_points()
DECLARE
    total_belanja NUMERIC;
    poin INT;
BEGIN
    --JIKA BUKAN MEMBER
    IF NEW.member_id IS NULL THEN
        RETURN NEW;
    END IF;
    --TOTAL BELANJANYA
    SELECT SUM(subtotal)
    INTO total_belanja
    FROM sales_items
    WHERE sale_id = NEW.sale_id;
    --HITUNG(1 POIN SETIAP TRANSAKSI 10.000)
    poin := FLOOR(total_belanja / 10000);
    UPDATE members
    SET points = points + poin
    WHERE member_id = NEW.member_id;

CREATE TRIGGER trg_add_member_points
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION add_member_points();
--MENAMPILKAN NAMA MEMBER DAN JUMLAH POIN NYA
SELECT member_id, full_name, points
FROM members
WHERE member_id = 1;

