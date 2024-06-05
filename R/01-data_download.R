
library(googlesheets4)
survey_raw <- read_sheet("https://docs.google.com/spreadsheets/d/1s-GSuxvYUEISX1QPgAvRCo_S-S-BqbMllv7SqtLSEUs/edit?resourcekey#gid=943662744")

write_csv(survey_raw, "data/raw/survey_raw.csv" )

