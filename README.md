<p align="center">
  <strong>🌷 Selamat Datang di Quinta Bloom & CO! 💕✨</strong>
</p>

![Opening](Technical%20Writer/opening.png)

Halo! Terima kasih sudah mampir ke proyek ini.  
Di sini, kamu akan menemukan **Project Transaction Database**, sistem manajemen transaksi bisnis yang menyediakan fitur pelacakan produk, stok, pelanggan, serta transaksi & invoice. Dashboard dilengkapi dengan laporan dan statistik interaktif untuk menganalisis jumlah transaksi dan pendapatan per kota, memudahkan pengambilan keputusan bisnis secara real-time⏳📉✨  

💡 **Apa yang bisa kamu temukan di sini?**  
✅ Dokumentasi lengkap  
✅ Source code yang bisa dikembangkan  
✅ Panduan instalasi & kontribusi  

📌 Jangan lupa cek **[Menu Navigasi](#-menu)** di bawah untuk menjelajahi lebih lanjut!  
Jika ada pertanyaan atau saran, feel free untuk membuka **issue** atau **pull request**. 🎉  

# 📜 Menu Navigasi  
> **Panduan Cepat untuk Menjelajahi Proyek Ini** 🚀  

📌 **Daftar Isi:**  
1️⃣ [📌 Information](#information)  
2️⃣ [📖 About](#about)  
3️⃣ [🖼 Screenshot](#screenshot)  
4️⃣ [🎥 Demo](#demo)  
5️⃣ [⚙️ Requirements](#requirements)  
6️⃣ [🗄 Database Scheme](#database-scheme)  
7️⃣ [📊 ERD](#erd)  
8️⃣ [📂 Data Description](#data-description)  
9️⃣ [📁 Folder Structure](#folder-structure)  
🔟 [👥 Our Team](#our-team)  

---

# 📝 Information  
## Sistem Manajemen Transaksi
Proyek ini merupakan implementasi sistem manajemen transaksi berbasis database yang dikembangkan untuk membantu bisnis dalam mencatat, memantau, dan menganalisis data transaksi secara terstruktur. Dengan fitur utama seperti pelacakan stok, manajemen pelanggan, serta laporan statistik interaktif, sistem ini mendukung pengambilan keputusan yang lebih cepat dan akurat.

## Penggunaan
Pengguna dapat menambahkan data produk, mengelola stok, dan mencatat transaksi penjualan dengan memilih pelanggan serta produk yang dibeli. Sistem secara otomatis menghitung total pembayaran dan menyimpan transaksi ke dalam database. Pengguna juga dapat mengakses laporan statistik untuk menganalisis penjualan, melihat tren stok, serta mengelola data pelanggan dan pengguna sesuai dengan hak akses yang diberikan

## Teknologi yang digunakan
1. DB Manger: MySQL, R-Studio
2. Backend:  R-Studio
3. Frontend:  R-Studio
4. Design : draw io


# 📖 About  

💡 Proyek ini dikembangkan untuk membantu bisnis dalam mengelola transaksi mereka secara lebih efisien dan terdokumentasi dengan baik. Dengan adanya fitur pelacakan stok, manajemen pelanggan, serta laporan statistik, sistem ini diharapkan dapat meningkatkan efisiensi operasional dan memberikan wawasan bisnis yang lebih baik bagi penggunanya. 
📚 Proyek ini dibuat sebagai tugas Proyek Praktikum Manajemen Data Statistika tahun 2025, dalam mata kuliah pilihan pascasarjana Statistik dan Sains Data, IPB University.

# 🖼 Screenshot  
![Logo](logo.png)
## Berikut adalah beberapa tampilan dari sistem:


### Beranda
![Beranda](Technical%20Writer/Beranda.jpg)

### Manajemen Produk
![Manajemen Produk](Technical%20Writer/Manajemen%20Produk.jpg)

### Manajemen Stok
![Manajemen Stok](Technical%20Writer/Manajemen%20Stok.jpg)

### Manajemen Pelanggan
![Manajemen Pelanggan](Technical%20Writer/Manajemen%20Pelanggan.jpg)

### Transaksi dan Invoice
![Transaksi dan Invoice](Technical%20Writer/Transaksi%20Invoice.jpg)

### Laporan Statistik
![Laporan Statistik](Technical%20Writer/Laporan%20Statistik.jpg)

 

# 🎥 Demo  ## Link Video  

Klik tautan di bawah untuk melihat video terkait proyek ini:  

[🎥 Lihat Video](https://drive.google.com/file/d/1IvRxLljFwm84VwQGiyFwV-cI6pugTREh/view?usp=sharing)


# 🗄 Database Scheme  
## Berikut adalah database sceheme pada sistem ini : 

![IR Diagram](https://github.com/Andiilla/Project-Transaction-Database/blob/498e84bbdacf4dfd7396779c136ab3f2fcd3b8df/Technical%20Writer/Kelompok%201__FIX_IR.jpg)

## 🏢 Cabang  
- **ID_Cabang**: Identitas unik cabang  
- **ID_Produk**: Produk yang tersedia  
- **Kota**: Lokasi cabang  
- **Jumlah_Stock**: Stok produk  

## 🛒 Invoice (Transaksi)  
- **ID_Invoice**: ID transaksi  
- **ID_Produk** | **ID_Cabang** | **ID_Pelanggan**  
- **Total**: Total harga 💰  
- **Tanggal & Waktu**: Waktu transaksi ⏳  
- **Pembayaran**: Metode pembayaran 💳  
- **Penilaian**: Feedback pelanggan ⭐  

## 👤 Pelanggan  
- **ID_Pelanggan**: ID pelanggan  
- **Tipe_Pelanggan**: Reguler/Member  
- **Jenis_Kelamin**: Gender  

## 📦 Produk  
- **ID_Produk**: ID produk  
- **Kategori_Produk**: Jenis produk  
- **Harga_Satuan**: Harga per unit 💵  
- **Kuantitas**: Jumlah produk  
- **Total_Harga**: Total harga transaksi  
- **ID_Cabang**: Cabang produk tersedia  

## 📦 Stock  
- **ID_Produk** | **ID_Cabang**  
- **Jumlah_Stock**: Ketersediaan stok 📊  
- **Tanggal_Update**: Update terakhir 📆  


# 🏗 Entity Relationship Diagram (ERD)
## Berikut adalah ERD dari sistem ini:

![ERD 1](Technical%20Writer/Kelompok%201_FIX_ERD1.jpg)

📌 **Penjelasan Tabel dan Relasi**

### **1. Produk (`ID_Produk` - Primary Key)**
   - Menyimpan informasi tentang produk seperti kategori, harga satuan, kuantitas, total harga, dan cabang tempat produk tersedia.
   - Memiliki relasi one-to-many dengan tabel **Stock**, **Invoice**, dan **Cabang**.

### **2. Stock (`ID_Produk`, `ID_Cabang` - Foreign Key)**
   - Menyimpan informasi jumlah stok produk di setiap cabang dan tanggal pembaruannya.
   - Berelasi many-to-one dengan tabel **Produk** dan **Cabang**.

### **3. Cabang (`ID_Cabang` - Primary Key)**
   - Menyimpan informasi tentang lokasi cabang, kota, dan jumlah stok produk di setiap cabang.
   - Berelasi dengan **Produk** dan **Stock**.

### **4. Pelanggan (`ID_Pelanggan` - Primary Key)**
   - Menyimpan data pelanggan seperti jenis kelamin dan tipe pelanggan.
   - Berelasi one-to-many dengan tabel **Invoice**.

### **5. Invoice (`ID_Invoice` - Primary Key)**
   - Menyimpan transaksi pembelian produk oleh pelanggan, termasuk detail pembayaran dan penilaian.
   - Berelasi many-to-one dengan tabel **Produk**, **Cabang**, dan **Pelanggan**.

📊 **Hubungan Antar Tabel**
- **Produk** memiliki banyak transaksi **Invoice**, sehingga `ID_Produk` menjadi Foreign Key di tabel **Invoice**.
- **Cabang** memiliki banyak produk dan stok, sehingga `ID_Cabang` menjadi Foreign Key di **Produk**, **Stock**, dan **Invoice**.
- **Pelanggan** bisa melakukan banyak transaksi, sehingga `ID_Pelanggan` menjadi Foreign Key di **Invoice**.

![ERD 2](Technical%20Writer/Kelompok%201_FIX_ERD2.jpg)

# 📂 Data Description  

## Deskripsi Proyek
Project Transaction Database adalah sistem manajemen transaksi bisnis yang menyimpan data terkait produk, pelanggan, invoice, dan stok barang di berbagai cabang.

---
## Berikut adalah tabel-tabel utama dalam database ini:
| **Nama Tabel**  | **Deskripsi**  |
|----------------|---------------|
| `Cabang`       | Menyimpan informasi mengenai cabang usaha |
| `Invoice`      | Menyimpan data transaksi penjualan |
| `Pelanggan`    | Menyimpan data pelanggan bisnis |
| `Produk`       | Menyimpan daftar produk beserta stoknya |



## 1. Tabel `cabang`
### Deskripsi
Tabel `cabang` menyimpan informasi mengenai cabang yang menjual produk tertentu, termasuk lokasi dan jumlah stok.

### Struktur Tabel
| Nama Kolom   | Tipe Data | Deskripsi |
|-------------|----------|-----------|
| ID_Cabang   | String   | ID unik untuk cabang |
| ID_Produk   | String   | ID produk yang tersedia di cabang |
| Kota        | String   | Lokasi cabang |
| Jumlah_Stock | Integer  | Jumlah stok produk di cabang |

### Syntax Insert Data
```r
for (i in 1:nrow(cabang)) {
  query <- sprintf("INSERT INTO cabang (ID_Cabang, ID_Produk, Kota, Jumlah_Stock) VALUES ('%s', '%s', '%s', '%s')",
    cabang$ID_Cabang[i], cabang$ID_Produk[i], cabang$Kota[i], cabang$Jumlah_Stock[i])
  dbExecute(con_db, query)
}
```

---

## 2. Tabel `produk`
### Deskripsi
Tabel `produk` berisi daftar produk yang tersedia, termasuk kategori, harga, dan total nilai transaksi per produk.

### Struktur Tabel
| Nama Kolom      | Tipe Data | Deskripsi |
|----------------|----------|-----------|
| ID_Produk      | String   | ID unik produk |
| Kategori_Produk | String  | Kategori produk |
| Harga_Satuan   | Float    | Harga satuan produk |
| Kuantitas      | Integer  | Jumlah produk yang terjual |
| Total_Harga    | Float    | Total nilai transaksi produk |
| ID_Cabang      | String   | ID cabang tempat produk dijual |

### Syntax Insert Data
```r
for (i in 1:nrow(produk)) {
  query <- sprintf("INSERT INTO produk (ID_Produk, Kategori_Produk, Harga_Satuan, Kuantitas, Total_Harga, ID_Cabang) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')",
    produk$ID_Produk[i], produk$Kategori_Produk[i], produk$Harga_Satuan[i], produk$Kuantitas[i], produk$Total_Harga[i], produk$ID_Cabang[i])
  dbExecute(con_db, query)
}
```

---

## 3. Tabel `pelanggan`
### Deskripsi
Tabel `pelanggan` berisi informasi tentang pelanggan yang melakukan transaksi, termasuk tipe pelanggan dan jenis kelamin.

### Struktur Tabel
| Nama Kolom      | Tipe Data | Deskripsi |
|----------------|----------|-----------|
| ID_Pelanggan   | String   | ID unik pelanggan |
| Tipe_Pelanggan | String   | Jenis pelanggan (Individu/Bisnis) |
| Jenis_Kelamin  | String   | Jenis kelamin pelanggan |

### Syntax Insert Data
```r
for (i in 1:nrow(pelanggan)) {
  query <- sprintf("INSERT INTO pelanggan (ID_Pelanggan, Tipe_Pelanggan, Jenis_Kelamin) VALUES ('%s', '%s', '%s')",
    pelanggan$ID_Pelanggan[i], pelanggan$Tipe_Pelanggan[i], pelanggan$Jenis_Kelamin[i])
  dbExecute(con_db, query)
}
```

---

## 4. Tabel `invoice`
### Deskripsi
Tabel `invoice` menyimpan informasi transaksi yang dilakukan oleh pelanggan, termasuk produk yang dibeli, jumlah pembayaran, dan penilaian transaksi.

### Struktur Tabel
| Nama Kolom    | Tipe Data | Deskripsi |
|--------------|----------|-----------|
| ID_Invoice   | String   | ID unik invoice |
| ID_Produk    | String   | ID produk yang dibeli |
| ID_Cabang    | String   | ID cabang tempat transaksi terjadi |
| ID_Pelanggan | String   | ID pelanggan yang melakukan transaksi |
| Total        | Float    | Total nilai transaksi |
| Tanggal      | Date     | Tanggal transaksi |
| Waktu        | Time     | Waktu transaksi |
| Pembayaran   | String   | Metode pembayaran |
| Penilaian    | Integer  | Penilaian pelanggan terhadap transaksi |

### Syntax Insert Data
```r
for (i in 1:nrow(invoice)) {
  query <- sprintf("INSERT INTO invoice (ID_Invoice, ID_Produk, ID_Cabang, ID_Pelanggan, Total, Tanggal, Waktu, Pembayaran, Penilaian) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",
    invoice$ID_Invoice[i], invoice$ID_Produk[i], invoice$ID_Cabang[i], invoice$ID_Pelanggan[i], invoice$Total[i], invoice$Tanggal[i], invoice$Waktu[i], invoice$Pembayaran[i], invoice$Penilaian[i])
  dbExecute(con_db, query)
}
```

---

## 5. Tabel `stock`
### Deskripsi
Tabel `stock` berisi informasi jumlah stok produk dan tanggal pembaruan stok.

### Struktur Tabel
| Nama Kolom      | Tipe Data | Deskripsi |
|----------------|----------|-----------|
| ID_Produk      | String   | ID unik produk |
| ID_Cabang      | String   | ID cabang tempat stok berada |
| Jumlah_Stock   | Integer  | Jumlah stok produk |
| Tanggal_Update | Date     | Tanggal terakhir stok diperbarui |

### Syntax Insert Data
```r
for (i in 1:nrow(stock)) {
  query <- sprintf("INSERT INTO stock (ID_Produk, ID_Cabang, Jumlah_Stock, Tanggal_Update) VALUES ('%s', '%s', '%s', '%s')",
    stock$ID_Produk[i], stock$ID_Cabang[i], stock$Jumlah_Stock[i], stock$Tanggal_Update[i])
  dbExecute(con_db, query)
}
```

---

## Cara Menggunakan
1. Pastikan Anda memiliki koneksi database yang telah dikonfigurasi dengan variabel `con_db`.
2. Pastikan data yang akan dimasukkan telah disiapkan dalam format dataframe sesuai tabel di atas.
3. Jalankan skrip di atas menggunakan R untuk memasukkan data ke dalam database.

---





# 🌸💻 Tim Pengembang Sistem 🌸💻

Hai semuanya! ✨ Kami adalah tim keren yang mengembangkan sistem ini! 🌈💖  
Kenalan dul# Tim Pengembang Sistem

Berikut adalah tim yang berkontribusi dalam pengembangan sistem ini:

- **Database Manager**  
  [Hazelita Dwi Rahmasari](https://github.com/hazelitadwirahmasari) (M0501241067)  
- **Frontend Developer**  
  [Andi Illa Erviani Nens](https://github.com/Andiilla) (M0501241035)  
- **Backend Developer**  
  [Rizka Annisa Mingka](https://github.com/rizkaamingka) (M0501241041)  
- **Technical Writer**  
  [Meavi Cintani](https://github.com/meavi2501cintani) (M0501241040)  
- **Database Designer**  
  [Wildatul Maulidiyah](https://github.com/WildatulMaulidiyah) (M0501241091)  

---

💖 **Terima kasih sudah mampir ke proyek kami!** 💖  
✨ Jangan lupa kasih ⭐ di repo ini ya! ✨  

