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
           h3("Select Number"),
           sliderInput("GP", "Number of Games Played",
                      min = 0, max = 100, value = 50, step = 1)))
  ),
h1("Explanation for Graph"),
p("By looking at the number of games that players from both the NBA and WNBA play, this will give us some idea of whether or not meaninful playing statistics are a factor in determining the wage for players. In theory, the more games a player has played, the higher their salary as they are performing well for their team.
  As we can see from the graph, even though WNBA players play significantly more than NBA players, it is important to recognize the difference in pay when a WNBA and an NBA player play the same amounts of games. There is a significant difference, by thousands and thousands of dollars, by which each player gets paid.
  This adds to our research as it shows the disadvantages professional women basketball players face in their field. They don't get nearly as much playing time as NBA players, and when they do, they are paid significantly less.")
)

viz_1_main_panel <- mainPanel(
  h2("Comparing Number of Games Played and Salary"),
  plotlyOutput(outputId = "salary_games_played"))

viz_1_tab <- tabPanel("Comparing Number of Games Played and Salary",
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
  h2("NBA and WNBA player average stats from 2022 season"),
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
 h1("Our Conclusions"),
 p("Based on the data that we have found by comparing various WNBA and NBA stats, it is clear that there is blatant discrimination against the WNBA player salaries. When comparing the statisics of each player, it clear that players from both leagues are remarkably talented in their field and deserve to be compensated.
   Though the data revealed that the players do not all play equally, that does not mean that a NBA player is justified in making thousands and thousands more than a WNBA player. 
 To go more into depth on each discover that we have found, the first tab in our website showed the relationship between the number of games each player played and their salaries. We decided to compare these two stats in order to demonstrate a nongender based statistic such as games played to see if there is room for the pay gap to be justified between WNBA and NBA players based on real statistics.
It can be argued that because NBA players play more games that they are justified in being compensated so much more money, but the difference in pay is simply unreasonable. As most NBA players play in double or triple the games as WNBA players, it could be justified that their compensation would be double or triple, but instead we see that NBA players salaries outnumber WNBA salaries by up to one thousand percent. This means the average NBA player makes ten times as much as a WNBA player makes. 
  ")
)



ui <- navbarPage("WNBA v.s. NBA",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)
