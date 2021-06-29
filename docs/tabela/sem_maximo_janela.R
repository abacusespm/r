## discussão em https://stackoverflow.com/questions/40538365/r-shiny-how-to-get-square-plot-to-use-full-width-of-panel

library( shiny )
library( ggplot2 )

server <- function(input, output)
{
  output$plot1 <- renderPlot({
    X <- data.frame( x=rnorm(input$n), y=rnorm( input$n ) )
    ggplot( X, aes(x=x, y=y) ) + geom_point() + coord_fixed()
  }, height=400   # how to get this value to be mainPanel width?
  )
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "Number of Samples", min=10, max=1000, value=100) ),
    mainPanel( plotOutput("plot1", height="auto") )
  )
)

shinyApp(ui = ui, server = server)
