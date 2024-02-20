# Nathan, Joey, Makayla, Nowali

library(dplyr)

wnba_2022 <- read.csv("2022_WNBA_stats.csv", na.strings = "--")
nba_2022_2023 <- read.csv("NBA_Player_Salaries.csv")

#categorical var

wnba_2022 <- 
  wnba_2022 %>%
  mutate(Is_NBA = 0)

nba_2022_2023 <- 
  nba_2022_2023 %>%
  mutate(Is_NBA = 1)

#merge but i think we can clean this up better

wnba_nba <- full_join(nba_2022_2023, wnba_2022, by = c("Player.Name" = "Player", 
                                                       "Salary" = "X2022.Salary",
                                                       "GP" = "G", #games played
                                                       "GS" = "GS", #games started
                                                       "MP" = "MIN", #minutes per game
                                                       "FG" = "FGM", #field goals
                                                       "FGA" = "FGA", #field goals attempted
                                                       "Is_NBA"))  

#continuous/numerical var: maybe like average salary overall?
average_salary_wnba <- mean(wnba_2022$Salary)
average_salary_nba <- mean(nba_2022_2023$Salary)



#summarization df: average salary for nba and wnba or something like that

