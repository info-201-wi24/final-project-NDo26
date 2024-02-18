# Nathan, Joey, Makayla, Nowali

library(dplyr)

wnba_2022 <- read.csv("2022_WNBA_stats.csv")
nba_2022_2023 <- read.csv("NBA_Player_Salaries.csv")

wnba_2022 <- 
  wnba_2022 %>%
  mutate(Is_NBA = 0)

nba_2022_2023 <- 
  nba_2022_2023 %>%
  mutate(IS_NBA = 1)
