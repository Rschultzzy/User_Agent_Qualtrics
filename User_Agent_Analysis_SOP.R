#Load relevant packages
library(readxl)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(stringr)

#Upload Data
SOP_2024_UserAgent <- read_excel("C:/Users/rs136595/Downloads/SOP_2024_UserAgent.xlsx")
head(SOP_2024_UserAgent)

#Rename DF for easier recall & to not overwrite
SOP <-SOP_2024_UserAgent

#Table
table(SOP$Race)
table(SOP$Age)
table(SOP$Gender)
table(SOP$UserAgent)

#Count UserAgent Type
sum(str_count(SOP$UserAgent, "CPU iPhone")) #49
## note: Just using iPhone will count 2x per line as it counts the system and the device
sum(str_count(SOP$UserAgent, "iPad")) #4
sum(str_count(SOP$UserAgent, "Android")) #8
sum(str_count(SOP$UserAgent, "Macintosh")) #12
sum(str_count(SOP$UserAgent, "NodeJS")) #143
sum(str_count(SOP$UserAgent, "Windows NT")) #165

#Recode userAgent Variable
SOP <- SOP %>%
  mutate(
    label = case_when(
      str_detect(UserAgent, "CPU iPhone") ~ "iPhone",
      str_detect(UserAgent, "iPad") ~ "iPad",
      str_detect(UserAgent, "Android") ~ "Android",
      str_detect(UserAgent, "Macintosh") ~ "Desktop",
      str_detect(UserAgent, "Windows NT") ~ "Desktop",
      str_detect(UserAgent, "NodeJS") ~ "Unknown",
    )
  )

#Recount new userAgent
Mode <-table(SOP$label, useNA = "always")
prop.table(Mode)