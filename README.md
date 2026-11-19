# Implementasi SQL untuk Pengelolaan dan Analisis Basis Data

## Project Overview

Proyek ini merupakan implementasi Structured Query Language (SQL) menggunakan **PostgreSQL** untuk melakukan pengelolaan, pengolahan, dan analisis data pada basis data relasional.

Implementasi mencakup berbagai operasi SQL, mulai dari pengambilan dan pemfilteran data, agregasi, pengurutan, hingga penggabungan beberapa tabel menggunakan *JOIN*. Selain itu, proyek ini menerapkan fitur lanjutan PostgreSQL berupa *VIEW*, *STORED PROCEDURE*, dan *TRIGGER* untuk mendukung pengolahan data serta otomatisasi proses bisnis.

Studi kasus yang digunakan berfokus pada sistem penjualan ritel, yang melibatkan data produk, pelanggan atau member, transaksi penjualan, pegawai, dan cabang. Melalui implementasi ini, SQL digunakan untuk menghasilkan informasi penjualan, menganalisis aktivitas transaksi, serta mengotomatisasi perhitungan poin pelanggan.

## Objectives

Tujuan dari proyek ini adalah:

1. Mengimplementasikan berbagai perintah SQL untuk mengambil, memfilter, dan mengolah data dalam basis data relasional.
2. Menerapkan fungsi agregasi dan pengurutan untuk menghasilkan informasi berdasarkan kebutuhan analisis.
3. Menggabungkan beberapa tabel menggunakan *JOIN* untuk memperoleh informasi yang saling berkaitan.
4. Membuat *VIEW* untuk menyederhanakan akses terhadap hasil perhitungan dan ringkasan data.
5. Mengimplementasikan *STORED PROCEDURE* menggunakan PL/pgSQL untuk menjalankan operasi penambahan data.
6. Menerapkan *TRIGGER* untuk mengotomatisasi proses penambahan poin member berdasarkan nilai transaksi.

## Database Structure

Proyek ini menggunakan basis data relasional dengan beberapa tabel utama yang merepresentasikan aktivitas penjualan ritel.

| Table | Description |
|---|---|
| `products` | Menyimpan informasi produk, termasuk nama, kategori, dan harga. |
| `members` | Menyimpan informasi pelanggan atau member beserta jumlah poin yang dimiliki. |
| `sales` | Menyimpan informasi transaksi penjualan. |
| `sales_items` | Menyimpan rincian produk dan kuantitas pada setiap transaksi. |
| `employees` | Menyimpan informasi pegawai yang berkaitan dengan transaksi. |
| `branches` | Menyimpan informasi cabang tempat transaksi berlangsung. |

Keenam tabel tersebut digunakan sebagai dasar implementasi query untuk memperoleh informasi produk, pelanggan, transaksi, pegawai, dan performa penjualan setiap cabang.

## SQL Implementation and Query Scope

Implementasi SQL dalam proyek ini mencakup beberapa kategori operasi sebagai berikut.

### 1. Data Filtering – Product Category

Melakukan pemfilteran data produk berdasarkan kategori kopi (*coffee*).

Implementasi menggunakan kondisi `WHERE` dan fungsi `LOWER()` untuk memastikan proses pencarian kategori tidak bergantung pada perbedaan huruf kapital.

Informasi yang ditampilkan mencakup nama dan harga produk.

### 2. Member Data Filtering – Customer Points

Mengambil data pelanggan atau member yang memiliki jumlah poin lebih dari 100.

Implementasi menggunakan klausa `WHERE` dengan operator perbandingan untuk memperoleh data berdasarkan kriteria poin tertentu.

### 3. Sales Analysis – Best-Selling Products

Mengidentifikasi tiga produk dengan jumlah penjualan tertinggi.

Implementasi menggunakan:
- `JOIN` untuk menghubungkan data produk dengan rincian transaksi.
- `SUM()` untuk menghitung total kuantitas produk yang terjual.
- `GROUP BY` untuk mengelompokkan data berdasarkan produk.
- `ORDER BY DESC` untuk mengurutkan hasil berdasarkan total penjualan tertinggi.
- `LIMIT` untuk mengambil tiga produk teratas.

Analisis ini digunakan untuk mengetahui produk dengan kontribusi penjualan berdasarkan kuantitas terbesar.

### 4. Employee Performance – Transaction Analysis

Menganalisis aktivitas transaksi pegawai dengan menampilkan lima pegawai yang memiliki jumlah transaksi terbanyak.

Implementasi menggunakan relasi antartabel melalui `JOIN`, fungsi agregasi `COUNT()`, pengelompokan menggunakan `GROUP BY`, serta pengurutan menggunakan `ORDER BY DESC`.

Hasil analisis digunakan untuk membandingkan jumlah transaksi yang ditangani oleh masing-masing pegawai.

### 5. Branch Sales Analysis – Revenue by Branch

Menghitung total pendapatan setiap cabang selama periode November 2025.

Implementasi memanfaatkan beberapa operasi SQL, antara lain:
- `JOIN` untuk menghubungkan data transaksi, rincian penjualan, dan cabang.
- `SUM()` untuk menghitung total pendapatan.
- `GROUP BY` untuk mengelompokkan pendapatan berdasarkan cabang.
- Kondisi rentang tanggal untuk membatasi transaksi pada periode November 2025.

Analisis ini bertujuan untuk memberikan gambaran perbandingan pendapatan antar cabang dalam periode tertentu.

### 6. Database View – Daily Revenue

Membuat objek *VIEW* bernama `view_daily_revenue` untuk menyajikan ringkasan pendapatan penjualan berdasarkan tanggal.

