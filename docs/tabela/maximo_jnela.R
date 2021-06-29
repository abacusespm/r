## discussão em https://stackoverflow.com/questions/40538365/r-shiny-how-to-get-square-plot-to-use-full-width-of-panel


library( shiny )
library( ggplot2 )

server <- function(input, output)
{
  output$plot1 <- renderPlot({
    X <- data.frame( x=rnorm(10), y=rnorm( 10) )
    ggplot( X, aes(x=x, y=y) ) + geom_point() +  coord_fixed()
  } ,
  height=reactive(ifelse(!is.null(input$innerWidth),input$innerWidth*3/5,0))
  )
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      tags$head(tags$script('$(document).on("shiny:connected", function(e) {
                            Shiny.onInputChange("innerWidth", window.innerWidth);
                            });
                            $(window).resize(function(e) {
                            Shiny.onInputChange("innerWidth", window.innerWidth);
                            });
                            ')),
      sliderInput("n", "Number of Samples", min=10, max=1000, value=100) ),
    mainPanel( plotOutput("plot1"))
  )
)

shinyApp(ui = ui, server = server)
