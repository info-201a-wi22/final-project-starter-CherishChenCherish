vaccines <- read.csv("https://data.chhs.ca.gov/dataset/e283ee5a-cf18-4f20-a92c-ee94a2866ccd/resource/130d7ba2-b6eb-438d-a412-741bde207e1c/download/covid19vaccinesbycounty.csv")

library(ggplot2)

#booster
# Pfizer vs booster
Pfizer_booster <-ggplot(vaccines, aes(x=booster_recip_count, y=pfizer_doses)) +
  geom_point() +
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE) +
  labs(title = "booster vs Pfizer")

# moderna vs booster
moderna_booster <- ggplot(vaccines, aes(x=booster_recip_count, y= moderna_doses)) +
                            geom_point() +
                            geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE) +
                            labs(title = "booster vs Moderna")
       
#jj vs booster
jj_booster <- ggplot(vaccines, aes(x= booster_recip_count, y=jj_doses)) + 
  geom_point() +
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE) +
  labs(title = "booster vs JJ")
# I created this graph to find the relationship between the number of people who got pfizer and the number of people who got booster shot.
# it reveals that there are a lot of people who got pfizer but not the booster
# people considering getting pfizer is effective because the line
# increases positively 


title <- ggdraw() + draw_label("Vaccines vs Booster shot", fontface='bold')
bottom_row <- plot_grid(Pfizer_booster, moderna_booster, ncol = 2, labels = "AUTO")
plot_grid(title, bottom_row, jj_booster, nrow = 3, labels = c("", "", "C"),
          rel_heights = c(0.2, 1, 1))

