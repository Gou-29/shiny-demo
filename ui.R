# ui.r
fluidPage(
  
  # Application title
  titlePanel("Demo shiny app: mtcars data panel"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      fileInput("file_input", "Choose CSV File",accept = ".csv"),
      checkboxGroupInput(inputId = "varlist",
                         label = 'Select variable you are interest:', 
                         choices = c("mpg"  = "mpg",
                                     "cyl"  = "cyl",
                                     "disp" = "disp",
                                     "hp"   = "hp",
                                     "drat" = "drat",
                                     "wt"   = "wt",
                                     "qsec" = "qsec",
                                     "vs"   = "vs",
                                     "am"   = "am",
                                     "gear" = "gear",
                                     "carb" = "carb"),
                         inline = T),
      selectInput(inputId = "x_var",
                  label = "X axis",
                  choices = c("mpg"  = "mpg",
                              "cyl"  = "cyl",
                              "disp" = "disp",
                              "hp"   = "hp",
                              "drat" = "drat",
                              "wt"   = "wt",
                              "qsec" = "qsec",
                              "vs"   = "vs",
                              "am"   = "am",
                              "gear" = "gear",
                              "carb" = "carb")),
      selectInput(inputId = "y_var",
                  label = "Y axis",
                  choices = c("mpg"  = "mpg",
                              "cyl"  = "cyl",
                              "disp" = "disp",
                              "hp"   = "hp",
                              "drat" = "drat",
                              "wt"   = "wt",
                              "qsec" = "qsec",
                              "vs"   = "vs",
                              "am"   = "am",
                              "gear" = "gear",
                              "carb" = "carb")),
      submitButton("Update!"),
      h3("Dowload summary statistics"),
      downloadButton(outputId = "outdata", 
                     label = "Click to download")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        box(title = "Summary statistics",
            solidHeader = T,
            width = 12,
            collapsible = T,
            div(DT::DTOutput("summary"), style = "font-size: 100%;"))
      ),
      fluidRow(
        box(width = 3),
        box(width = 9,
            title = "Relationship between variables",
            plotlyOutput("plot", width = 450, height = 400)),
        box(width = 3)
      )
    )
  )
)