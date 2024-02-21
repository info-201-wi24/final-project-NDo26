# Nathan, Joey, Makayla, Nowali
# testing

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


wnba_nba <- full_join(nba_2022_2023, wnba_2022, by = c("Player.Name" = "Player", 
                                                       "Salary" = "X2022.Salary",
                                                       "GP" = "G", #games played
                                                       "GS" = "GS", #games started
                                                       "MP" = "MIN", #minutes per game
                                                       "FG" = "FGM", #field goals
                                                       "FGA" = "FGA", #field goals attempted
                                                       "Is_NBA"))  

# average salary overall
average_salary_wnba <- mean(wnba_2022$X2022.Salary, na.rm = TRUE)
average_salary_nba <- mean(nba_2022_2023$Salary, na.rm = TRUE)

average_salary_overall <- average_salary_wnba + average_salary_nba / 2


#summarization df: average salary for nba and wnba 
avg_salary <- tibble(
  Organization = c("NBA", "WNBA"),
  average_salary = c(average_salary_nba, average_salary_wnba)
)

write.csv(wnba_nba, "wnba_nba_data.csv")
