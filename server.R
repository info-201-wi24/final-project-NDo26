library(plotly)
library(dplyr)
library(ggplot2)
library(stringr)

data <- read.csv("wnba_nba_data.csv")

server <- function(input, output){
  
  # TODO Make outputs based on the UI inputs here
  # Salary and Games
  output$salary_games_played <- renderPlotly({
    
    nba_data <- nba_2022_2023 %>% 
      filter(GP <= input$games_played)
    
    wnba_data <- wnba_2022 %>% 
      filter(G <= input$games_played)
    
    plot_code <- ggplot() +
      geom_point(data = wnba_data, aes(
        x = G,
        y = X2022.Salary,
        color = "WNBA",
        text = paste("Player is a part of the WNBA and plays in", G, "games with a salary of", X2022.Salary)
      )) +
      geom_point(data = nba_data, aes(
        x = GP,
        y = Salary,
        color = "NBA",
        text = paste("Player is a part of the NBA and plays in", GP, "games with a salary of", Salary)
      )) +
      scale_color_manual(values = c("WNBA" = "red", "NBA" = "blue"),
                         labels = c("WNBA", "NBA")) + 
      labs(x = "Number of Games Played",
           y = "Salary")
    
    return(ggplotly(plot_code, tooltip = c("text")))
    
  })
  
  #Salary/Player
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
  
  #Player Stats
  output$player_stats_comparison <- renderPlotly({
    # Ensure selected_df is correctly filtered as before
    selected_df <- 
      data %>%
      filter(Player.Name %in% c(input$wnba_player2, input$nba_player2))
    
    stat_choices <- c(
      "Games Played" = "Games.Played",
      "Games Started" = "Games.Started",
      "Minutes Played" = "Minutes.Played",
      "Field Goals Made" = "Field.Goals.Made",
      "Field Goals Attempted" = "Field.Goals.Attempted",
      "3-Pointers Made" = "X3.Pointers.Made",
      "3-Pointers Attempted" = "X3.Pointers.Attempted",
      "2-Pointers Made" = "X2P",
      "2-Pointers Attempted" = "X2PA",
      "Free-Throws Made" = "Free.Throws.Made",
      "Free-Throws Attempted" = "Free.Throws.Attempted",
      "Offensive Rebounds" = "Offensive.Rebounds",
      "Defensive Rebounds" = "Defensive.Rebounds",
      "Total Rebounds" = "Total.Rebounds",
      "Assists" = "Assists",
      "Steals" = "Steals",
      "Blocks" = "Blocks",
      "Turnovers" = "Turnovers",
      "Personal Fouls" = "Personal.Fouls"
    )
    
    stat_column_name <- stat_choices[input$stat]
    
    plot <- ggplot(data = selected_df) +
      geom_col(
        mapping = aes(
          x = Player.Name,
          y = selected_df[[stat_column_name]],
          text = paste0(selected_df$Player.Name, " has an average of ", selected_df[[stat_column_name]], " ", tolower(input$stat)),          
          fill = Player.Name
        ) 
      ) + xlab("Player Name") + ylab(input$stat)
    
    return(ggplotly(plot, tooltip = c("text")))
  })
  
  
}
