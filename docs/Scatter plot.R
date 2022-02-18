vaccines <- read.csv("https://data.chhs.ca.gov/dataset/e283ee5a-cf18-4f20-a92c-ee94a2866ccd/resource/130d7ba2-b6eb-438d-a412-741bde207e1c/download/covid19vaccinesbycounty.csv")


library(ggplot2)
#library("dplyr")
#library("tidyr")

#scatter plots
# Moderna vs pfizer
ggplot(vaccines, aes(x=pfizer_doses, y=moderna_doses)) + 
  geom_point() +
  geom_smooth() +
  labs(title = "Moderna vs Pfizer")

#Moderna vs JJ
ggplot(vaccines, aes(x=moderna_doses, y=jj_doses)) + 
  geom_point() +
  geom_smooth() +
  labs(title = "JJ vs Moderna")

#JJ vs Pfizer
ggplot(vaccines, aes(x=pfizer_doses, y=jj_doses)) + 
  geom_point() +
  geom_smooth()+
  labs(title = "JJ vs Pfizer")




#booster
# Pfizer vs booster
ggplot(vaccines, aes(x=booster_recip_count, y=pfizer_doses)) + 
  geom_point() +
  geom_smooth() +
  labs(title = "booster vs Pfizer")

# I created this graph to find the relationship between the number of people who got pfizer and the number of people who got booster shot.
# it reveals that there are a lot of people who got pfizer but not the booster
# people considering getting pfizer is effective because the line
# increases positively 

# moderna vs booster
ggplot(vaccines, aes(x=booster_recicdp_count, y= moderna_doses),
       color = ("#668684") + 
         geom_point() +
         geom_smooth() +
         labs(title = "booster vs Moderna")
       
       #jj vs booster
       ggplot(vaccines, aes(x= booster_recip_count, y=jj_doses)) + 
         geom_point() +
         geom_smooth() +
         labs(title = "booster vs JJ")
       