# This is my app!

library(tidyverse)
library(shiny)

ui <- fluidPage(
  theme = "my_theme.css",

  navbarPage(
    "This is my Title!",
    tabPanel("Thing 1",
             sidebarLayout(
               sidebarPanel(
                 "Widgets",
                 checkboxGroupInput(
                   inputId = "pick_species",
                   label = "Choose Species",
                   choices = unique(
                     starwars$species
                     ))),
               mainPanel(
                 "Output",
                 plotOutput(
                   "sw_plot"
                 )))),
    tabPanel(
      "Thing 2"
      ),
    tabPanel(
      "Thing 3"
      ))

)

server <- function(input, output) {

  sw_reactive <- reactive({
    starwars %>%
      filter(species %in%
               input$pick_species
             )})

  output$sw_plot <- renderPlot(
    ggplot(
      data = sw_reactive(
      ),
      aes(
        x = mass,
        y = height
      )) +
      geom_point(
        aes(
          color = species
          )))

}

shinyApp(ui = ui, server = server)
