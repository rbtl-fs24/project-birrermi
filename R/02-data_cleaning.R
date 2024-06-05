library(tidyverse)
library(dplyr)

#import data
survey_processed <- survey_raw <- read.csv("data/raw/survey_raw.csv")

#rename columns
survey_processed <- survey_processed |> 
  rename(purpose = On.what.purpose.are.you.regularly.visiting.the.ETH.Campus.,
         enrollment_status = What.is.your.enrollment.status.at.ETH..  ,
         department = In.which.department.do.you.study.. ,
         work_status = What.is.your.job.title.at.ETH..    ,
         visit_status = Why.do.you.visit.the.ETH.Campus.regullarly.  ,
         campus = On.which.campus.do.you.stay.the.most..  ,
         visits_per_week = How.many.days.do.you.visit.the.above.choosen.ETH.Campus.per.week..,
         recycling_ETH_Zentrum = Do.you.recycle.on.the.ETH.Zentrum.Campus..  ,
         hindrance_ETH_Zentrum = What.prevents.you.from.recycling.on.campus....10   ,
         recycling_materials_ETH_Zentrum = What.do.you.recycle.on.Campus. ,
         most_recycled_material_ETH_Zentrum = What.do.you.recycle.the.most.on.campus....check.the.answer.on.what.you.recycle.the.most....13    ,
         satisfaction_ETH_Zentrum = How.happy.are.you.with.the.given.recycling.infrastructure.....14   ,
         favourite_spot_ETH_Zentrum = Where.is.your.favourite.most.used.recycling.spot.at.the.ETH.Zentrum.Campus.. ,
         frequency_ETH_Zentrum = How.often.do.you.recycle.on.campus.,
         improvement_ETH_Zentrum = Is.there.something.missing.or.to.be.improved.in.terms.of.the.given.recycling.infrastructure.....16   ,
         recycling_ETH_Hönggerberg = Do.you.recycle.on.the.ETH.Hönggerberg.Campus.  ,
         hindrance_ETH_Hönggerberg = What.prevents.you.from.recycling.on.campus....18  ,
         frequency_ETH_Hönggerberg = How.often.do.you.recycle.on.campus.. ,    
         recycling_materials_ETH_Hönggerberg = What.do.you.recycle.on.campus.  ,
         most_recycled_material_ETH_Hönggerberg = What.do.you.recycle.the.most.on.campus....check.the.answer.on.what.you.recycle.the.most....21 ,
         satisfaction_ETH_Hönggerberg = How.happy.are.you.with.the.given.recycling.infrastructure.....22 ,
         favourite_spot_ETH_Hönggerberg = Where.is.your.favourite.most.used.recycling.spot.at.the.ETH.Hönggerberg.Campus..   ,
         improvement_ETH_Hönggerberg = Is.there.something.missing.or.to.be.improved.in.terms.of.the.given.recycling.infrastructure.....24,
         general_remarks = You.answered.all.necessary.questions..Thanks.for.your.time..and.participation..If.there.is.anything.you.want.to.adress.use.the.box.below.)

#delete general_remarks column         
survey_processed <- survey_processed |> 
  select(-general_remarks)

#reorder table
survey_processed <- survey_processed |> 
  relocate(campus, .before = purpose)
survey_processed <-  survey_processed |> 
  arrange(campus,
          purpose,
          enrollment_status)

#add ID
survey_processed <-  survey_processed |> 
  mutate(ID = seq(1:n())) 
survey_processed <-  survey_processed |> 
  relocate(ID, .before = campus)

#ID 3 and 4 work as phd move to study as phd
survey_processed$purpose[survey_processed$ID == 3] <- "Study"
survey_processed$enrollment_status[survey_processed$ID == 3] <- "Phd"
survey_processed$purpose[survey_processed$ID == 4] <- "Study"
survey_processed$enrollment_status[survey_processed$ID == 4] <- "Phd"

#changin aluminum, aluminum cans, alu to just ALU
survey_processed <- survey_processed |> 
  mutate(most_recycled_material_ETH_Zentrum = gsub("^alu\\w*", "ALU", most_recycled_material_ETH_Zentrum, ignore.case = TRUE))
survey_processed <- survey_processed |> 
  mutate(most_recycled_material_ETH_Zentrum = gsub("^ALU cans\\w*", "ALU", most_recycled_material_ETH_Zentrum, ignore.case = TRUE))
survey_processed <- survey_processed |> 
  mutate(most_recycled_material_ETH_Zentrum = na_if(most_recycled_material_ETH_Zentrum, "this is to see if longer answers are accepted, also, 14"))
write_csv(survey_processed, "data/processed/survey_processed.csv" )


