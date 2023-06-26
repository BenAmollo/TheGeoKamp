library(shiny)
library(leaflet)
library(htmltools)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),  # Enable shinyjs
  
  
  
  # Define a shiny tab content
  tabsetPanel(
    id = "tabs",
    tabPanel("Main Tab",
             # Add a leaflet map
             leafletOutput("map"),
             "This is the main tab content."
    ),
    tabPanel("Other Tab",
             # Add a leaflet map
             leafletOutput("mapo"),
             "This is the other tab content."
    )
  )
  
)



server <- function(input, output, session) {
  
  # Render the leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(
        lng = 36.90114,
        lat = -1.28953,
        popup = paste(
          "<a href='#' class='link'>Open new tab</a>"
        )
      )
  })
  
  # Render the leaflet map
  output$mapo <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(
        lng = 36.8784365,
        lat = -1.2321621,
        popup = paste(
          "<a href='#' class='link'>Open new tab</a>"
        )
      )
  })
  
  # Handle the link click event
  observeEvent(input$map_marker_click, {
    click <- input$map_marker_click
    
    # Check if the clicked element has the 'link' class
    if (click$id == "map" && click$js$type == "click" && click$js$classList == "link") {
      # Open the "Other Tab" programmatically
      shinyjs::runjs("$('#tabs a[href=\"#tabs-2\"]').tab('show');")
    }
  })
}

shinyApp(ui, server)
