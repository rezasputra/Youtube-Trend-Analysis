ui <- dashboardPage(
  # Header
  dashboardHeader(
    title = "Youtube Indonesia Trend Analysis",
    titleWidth = 350
  ),
  
  # Sidebar
  dashboardSidebar(
    sidebarMenu(
      # Tab 1
      menuItem(
        "Home", tabName = "home", icon = icon("home")
      ),
      # Tab 2
      menuItem(
        "Trend", tabName = "trend", icon = icon("chart-line")
      )
    )
  ),
  
  # Body
  dashboardBody(
    tags$style(HTML("
                .skin-blue .main-header .logo {
                background-color: #003366;
                }
                .skin-blue .main-header .navbar {
                background-color: #003366;
                }
                
                .box.box-solid.box-primary>.box-header {
                background:#000066
                }

                .box.box-solid.box-primary{
                background:#ffffff;
                border-bottom-color:#666666;
                border-left-color:#666666;
                border-right-color:#666666;
                border-top-color:#666666;
                }

                ")),
    tabItems(
      # Tab 1
      tabItem(
        tabName = "home",
        # Row 1
        fluidRow(
          box(
            title = "Trend Youtube Indonesa", solidHeader = T, 
            status = "primary", width = 12,
            mainPanel(
              width = 12,
              h4("Oleh Reza Syahputra"),
              p("Youtube Trend adalah sebuah peringkat yang berisikan sekumpulan
                video dengan interaksi paling banyak. Interaksi tersebut tidak terbatas
                pada paling dicari, dilihat, comment dan sebagaianya"),
              p("Dashboard ini berisikan informasi dari Youtube Trend Indonesia, 
                dengan dataset yang diambil dari situs Kaggle", 
                a(href="https://www.kaggle.com/syahrulhamdani/indonesias-trending-youtube-video-statistics", 
                  "Indonesias Trending Youtube"))
            )
          )
        ),
        # Row 2
        fluidRow(
          box(
            title = "Trending Category of Youtube Indonesia 2021-2022", solidHeader = T,
            status = "primary", width = 12,
            plotlyOutput("cat_plot")
          )
        ),
        # Row 3
        fluidRow(
          box(
            title = "Data Overview", solidHeader = T,
            status = "primary", width = 12,
            dataTableOutput("main_data")
          )
        ),
        
      ),
     
      # Tab 2
      tabItem(
        tabName = "trend",
        selectInput("category", "Pilih Category:", 
                    c("Film and Animation" = "Film and Animation",
                      "Autos and Vehicles" = "Autos and Vehicles", 
                      "Music" = "Music", 
                      "Pets and Animals" = "Pets and Animals", 
                      "Sports" = "Sports",
                      "Short Movies" = "Short Movies",
                      "Travel and Events" = "Travel and Events", 
                      "Gaming" = "Gaming", 
                      "Videoblogging" = "Videoblogging",
                      "People and Blogs" = "People and Blogs", 
                      "Comedy" = "Comedy",
                      "Entertainment" = "Entertainment", 
                      "News and Politics" = "News and Politics",
                      "Howto and Style" = "Howto and Style", 
                      "Education" = "Education",
                      "Science and Technology" = "Science and Technology", 
                      "Undefined" = "Undefined",
                      "Movies" = "Movies",
                      "Anime/Animation" = "Anime/Animation",
                      "Action/Adventure" = "Action/Adventure",
                      "Classics" = "Classics",
                      "Comedy" = "Comedy",
                      "Documentary" = "Documentary",
                      "Drama" = "Drama",
                      "Family" = "Family",
                      "Foreign" = "Foreign",
                      "Horror" = "Horror",
                      "Sci-Fi/Fantasy" = "Sci-Fi/Fantasy",
                      "Thriller" = "Thriller",
                      "Shorts" = "Shorts",
                      "Shows" = "Shows",
                      "Trailers" = "Trailers")
                    ),
        fluidRow(
          valueBoxOutput("top_views_channel", width = 6),
          valueBoxOutput("popular_channel", width = 6)
        ),
        fluidRow(
          box(
            title = "Top Views Channel", solidHeader = T,
            width = 6, status = "primary",
            plotlyOutput("top_views_plot", height = 300)
          ),
          box(
            title = "Top Popular Channel", solidHeader = T,
            width = 6, status = "primary", 
            plotlyOutput("popular_plot", height = 300)
          )
        ),
        fluidRow(
          box(
            title = "Activity Viewers", solidHeader = T,
            width = 6, background = "black", 
            plotlyOutput("activity_plot", height = 300)
          ),
          box(
            title = "Correlation Views-Likes and Comment", solidHeader = T,
            width = 6, background = "black", 
            plotlyOutput("correlation_vlc_plot", height = 300)
          )
        ),
        fluidRow(
          
        )
      )
    )
  ),
  skin = "blue",
)