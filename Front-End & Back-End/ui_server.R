library(shiny)
library(graphics)
library(shinydashboard)
library(graphics)
library(shiny)
library(DT)
library(DBI)
library(RMySQL)  # Jika menggunakan MySQL
library(ggplot2)
library(slickR)
library(leaflet)
library(shinycssloaders)





# Koneksi ke database
con <- dbConnect(
  RMySQL::MySQL(),  # Ganti dengan RPostgreSQL::PostgreSQL() jika menggunakan PostgreSQL
  dbname = "projecttransactiondatabase",
  host = "127.0.0.1",
  user = "root",
  password = "",
  port = 3306 # Sesuaikan dengan port database Anda
)

ui <- dashboardPage(
  dashboardHeader(title = "Business Transaction Management"),
  dashboardSidebar(
    tags$head(
      tags$style(HTML("
      #.sidebar-menu li.active a { background-color: #007BFF !important; color: white !important; }
        table.dataTable thead { background-color: #D9EAFD; color: black; }

        /* Animasi teks berjalan */
        @keyframes fadeInMove {
          0% { opacity: 0; transform: translateX(100vw); }
          10% { opacity: 1; transform: translateX(0); }
          100% { transform: translateX(-100vw); }
        }

        .animated-text {
          font-size: 50px;
          font-weight: bold;
          color: pink;
          text-align: center;
          position: relative;
          white-space: nowrap;
          animation: fadeInMove 8s linear infinite;
        }

        #/* Styling untuk Home Page */
        #home_tab {
        #  background-image: url('https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End%20%26%20Back-End/asset/Homepage1.png');
        #  background-size: cover;
        #  background-position: center;
        #  background-attachment: fixed;
        #  min-height: 100vh;
        #  padding: 0px;
        #}

        /* Header Kategori Produk */
        .kategori-header {
          background-color: #BE5985;
          color: white;
          font-weight: bold;
          text-align: center;
          padding: 12px;
          font-size: 23px;
          border-radius: 10px; /* Menambahkan lengkungan di setiap sudut */
          margin-bottom: 0; /* Menghilangkan space antara header dan konten di bawahnya */
        }

        /* Styling gambar kategori agar lebih menonjol */
        .kategori-gambar {
          border: 15px solid grey;
          box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
          display: block;
          border: 1px solid blue;
          padding: 10px;
          margin: 0 auto;
          border-radius: 10px;
        }
        
        /* Hilangkan margin dan padding yang tidak perlu */
        .header-container {
            margin: 0;
            padding: 10;
            width: 100%;
        }
        
        /* Pastikan gambar menempel ke batas elemen */
        .image-container {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
        }
        
        /* Tambahkan gradasi di belakang gambar */
        .image-container::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.6));
            z-index: 1;
        }
        
        /* Pastikan gambar tetap di belakang gradasi */
        .image-container img {
            width: 100%;
            height: auto;
            display: block;
            position: relative;
            z-index: 0;
        }
        /* Ganti Warna */
        .info-box {
            background-color: #E91E63 !important;
            color: white !important;
                  }

        /* Garis tabel lebih terlihat */
        table.dataTable {
          border: 1px solid blue;
          border-collapse: collapse;
        }
        
        table.dataTable th, table.dataTable td {
          border: none;
        }
        
        table.dataTable thead {
        border-bottom: 1px solid blue; 
        }
      
        table.dataTable tbody tr:last-child td {
          border-bottom: 1px solid blue; 
        }
      "))
    ),
    
    sidebarMenu(
      tags$div(
        style = "text-align: center; padding: 10px;",
        tags$img(
          src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/logo.png",  
          width = "80%", height = "auto", style = "border-radius: 10px;"
        )
      ),
      
      menuItem("Beranda", tabName = "home", icon = icon("home"), selected = TRUE),
      menuItem("Manajemen Produk", tabName = "produk", icon = icon("box")),
      menuItem("Manajemen Stok", tabName = "stok", icon = icon("warehouse")),
      menuItem("Manajemen Pelanggan", tabName = "pelanggan", icon = icon("users")),
      menuItem("Transaksi & Invoice", tabName = "transaksi", icon = icon("file-invoice-dollar")),
      menuItem("Laporan & Statistik", tabName = "statistik", icon = icon("chart-line")),
      menuItem("Tim Quinta Bloom & Co", tabName = "team", icon = icon("users-cog"))
    )
  ),
  
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "home", 
              fluidPage(
                # Teks selamat datang dengan animasi muncul
                tags$h2("WELCOME TO BUSINESS TRANSACTION SYSTEM DATABASE", 
                        class = "animated-text"),
                
                # Gambar Homepage1
                fluidRow(
                  column(12,
                         img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Homepage4.png",
                             width = "100%", height = "auto", style = "display:block; margin:auto;"))
                ),
                
                
                # Kategori Produk
                fluidRow(
                  column(12, 
                         h3("Kategori Produk", class = "kategori-header"),  # Header Pink
                         div(style = "height: 100%;", slickROutput("carousel", width = "100%", height = "300px"))
                  ),
                  column(12,
                         h3("Peta Kota Penjualan", class = "kategori-header", style = "margin-top: 400px;"),
                         div(style = "height: 200%; margin-top: 5px;", leafletOutput("peta_penjualan", height = "300px", width ="100%"))
                  )
                ))),
      
      tabItem(tabName = "produk", 
              fluidPage(
                # CSS Styling
                tags$style(HTML("
                  /* Header Manajemen Produk */
                  h2 {
                    background-color: #BE5985; /* Pink */
                    color: white;
                    padding: 15px;
                    text-align: center;
                    border-radius: 5px;
                    font-weight: bold;
                    border: 3px solid #BE5985; 
                  }
                  
                  /* Styling Tabel */
                  .dataTables_wrapper {
                    border: 1px solid #BE5985 !important;
                    border-radius: 6px;
                    padding: 10px;
                  }
                  
                  /* Hapus garis dalam tabel */
                  table.dataTable, table.dataTable th,
                  table.dataTable td {
                    border: none !important;
                  }

                  //* Header tabel tetap pink */
                  th {
                    background-color: #BE5985 !important; /* Pink */
                    color: white !important;
                  }
                ")),
                # Header
                h2("Manajemen Produk"),
                fluidRow(
                  column(3, selectInput("filter_kategori", "Pilih Kategori:", choices = NULL)),
                  column(3, selectInput("filter_kuantitas", "Pilih Jenis Kuantitas:", choices = c("Semua", 1:10),selected = "Semua")),
                  column(3, selectInput("filter_id_cabang", "Pilih ID Cabang:", choices = NULL)),
                  column(3, selectInput("filter_kota", "Pilih Kota:", choices = NULL)),
                  box(title = "Tabel Manajemen Produk", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("table_produk") %>% withSpinner(color = "#007BFF"))),
                # Navigasi Filter
                #fluidRow(
                #  column(3, selectInput("filter_kategori", "Pilih Kategori:", choices = NULL)),
                #  column(3, selectInput("filter_kuantitas", "Pilih Jenis Kuantitas:", choices = c("Semua", 1:10),selected = "Semua")),
                #  column(3, selectInput("filter_id_cabang", "Pilih ID Cabang:", choices = NULL)),
                #  column(3, selectInput("filter_kota", "Pilih Kota:", choices = NULL))
                #),
                #
                #DTOutput("table_produk") %>% withSpinner(color = "#007BFF")
              
      )),
      
      tabItem(tabName = "stok", 
              fluidPage(
                h2("Manajemen Stok"),
                
                # Navigasi Filter
                fluidRow(
                  column(3, selectInput("filter_id_cabang_stok", "Pilih ID Cabang:", choices = NULL)),
                  column(3, selectInput("filter_stok_range", "Pilih Rentang Stok:", 
                                        choices = c("Semua", "1-100", "100-200", "200-300", "300-400", "400-500"))),
                  box(title = "Tabel Manajemen Stock", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("table_stock") %>% withSpinner(color = "#007BFF")),
                ),
                #DTOutput("table_stock") %>% withSpinner(color = "#007BFF")
              )
      ),
      
      tabItem(tabName = "pelanggan", 
              fluidPage(
                h2("Manajemen Pelanggan"),
                
                # Navigasi Filter
                fluidRow(
                  column(6, selectInput("filter_tipe_pelanggan", "Pilih Tipe Pelanggan:", choices = NULL)),
                  column(6, selectInput("filter_jenis_kelamin", "Pilih Jenis Kelamin:", 
                                        choices = c("Semua", "Laki-laki", "Perempuan"))),
                  box(title = "Tabel Manajemen Pelanggan", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("table_pelanggan") %>% withSpinner(color = "#007BFF")),
                ),
                #DTOutput("table_pelanggan") %>% withSpinner(color = "#007BFF")
              )
      ),
      
      tabItem(tabName = "transaksi", 
              fluidPage(
                h2("Transaksi & Invoice"),
                # Navigasi Filter
                fluidRow(
                  column(4, selectInput("filter_id_cabang_transaksi", "Pilih ID Cabang:", choices = NULL)),
                  column(4, selectInput("filter_total_pembayaran", "Total Pembayaran:", 
                                        choices = c("Semua", "0-10000", "10000-20000", "20000-30000", "30000-40000"))),
                  column(4, selectInput("filter_jenis_pembayaran", "Jenis Pembayaran:", choices = NULL)),
                  box(title = "Tabel Transaksi & Invoice", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("table_invoice") %>% withSpinner(color = "#007BFF")),
                ),
                #DTOutput("table_invoice") %>% withSpinner(color = "#007BFF")
              )
      ),
      
      
      tabItem(tabName = "statistik", 
              fluidPage(
                tags$br(),
                
                fluidRow(
                  valueBoxOutput("total_cabang"),
                  valueBoxOutput("total_produk"),
                  valueBoxOutput("total_pelanggan")
                ),
                h2("Laporan & Statistik"),
                h4("Berikut adalah Grafik dan Laporan Statistik Business Transaction."),
                
                # Grafik transaksi dan harga kategori
                fluidRow(
                  column(6, plotOutput("transaksi_cabang_plot")),
                  column(6, plotOutput("harga_kategori_plot"))
                ),
                
                # Rekap Transaksi
                #h3("Rekap Jumlah Transaksi & Pendapatan per Cabang"),
                #DTOutput("Rekap Jumlah Transaksi & Pendapatan per Cabang"),
                h3("Rekap Jumlah Transaksi & Pendapatan per Cabang"),
                fluidRow(
                  box(title = "Tabel Transaksi dan Pendapatan", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("rekap_transaksi"))),
                
                # Produk dengan Penjualan Tertinggi
                h3("Produk dengan Penjualan Tertinggi"),
                selectInput("kategori_produk", "Pilih Kategori Produk:", choices = NULL), 
                plotOutput("penjualan_produk_plot"),
                #DTOutput("penjualan_produk_table"),
                fluidRow(
                  box(title = "Tabel Penjualan Produk", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("penjualan_produk_table"))),
                
                # Analisis Pola Pembelian
                h3("Analisis Pola Pembelian"),
                fluidRow(
                  box(title = "Tabel Pola Pembelian", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("pola_pembelian"))
                ),
                fluidRow(
                  box(title = "Grafik Pola Pembelian Pelanggan", status = "info", solidHeader = TRUE, width = 12,
                      plotOutput("grafik_pola_pembelian", height = "400px"))
                ),
                
                # Stok Hampir Habis
                h3("Stok Hampir Habis"),
                fluidRow(
                  box(title = "Stock Produk Kurang dari 50", status = "primary", solidHeader = TRUE, width = 12,
                      DTOutput("stok_hampir_habis"))),
               
                
                # Pendapatan Harian
                h3("Laporan Pendapatan Harian"),
                fluidRow(
                  box(title = "Tabel Pendapatan Harian", status = "success", solidHeader = TRUE, width = 12,
                      DTOutput("pendapatan_harian"))
                ),
                fluidRow(
                  box(title = "Tren Pendapatan Harian", status = "info", solidHeader = TRUE, width = 12,
                      plotOutput("grafik_pendapatan_harian", height = "400px"))
                )
              )),
      
      tabItem(tabName = "team", 
              fluidPage(
                h2("Tim Kami Quinta Bloom & CO"),
                tags$br(),
                fluidRow(
                  column(4, 
                         box( 
                           title = div("Frontend Developers", class = "box-title"), width = 12, status = "primary", solidHeader = TRUE, 
                           div(style = "text-align:center;", 
                               img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Andiilla.png", 
                                   height = "120px", width = "120px", class = "img-circle"),
                               h4("Andi Illa Erviani Nensi"),
                               p("M0501241035")
                           )
                         )
                  ),
                  column(4, 
                         box(
                           title = "DB Managers", width = 12, status = "success", solidHeader = TRUE,
                           div(style = "text-align:center;", 
                               img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Hazel.jpg", height = "120px", width = "140px", class = "img-circle"),
                               h4("Hazelita Dwi Rahmasari"),
                               p("M0501241067")
                           )
                         )
                  ),
                  column(4, 
                         box(
                           title = "Design Managers", width = 12, status = "info", solidHeader = TRUE,
                           div(style = "text-align:center;", 
                               img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Wilda.png", height = "120px", width = "120px", class = "img-circle"),
                               h4("Wildatul Maulidiyah"),
                               p("M0501241091")
                           )
                         )
                  )
                ),
                fluidRow(
                  column(4, 
                         box(
                           title = "Backend Developers", width = 12, status = "info", solidHeader = TRUE,
                           div(style = "text-align:center;", 
                               img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Rizka.png", 
                                   height = "120px", width = "120px", class = "img-circle"),
                               h4("Rizka Annisa Mingka"),
                               p("M0501241041")
                           )
                         )
                  ),
                  column(4, 
                         box(
                           title = "Technical Writers", width = 12, status = "info", solidHeader = TRUE,
                           div(style = "text-align:center;", 
                               img(src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Meavi.png", 
                                   height = "120px", width = "120px", class = "img-circle"),
                               h4("Meavi Cintani"),
                               p("M0501241040")
                           )
                         )
                  )
                ),
                tags$div(
                  fluidRow(
                    column(width = 12,
                           box(
                             title = "POV Pembuatan Database Kami", 
                             status = "primary", 
                             solidHeader = TRUE, 
                             width = 12,
                             tags$video(
                               src = "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/POV Creating Database.mp4",
                               type = "video/mp4", 
                               controls = "controls", 
                               style = "width: 100%; max-width: 100%; height: auto;"
                             )
                           )
      )
    )
  )
)))))




