install.packages("shinythemes")
library(shinythemes)
library(plotly)
library(dplyr)
library(ggplot2)


data <- read.csv("wnba_nba_data.csv", na.strings = "--")
nba <-
  data %>%
  filter(Is_NBA == 1)

wnba <-
  data %>%
  filter(Is_NBA == 0)
  

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview",
   h1("About WNBA v.s. NBA Project"),
   HTML("<h6>Joey, Makayla, Nathan, Nowali<br>
      INFO 201<br>
      Kyle Thayer</h6>"),
   p("The gender wage gap is a popularly debated topic within the public sphere; however, what happens when we analyze the pay disparity within a traditionally male-dominated space, such as basketball? While most gender wage gap statistics present an aggregate of all fields, we aim to answer questions regarding the pay gap in the NBA and WNBA."),
   p("We also aim to inquire whether there is a pay disparity even between certain NBA and WNBA players; would this entail the top earners continuing to dominate? Also, can we make predictions, taking in information about a player, and determine how much a player may make?  Furthermore, how can major corporations do better in closing the gender wage gap within the sports industry?"),
   p("This is a real-world issue and with the proper information and with further insight, we aim to be able to answer many big social problems surrounding gender discrimination in the workplace. Gender discrimination happens in so many areas of our lives and we hope to achieve some reason as to why this happens on stages as big as professional sports. Should a male professional basketball player be making almost 150 times what a female professional player makes? "),
   
   HTML("<div class='tenor-gif-embed' data-postid='22413242' data-share-method='host' data-aspect-ratio='.5' data-width='25%'><a href='https://tenor.com/view/nba-finals-bucks-win-basketball-gif-22413242'>Nba Finals Sticker</a>from <a href='https://tenor.com/search/nba-stickers'>Nba Stickers</a></div> <script type='text/javascript' async src='https://tenor.com/embed.js'></script><alt = 'sillybear slam dunking'>"),
   
   h2("Our Data"),
   HTML("<p>Not wanting to pay $200 to use their API, we decided to scrape data regarding the WNBA from <a href = 'https://herhoopstats.com/'><em>herhoopstats.</em></a>  Although the site does not disclose how they collect their data, herhoopstats is claimed to be the number 1 site for women’s basketball statistics. Usually, sport statistics sites collect their data from official game records, automated web scraping for data, and manual data entries. Our WNBA dataset has 202 rows (including the header row) and 27 columns, containing information  about player salary, their type of contract, and average game statistics for 2022 season.</p>"),
   HTML("<p>For our data regarding NBA, we found a dataset from <a href = 'https://gigasheet.com/sample-data/nba-player-salaries-2022-23-season'><em>gigasheet</em></a>, a site that allows people to upload and analyze their own and others’ datasets, similar to <em>kaggle. </em>Because of this, we are unsure where the data for the dataset is collected from. The NBA dataset has 467 rows and 52 columns. This file contains data about player salary, their team, position, age, and average game statistics for the 2022-2023 season.</p>")
)

## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Choose Number of Games Played"),
  #TODO: Put inputs for modifying graph here
fluidRow(
  column(10, 
         wellPanel(
           h3("Select"),
           sliderInput("games_played", "Number of Games Played",
                      min = 0, max = 83, value = 50, step = 1)))
  ),
h1("Explanation for Graph"),
p("By looking at the number of games that players from both the NBA and WNBA play, this will give us some idea of whether or not meaningful playing statistics are a factor in determining the wage for players. In theory, the more games a player has played, the higher their salary as they are performing well for their team.
  As we can see from the graph, even though NBA players play significantly more than WNBA players, it is important to recognize the difference in pay when an NBA and a WNBA player play the same amount of games. There is a significant difference in how much the players in different leagues make even when they play the same amount.
  The difference is very large, NBA players make thousands and thousands more than WNBA players.
  This adds to our research as it shows the disadvantages professional women basketball players face in their field. They don't get nearly as much playing time as NBA players, and when they do, they are paid significantly less.")
)

viz_1_main_panel <- mainPanel(
  h2("Comparing Number of Games Played and Salary"),
  plotlyOutput(outputId = "salary_games_played"))

