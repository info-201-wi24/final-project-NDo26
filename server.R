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
  output$salary_games_played <- renderPlotly({
   
    plot_code <- ggplot() +
      geom_point(data = wnba_2022, aes(
        x = G,
        y = X2022.Salary,
        color = "WNBA"
      )) +
      geom_point(data = nba_2022_2023, aes(
        x = GP,
        y = Salary,
        color = "NBA"
      )) +
      scale_color_manual(values = c("WNBA" = "red", "NBA" = "blue"),
      labels = c("WNBA", "NBA")) + 
      labs(x = "Number of Games Played",
           y = "Salary")
      
  return(ggplotly(plot_code))

  })
  
}
