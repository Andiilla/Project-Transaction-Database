# 👋 Selamat Datang di Repositori Ini! 🚀  

Halo! Terima kasih sudah mampir ke proyek ini.  
Di sini, kamu akan menemukan **Project Transaction Database**, istem manajemen transaksi bisnis yang menyediakan fitur pelacakan produk, stok, pelanggan, serta transaksi & invoice. Dashboard dilengkapi dengan laporan dan statistik interaktif untuk menganalisis jumlah transaksi dan pendapatan per kota, memudahkan pengambilan keputusan bisnis secara real-time⏳📉✨  

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

## 📝 Information  
>

## 📖 About  
> 💡 Proyek ini dikembangkan untuk membantu bisnis dalam mengelola transaksi mereka secara lebih efisien dan terdokumentasi dengan baik. Dengan adanya fitur pelacakan stok, manajemen pelanggan, serta laporan statistik, sistem ini diharapkan dapat meningkatkan efisiensi operasional dan memberikan wawasan bisnis yang lebih baik bagi penggunanya.  

## 🖼 Screenshot  
> **Tampilkan beberapa screenshot proyek di sini.**  

## 🎥 Demo  
> **Tambahkan link demo jika ada.**  

## ⚙️ Requirements  
> **List kebutuhan sistem & dependencies.**  

## 🗄 Database Scheme  
> **Struktur database yang digunakan.**  

## 🏗 Entity Relationship Diagram (ERD)
>Berikut adalah ERD untuk sistem ini:
Berikut adalah ERD dari sistem ini:

![ERD](./Kelompok%201_FIX_ERD1.jpg)

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




## 📂 Data Description  
> **Penjelasan tentang struktur data.**  

## 📁 Folder Structure  
> **Struktur folder proyek.**  

## 👥 Our Team  
> **Kenalan dengan tim pengembang!**  