viz_1_tab <- tabPanel("Salaries by Games Played",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO-- compare salary between nba and wnba

viz_2_sidebar <- sidebarPanel(
  h2("Choose your Players"),
  #TODO: Put inputs for modifying graph here
  selectInput(inputId = "nba_player", 
              label = "Select a NBA player",
              choices = sort(nba$Player.Name),
              selected =  "Aaron Gordon",
              multiple = F),
  selectInput(inputId = "wnba_player", 
              label = "Select a WNBA player",
              choices = sort(wnba$Player.Name),
              selected =  "A'ja Wilson",
              multiple = F)
)

viz_2_main_panel <- mainPanel(
  h2("Comparing Salaries between a NBA and WNBA Player"),
  plotlyOutput(outputId = "salary_player_plot")
)

viz_2_tab <- tabPanel("Salary Comparisons by Player",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO
stat_choices <- c(
  "Games Played",
  "Games Started",
  "Minutes Played",
  "Field Goals Made",
  "Field Goals Attempted",
  "3-Pointers Made",
  "3-Pointers Attempted",
  "2-Pointers Made",
  "2-Pointers Attempted",
  "Free-Throws Made",
  "Free-Throws Attempted",
  "Offensive Rebounds",
  "Defensive Rebounds",
  "Total Rebounds",
  "Assists",
  "Steals",
  "Blocks",
  "Turnovers",
  "Personal Fouls"
)

viz_3_sidebar <- sidebarPanel(
  h2("Select an statistic and the players you want to compare"),
  #TODO: Put inputs for modifying graph here
  selectInput(inputId = "stat",
              label = "Select a Statistic",
              choices = stat_choices
              ),
  #TODO: Put inputs for modifying graph here
  selectInput(inputId = "nba_player2", 
              label = "Select a NBA player",
              choices = sort(nba$Player.Name),
              selected =  "Aaron Gordon",
              multiple = F),
  selectInput(inputId = "wnba_player2", 
              label = "Select a WNBA player",
              choices = sort(wnba$Player.Name),
              selected =  "A'ja Wilson",
              multiple = F)
)

viz_3_main_panel <- mainPanel(
  h2("NBA vs WNBA Player Stats"),
  h4("Statistics are per-game averages from the 2022-2023 season"),
  plotlyOutput(outputId = "player_stats_comparison")
)

viz_3_tab <- tabPanel("Comparing Average Stats between NBA and WNBA Players",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion",
 h1("Conclusions of NBA vs WNBA Salary Differences"),
 p("Based on our three tabs with different information about comparing various aspects of players from both leagues and their salaries, we found that there is gender-based discrimination in the pay gap.
 The first tab shows the gender wage gap, comparing the pay disparity between the NBA and WNBA. It questions whether top earners continue to dominate and if predictions about player salaries can be made. 
 It also considers how major corporations can help close the gender wage gap within the sports industry. The text emphasizes the importance of addressing gender discrimination in the workplace,
 highlighting professional sports as a significant arena where such disparities exist. It questions the fairness of male basketball players earning significantly more than their female counterparts.
 The second tab examines the relationship between the number of games played by NBA and WNBA players and their salaries. It implies that playing statistics could impact player earnings, as more games usually indicate higher performance. However, despite NBA players playing more games than WNBA players, the analysis reveals a substantial pay gap between the two leagues, even when players have similar playing time. This discrepancy highlights the challenges encountered by professional female basketball players, who face fewer playing opportunities and receive considerably lower pay compared to male players.
 The third tab shows us a bar graph that compares in-game averages from an NBA player and a WNBA player. This tab, in addition to the second tab, allows us to visualize how player stats may compare to their salary.

   We looked accross the players stats and their athletic ability and even though the NBA players beat out the WNBA players in some aspects, like the number of games played, there is still a large pay gap that is not justified by the small difference in stats.
   It is important to look at various data based on gender discrimination because on platforms as big as the NBA and WNBA, there is still a great deal of bias and inequality.")
)



ui <- fluidPage(theme = shinytheme("united"),
                navbarPage("NBA vs. WNBA",
                overview_tab,
                viz_1_tab,
                viz_2_tab,
                viz_3_tab,
                conclusion_tab
      )
)