server <- function(input, output, session) {
  output$total_cabang <- renderValueBox({
    valueBox(
      value = 10,
      subtitle = "Total Cabang",
      color = "custom"
    )
  })
  
  output$total_produk <- renderValueBox({
    valueBox(
      value = 150,
      subtitle = "Total Produk",
      color = "custom"
    )
  })
  
  output$total_pelanggan <- renderValueBox({
    valueBox(
      value = 5000,
      subtitle = "Total Pelanggan",
      color = "custom"
    )
  })
  
  # Carousel dengan 7 kategori produk
  img_urls <- c(
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori1.png",
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori2.png",
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori3.png",
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori4.png",
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori5.png",
    "https://raw.githubusercontent.com/Andiilla/Project-Transaction-Database/main/Front-End & Back-End/asset/Kategori6.png"
  )
  
  # Nama kategori
  #category_names <- c(
  #  "Fashion Accessories",
  #  "Electronic Accessories",
  #  "Food and Beverage",
  #  "Health and Beauty",
  #  "Home and Lifestyle",
  #  "Sports and Products"
  #  )
  
  output$carousel <- renderSlickR({
    slickR(
      lapply(1:length(img_urls), function(i) {
        div(
          img(src = img_urls[i], width = "100%", height = "600px", style = "display:block; margin:auto;") #,
          #        div(category_names[i], style = "text-align:center; font-weight:bold; margin-top:20px; font-size:50px;")
        )
      })
    )
  })
  
  #output$carousel <- renderSlickR({
  #  slickR(img_urls) %>%
  #    slickR::slick( 
  #      slidesToShow = 3, 
  #      slidesToScroll = 1, 
  #      autoplay = TRUE, 
  #      autoplaySpeed = 3000, 
  #      dots = TRUE
  #    )
  #})
  
  
  # Peta Kota Penjualan
  kota <- data.frame(
    nama = c("Yangon", "Mandalay", "Naypyitaw"),
    lat = c(16.8661, 21.9750, 19.7633),
    lon = c(96.1951, 96.0836, 96.0785)
  )
  
  
  output$peta_penjualan <- renderLeaflet({
    leaflet(kota) %>%
      addTiles() %>%
      addAwesomeMarkers(~lon, ~lat, 
                        icon = awesomeIcons(
                          icon = "map-marker-alt", 
                          library = "fa",
                          markerColor = "red"
                        ),
                        label = ~nama, 
                        labelOptions = labelOptions(direction = "top", offset = c(0, -10)))
  })
  
  
  # Ambil data dari database untuk Manajemen Produk
  # Mengisi pilihan dropdown dari database
  observe({
    query_kategori <- "SELECT DISTINCT Kategori_Produk FROM produk"
    kategori_list <- dbGetQuery(con, query_kategori)$Kategori_Produk
    updateSelectInput(session, "filter_kategori", choices = c("Semua", kategori_list))
    
    query_id_cabang <- "SELECT DISTINCT ID_Cabang FROM produk"
    cabang_list <- dbGetQuery(con, query_id_cabang)$ID_Cabang
    updateSelectInput(session, "filter_id_cabang", choices = c("Semua", cabang_list))
    
    query_kota <- "SELECT DISTINCT c.Kota FROM produk p JOIN cabang c ON p.ID_Cabang = c.ID_Cabang"
    kota_list <- dbGetQuery(con, query_kota)$Kota
    updateSelectInput(session, "filter_kota", choices = c("Semua", kota_list))
  })
  
  # Ambil data dari database untuk Manajemen Produk dengan filter
  output$table_produk <- renderDT({
    query <- "SELECT p.ID_Produk, p.Kategori_Produk, p.Harga_Satuan, p.Kuantitas, 
                     p.Total_Harga, p.ID_Cabang, c.Kota 
              FROM produk p
              JOIN cabang c ON p.ID_Cabang = c.ID_Cabang
              WHERE 1=1"
    
    # Tambahkan filter sesuai pilihan pengguna
    if (input$filter_kategori != "Semua") {
      query <- paste0(query, " AND p.Kategori_Produk = '", input$filter_kategori, "'")
    }
    if (input$filter_kuantitas != "Semua") {
      query <- paste0(query, " AND p.Kuantitas = ", input$filter_kuantitas)
    }
    if (input$filter_id_cabang != "Semua") {
      query <- paste0(query, " AND p.ID_Cabang = '", input$filter_id_cabang, "'")
    }
    if (input$filter_kota != "Semua") {
      query <- paste0(query, " AND c.Kota = '", input$filter_kota, "'")
    }
    
    # Jalankan query dan tampilkan data
    data_produk <- dbGetQuery(con, query)
    datatable(data_produk)
  })
  
  
  # Placeholder untuk tabel lainnya
  # Mengisi pilihan dropdown ID Cabang dari database
  observe({
    query_id_cabang <- "SELECT DISTINCT ID_Cabang FROM stock"
    cabang_list <- dbGetQuery(con, query_id_cabang)$ID_Cabang
    updateSelectInput(session, "filter_id_cabang_stok", choices = c("Semua", cabang_list))
  })
  
  # Render tabel stok dengan filter yang diterapkan
  output$table_stock <- renderDT({
    query <- "SELECT ID_Produk, ID_Cabang, Jumlah_Stock, Tanggal_Update FROM stock WHERE 1=1"
    
    # Filter ID Cabang
    if (input$filter_id_cabang_stok != "Semua") {
      query <- paste0(query, " AND ID_Cabang = '", input$filter_id_cabang_stok, "'")
    }
    
    # Filter jumlah stok berdasarkan rentang
    if (input$filter_stok_range == "1-100") {
      query <- paste0(query, " AND Jumlah_Stock BETWEEN 1 AND 100")
    } else if (input$filter_stok_range == "100-200") {
      query <- paste0(query, " AND Jumlah_Stock BETWEEN 100 AND 200")
    } else if (input$filter_stok_range == "200-300") {
      query <- paste0(query, " AND Jumlah_Stock BETWEEN 200 AND 300")
    } else if (input$filter_stok_range == "300-400") {
      query <- paste0(query, " AND Jumlah_Stock BETWEEN 300 AND 400")
    } else if (input$filter_stok_range == "400-500") {
      query <- paste0(query, " AND Jumlah_Stock BETWEEN 400 AND 500")
    }
    
    # Jalankan query dan tampilkan data
    data_stock <- dbGetQuery(con, query)
    datatable(data_stock)
  })
  
  # MANAJEMEN PELANGGAN
  # Mengisi dropdown filter pelanggan dari database
  observe({
    query_tipe_pelanggan <- "SELECT DISTINCT Tipe_Pelanggan FROM pelanggan"
    tipe_list_pelanggan <- dbGetQuery(con, query_tipe_pelanggan)$Tipe_Pelanggan
    updateSelectInput(session, "filter_tipe_pelanggan", choices = c("Semua", tipe_list_pelanggan))
  })
  
  # Ambil data dari database untuk Manajemen Pelanggan dengan filter
  output$table_pelanggan <- renderDT({
    query <- "SELECT ID_Pelanggan, Tipe_Pelanggan, Jenis_Kelamin FROM pelanggan WHERE 1=1"
    
    # Filter berdasarkan Tipe Pelanggan
    if (input$filter_tipe_pelanggan != "Semua") {
      query <- paste0(query, " AND Tipe_Pelanggan = '", input$filter_tipe_pelanggan, "'")
    }
    
    # Filter berdasarkan Jenis Kelamin
    if (input$filter_jenis_kelamin != "Semua") {
      query <- paste0(query, " AND Jenis_Kelamin = '", input$filter_jenis_kelamin, "'")
    }
    
    # Jalankan query dan tampilkan data
    data_pelanggan <- dbGetQuery(con, query)
    datatable(data_pelanggan)
  })
  
  
  # TRANSAKSI & INVOICE
  # Mengisi dropdown filter ID Cabang dari database
  observe({
    query_cabang_transaksi <- "SELECT DISTINCT ID_Cabang FROM invoice"
    cabang_list_transaksi <- dbGetQuery(con, query_cabang_transaksi)$ID_Cabang
    updateSelectInput(session, "filter_id_cabang_transaksi", choices = c("Semua", cabang_list_transaksi))
  })
  
  # Mengisi dropdown filter Jenis Pembayaran dari database
  observe({
    query_jenis_pembayaran <- "SELECT DISTINCT Pembayaran FROM invoice"
    jenis_list_pembayaran <- dbGetQuery(con, query_jenis_pembayaran)$Pembayaran
    updateSelectInput(session, "filter_jenis_pembayaran", choices = c("Semua", jenis_list_pembayaran))
  })
  
  # Ambil data dari database untuk Transaksi & Invoice dengan filter
  output$table_invoice <- renderDT({
    query <- "SELECT ID_Invoice, ID_Produk, ID_Cabang, ID_Pelanggan, Total, Tanggal, Waktu, Pembayaran FROM invoice WHERE 1=1"
    
    # Filter berdasarkan ID Cabang
    if (input$filter_id_cabang_transaksi != "Semua") {
      query <- paste0(query, " AND ID_Cabang = '", input$filter_id_cabang_transaksi, "'")
    }
    
    # Filter berdasarkan rentang Total Pembayaran
    if (input$filter_total_pembayaran != "Semua") {
      total_range <- strsplit(input$filter_total_pembayaran, "-")[[1]]
      query <- paste0(query, " AND Total BETWEEN ", total_range[1], " AND ", total_range[2])
    }
    
    # Filter berdasarkan Jenis Pembayaran
    if (input$filter_jenis_pembayaran != "Semua") {
      query <- paste0(query, " AND Pembayaran = '", input$filter_jenis_pembayaran, "'")
    }
    
    # Jalankan query dan tampilkan data
    data_invoice <- dbGetQuery(con, query)
    datatable(data_invoice)
  })
  
  
  # LAPORAN & STATISTIK
  # Value Boxes
  output$total_cabang <- renderValueBox({
    query <- "SELECT COUNT(DISTINCT ID_Cabang) AS total FROM cabang"
    total_cabang <- dbGetQuery(con, query)$total
    valueBox(total_cabang, "Total Cabang", icon = icon("building"))
  })
  
  output$total_produk <- renderValueBox({
    query <- "SELECT COUNT(ID_Produk) AS total FROM produk"
    total_produk <- dbGetQuery(con, query)$total
    valueBox(total_produk, "Total Produk", icon = icon("box-open"))
  })
  
  output$total_pelanggan <- renderValueBox({
    query <- "SELECT COUNT(ID_Pelanggan) AS total FROM pelanggan"
    total_pelanggan <- dbGetQuery(con, query)$total
    valueBox(total_pelanggan, "Total Pelanggan", icon = icon("user-friends"))
  })
  
  # Statistik Jumlah Transaksi per Kota
  output$transaksi_cabang_plot <- renderPlot({
    query <- "SELECT c.Kota, COUNT(i.ID_Invoice) AS Jumlah_Transaksi
              FROM invoice i
              JOIN cabang c ON i.ID_Cabang = c.ID_Cabang
              GROUP BY c.Kota"
    transaksi_summary <- dbGetQuery(con, query)
    
    ggplot(transaksi_summary, aes(x = Kota, y = Jumlah_Transaksi, fill = Kota)) +
      geom_bar(stat = "identity") +
      labs(title = "Jumlah Transaksi per Kota", x = "Kota", y = "Jumlah Transaksi") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Statistik Pendapatan per Kota
  output$harga_kategori_plot <- renderPlot({
    query <- "SELECT c.Kota, SUM(i.Total) AS Total_Pendapatan
              FROM invoice i
              JOIN cabang c ON i.ID_Cabang = c.ID_Cabang
              GROUP BY c.Kota"
    pendapatan_summary <- dbGetQuery(con, query)
    
    ggplot(pendapatan_summary, aes(x = Kota, y = Total_Pendapatan, fill = Kota)) +
      geom_bar(stat = "identity") +
      labs(title = "Total Pendapatan per Kota", x = "Kota", y = "Total Pendapatan (Rp)") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Tabel Rekap Jumlah Transaksi dan Pendapatan per Kota
  output$rekap_transaksi <- renderDT({
    query <- "SELECT c.Kota, COUNT(i.ID_Invoice) AS Jumlah_Transaksi, SUM(i.Total) AS Total_Pendapatan
              FROM invoice i
              JOIN cabang c ON i.ID_Cabang = c.ID_Cabang
              GROUP BY c.Kota"
    rekap <- dbGetQuery(con, query)
    
    datatable(rekap, options = list(pageLength = 10))
  })
  
  # Produk dengan Penjualan Tertinggi
  output$top_produk <- renderDT({
    query <- paste0("SELECT p.ID_Produk, p.Harga_Satuan, 
                        SUM(i.Total) AS Total_Penjualan
                 FROM invoice i
                 JOIN produk p ON i.ID_Produk = p.ID_Produk
                 WHERE p.Kategori_Produk = '", input$kategori_produk, "'
                 GROUP BY p.ID_Produk, p.Harga_Satuan
                 ORDER BY Total_Penjualan DESC
                 LIMIT 10")
    top_produk <- dbGetQuery(con, query)
    datatable(top_produk)
  })
  
  # Analisis Pola Pembelian Pelanggan
  output$pola_pembelian <- renderDT({
    query <- "SELECT p.Tipe_Pelanggan, COUNT(i.ID_Invoice) AS Jumlah_Transaksi
              FROM invoice i
              JOIN pelanggan p ON i.ID_Pelanggan = p.ID_Pelanggan
              GROUP BY p.Tipe_Pelanggan
              ORDER BY Jumlah_Transaksi DESC"
    pola_pembelian <- dbGetQuery(con, query)
    datatable(pola_pembelian)
  })
  
  # Visualisasi Grafik Pola Pembelian Pelanggan
  output$grafik_pola_pembelian <- renderPlot({
    query <- "SELECT p.Tipe_Pelanggan, COUNT(i.ID_Invoice) AS Jumlah_Transaksi
            FROM invoice i
            JOIN pelanggan p ON i.ID_Pelanggan = p.ID_Pelanggan
            GROUP BY p.Tipe_Pelanggan
            ORDER BY Jumlah_Transaksi DESC"
    
    pola_pembelian <- dbGetQuery(con, query)
    
    ggplot(pola_pembelian, aes(x = reorder(Tipe_Pelanggan, -Jumlah_Transaksi), y = Jumlah_Transaksi, fill = Tipe_Pelanggan)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Distribusi Pola Pembelian Pelanggan",
           x = "Tipe Pelanggan",
           y = "Jumlah Transaksi") +
      theme(legend.position = "none")
  })
  
  # Stok Produk Hampir Habis (<50 unit)
  # Render Tabel Stok Hampir Habis
  output$stok_hampir_habis <- renderDT({
    query <- "SELECT ID_Produk, ID_Cabang, Jumlah_Stock
              FROM stock
              WHERE Jumlah_Stock < 50"
    stok_habis <- dbGetQuery(con, query)
    datatable(stok_habis)
  })
  
  
  # Laporan Pendapatan Harian
  # Render Tabel Pendapatan Harian
  output$pendapatan_harian <- renderDT({
    query <- "SELECT DATE(Tanggal) AS Tanggal, SUM(Total) AS Total_Pendapatan
              FROM invoice
              GROUP BY DATE(Tanggal)
              ORDER BY DATE(Tanggal)"
    pendapatan_harian <- dbGetQuery(con, query)
    datatable(pendapatan_harian)
  })
  
  # Render Grafik Tren Pendapatan Harian
  output$grafik_pendapatan_harian <- renderPlot({
    query <- "SELECT DATE(Tanggal) AS Tanggal, SUM(Total) AS Total_Pendapatan
              FROM invoice
              GROUP BY DATE(Tanggal)
              ORDER BY DATE(Tanggal)"
    
    pendapatan_harian <- dbGetQuery(con, query)
    
    ggplot(pendapatan_harian, aes(x = as.Date(Tanggal), y = Total_Pendapatan)) +
      geom_line(color = "blue", size = 1) +
      geom_point(color = "red", size = 2) +
      theme_minimal() +
      labs(title = "Tren Pendapatan Harian",
           x = NULL,  # Hapus label sumbu X
           y = "Total Pendapatan") +
      theme(axis.text.x = element_blank(),  # Sembunyikan teks tanggal
            axis.ticks.x = element_blank())  # Sembunyikan garis sumbu X
  })
  
  # Ambil daftar kategori produk untuk dropdown
  observe({
    query <- "SELECT DISTINCT Kategori_Produk FROM produk"
    kategori_list <- dbGetQuery(con, query)$Kategori_Produk
    updateSelectInput(session, "kategori_produk", choices = kategori_list)
  })
  
  
  # Tabel Produk dengan Penjualan Tertinggi Berdasarkan Kategori
  output$penjualan_produk_table <- renderDT({
    req(input$kategori_produk)
    query <- paste0("SELECT p.ID_Produk, p.Kategori_Produk, p.Harga_Satuan, 
                            SUM(i.Total) AS Total_Penjualan
                     FROM invoice i
                     JOIN produk p ON i.ID_Produk = p.ID_Produk
                     WHERE p.Kategori_Produk = '", input$kategori_produk, "'
                     GROUP BY p.ID_Produk, p.Kategori_Produk, p.Harga_Satuan
                     ORDER BY Total_Penjualan DESC
                     LIMIT 10")
    
    data_penjualan <- dbGetQuery(con, query)
    datatable(data_penjualan)
  })
  
  # Grafik Total Penjualan Berdasarkan Kategori Produk
  output$penjualan_produk_plot <- renderPlot({
    req(input$kategori_produk)
    
    query <- paste0("SELECT p.ID_Produk, SUM(i.Total) AS Total_Penjualan
                     FROM invoice i
                     JOIN produk p ON i.ID_Produk = p.ID_Produk
                     WHERE p.Kategori_Produk = '", input$kategori_produk, "'
                     GROUP BY p.ID_Produk
                     ORDER BY Total_Penjualan DESC
                     LIMIT 10")
    
    data_penjualan <- dbGetQuery(con, query)
    
    ggplot(data_penjualan, aes(x = reorder(ID_Produk, Total_Penjualan), y = Total_Penjualan, fill = ID_Produk)) +
      geom_bar(stat = "identity") +
      coord_flip() +
      labs(title = paste("Top Produk dalam Kategori:", input$kategori_produk),
           x = "ID Produk", y = "Total Penjualan") +
      theme_minimal()
  })
}


shinyApp(ui, server)

# Tutup koneksi setelah digunakan
# on.exit(dbDisconnect(con))
# dbListConnections(MySQL())
# lapply(dbListConnections(MySQL()), dbDisconnect)