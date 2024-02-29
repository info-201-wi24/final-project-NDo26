library(plotly)
library(dplyr)
library(ggplot2)

data <- read.csv("wnba_nba_data.csv")

server <- function(input, output){
  
  # TODO Make outputs based on the UI inputs here
  output$salary_player_plot <- renderPlotly({
    
    selected_df <- 
      data %>%
      filter(Player.Name %in% c(input$wnba_player, input$nba_player))
    
    plot <- ggplot(data = selected_df) +
      geom_col(
        mapping = aes(
          x = Player.Name,
          y = Salary,
          text = paste("Player", Player.Name, "has salary of", Salary),
          fill = Player.Name
        ) 
      ) + xlab("Player Name") + ylab("Salary")
    
    return(ggplotly(plot, tooltip = c("text")))
    
  })
}