VIEW digunakan untuk menyimpan definisi query sehingga hasil ringkasan dapat diakses kembali tanpa harus menuliskan keseluruhan query agregasi setiap kali dibutuhkan.

Pengujian VIEW dilakukan menggunakan perintah:

```sql
SELECT * FROM view_daily_revenue;
```

### 7. Stored Procedure – Product Insertion

Membuat *STORED PROCEDURE* bernama `tambah_produk` menggunakan bahasa prosedural PL/pgSQL.

Prosedur ini digunakan untuk menjalankan proses penambahan data produk baru ke dalam tabel `products`.

Implementasi ini memperkenalkan penggunaan prosedur tersimpan untuk mengelompokkan operasi database ke dalam satu prosedur yang dapat dipanggil kembali sesuai kebutuhan.

### 8. Database Trigger – Automated Member Points

Membuat *TRIGGER* bernama `trg_add_member_points` untuk mengotomatisasi penambahan poin pelanggan setelah transaksi berhasil dicatat.

Aturan perhitungan poin yang diterapkan adalah:

- Setiap kelipatan transaksi sebesar Rp10.000 menghasilkan 1 poin.
- Poin dihitung berdasarkan nilai transaksi.
- Penambahan poin dilakukan secara otomatis melalui mekanisme TRIGGER.

Implementasi ini bertujuan untuk mengurangi kebutuhan pembaruan poin secara manual serta menjaga konsistensi proses pencatatan poin pelanggan.

## SQL Concepts and Technologies

| Category | Concepts / Technologies |
|---|---|
| Database Management System | PostgreSQL |
| Query Language | SQL |
| Procedural Language | PL/pgSQL |
| Data Retrieval | SELECT, WHERE |
| Data Transformation | LOWER() |
| Aggregate Functions | SUM(), COUNT() |
| Data Grouping | GROUP BY |
| Data Sorting | ORDER BY, DESC |
| Table Relationships | INNER JOIN / JOIN |
| Query Limiting | LIMIT |
| Database Object | VIEW |
| Database Programming | STORED PROCEDURE |
| Process Automation | TRIGGER |

## Implementation Workflow

Tahapan implementasi dalam proyek ini disusun sebagai berikut:

1. **Database Preparation:** Menyiapkan basis data beserta tabel yang diperlukan.
2. **Data Retrieval and Filtering:** Mengambil dan memfilter data berdasarkan kondisi tertentu.
3. **Data Aggregation:** Mengolah data menggunakan fungsi agregasi untuk memperoleh ringkasan informasi.
4. **Relational Data Analysis:** Menggabungkan beberapa tabel menggunakan JOIN untuk menghasilkan analisis yang lebih komprehensif.
5. **Database View Creation:** Membuat VIEW untuk menyimpan definisi query ringkasan pendapatan harian.
6. **Stored Procedure Implementation:** Membuat prosedur tersimpan untuk menambahkan produk.
7. **Trigger Implementation:** Mengotomatisasi penambahan poin member berdasarkan transaksi.
8. **Query Testing and Verification:** Menguji setiap implementasi untuk memastikan hasil sesuai dengan kebutuhan.

## Requirements

Sebelum menjalankan proyek, pastikan perangkat telah memiliki:

- **PostgreSQL:** Sebagai sistem manajemen basis data relasional.
- **Database Client:** Menggunakan pgAdmin, DBeaver, atau PostgreSQL Query Tool untuk menjalankan dan mengelola query.
- **Database Schema:** Basis data yang telah memiliki tabel `products`, `members`, `sales`, `sales_items`, `employees`, dan `branches` beserta struktur kolom dan relasi yang sesuai dengan script SQL.

## How to Run

Ikuti langkah-langkah berikut untuk menjalankan implementasi SQL:

1. Pastikan PostgreSQL telah terinstal dan berjalan pada perangkat.
2. Buka database client seperti pgAdmin atau DBeaver.
3. Buat atau pilih database yang telah memiliki struktur tabel sesuai kebutuhan proyek.
4. Buka file `Yanaka Sofia Pardede_sql database uas query.sql`.
5. Periksa kembali urutan perintah dan pastikan seluruh tabel serta kolom yang digunakan telah tersedia.
6. Jalankan query secara berurutan sesuai dengan implementasi yang terdapat dalam script.
7. Periksa hasil setiap query melalui output yang dihasilkan oleh database client.
8. Uji objek VIEW menggunakan `SELECT * FROM view_daily_revenue;`.
9. Uji STORED PROCEDURE dan TRIGGER sesuai perintah pemanggilan serta skenario pengujian yang tersedia dalam script.

**Important Note:** Script SQL ini mengasumsikan bahwa struktur tabel dan relasi database telah tersedia. Jika digunakan pada database yang berbeda, sesuaikan nama tabel, kolom, tipe data, dan relasi dengan struktur database yang digunakan.

## Conclusion

Proyek ini menunjukkan penerapan SQL menggunakan PostgreSQL dalam pengelolaan dan analisis basis data relasional pada studi kasus penjualan ritel. Implementasi mencakup operasi pengambilan data, pemfilteran, agregasi, penggabungan tabel, serta pemanfaatan fitur lanjutan berupa VIEW, STORED PROCEDURE, dan TRIGGER.

Melalui penerapan berbagai konsep tersebut, proyek ini memberikan gambaran mengenai bagaimana SQL dapat digunakan tidak hanya untuk mengelola data, tetapi juga untuk menghasilkan informasi bisnis dan mengotomatisasi proses operasional dalam sebuah sistem basis data.
