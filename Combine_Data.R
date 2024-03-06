# Nathan, Joey, Makayla, Nowali
# testing

library(dplyr)

wnba_2022 <- read.csv("2022_WNBA_stats.csv", na.strings = "--")
wnba_2022 <- wnba_2022 %>%
  mutate(Player = str_c(word(Player, 1), word(Player, 2), sep = " "))

nba_2022_2023 <- read.csv("NBA_Player_Salaries.csv")

#categorical var
wnba_2022 <- 
  wnba_2022 %>%
  mutate(Is_NBA = 0)
write.csv(wnba_2022, "wnba_2022.csv")

nba_2022_2023 <- 
  nba_2022_2023 %>%
  mutate(Is_NBA = 1)
write.csv(nba_2022_2023, "nba_2022_2023.csv")


wnba_nba <- full_join(nba_2022_2023, wnba_2022, by = c("Player.Name" = "Player", 
                                                       "Salary" = "X2022.Salary",
                                                       "GP" = "G", #games played
                                                       "GS" = "GS", #games started
                                                       "MP" = "MIN", #minutes per game
                                                       "FG" = "FGM", #field goals
                                                       "FGA" = "FGA", #field goals attempted
                                                       "Is_NBA"))

wnba_nba <- wnba_nba %>%
  mutate(X3PA = coalesce(X3PA.x, X3PA.y),
         X3P = coalesce(X3P, X3PM),
         X2P = coalesce(X2P, X2PM),
         X2PA = coalesce(X2PA.x, X2PA.y),
         FT = coalesce(FT, FTM),
         FTA = coalesce(FTA.x, FTA.y),
         ORB = coalesce(ORB.x, ORB.y),
         DRB = coalesce(DRB.x, DRB.y),
         TRB = coalesce(TRB.x, TRB.y),
         AST = coalesce(AST.x, AST.y),
         STL = coalesce(STL.x, STL.y),
         BLK = coalesce(BLK.x, BLK.y),
         TOV = coalesce(TOV.x, TOV.y),
         PF = coalesce(PF.x, PF.y)
  ) %>%
  select(-X3PA.x, -X3PA.y, -X3PM, -X2PM, -X2PA.x, -X2PA.y, -FTM, -ORB.x, -ORB.y, -DRB.x, -DRB.y, -TRB.x, 
         -TRB.y, -AST.x, -AST.y, -STL.x, -STL.y, -BLK.x, -BLK.y, -TOV.x, -TOV.y, -PF.x, -PF.y) %>%
  rename("Games Played" = "GP",
         "Games Started" = "GS",
         "Minutes Played" = "MP",
         "Field Goals Made" = "FG",
         "Field Goals Attempted" = "FGA",
         "3-Pointers Made" = "X3P",
         "3-Pointers Attempted" = "X3PA",
         "2-Pointers Made" = "X2P",
         "2-Pointers Attempted" = "X2PA",
         "Free-Throws Made" = "FT",
         "Free-Throws Attempted" = "FTA",
         "Offensive Rebounds" = "ORB",
         "Defensive Rebounds" = "DRB",
         "Total Rebounds" = "TRB",
         "Assists" = "AST",
         "Steals" = "STL",
         "Blocks" = "BLK",
         "Turnovers" = "TOV",
         "Personal Fouls" = "PF"
  )

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


