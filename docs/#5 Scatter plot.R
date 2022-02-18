vaccines <- read.csv("https://data.chhs.ca.gov/dataset/e283ee5a-cf18-4f20-a92c-ee94a2866ccd/resource/130d7ba2-b6eb-438d-a412-741bde207e1c/download/covid19vaccinesbycounty.csv")

#install.packages("cowplot")
library(ggplot2)
library(cowplot)

#scatter plots
# Moderna vs pfizer
as <-ggplot(vaccines, aes(x=pfizer_doses, y=moderna_doses)) + 
  geom_point() +
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE) +
  labs(title = "Moderna vs Pfizer")

#Moderna vs JJ
ak <- ggplot(vaccines, aes(x=moderna_doses, y=jj_doses)) + 
  geom_point() +
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE) +
  labs(title = "JJ vs Moderna")

#JJ vs Pfizer
sd <- ggplot(vaccines, aes(x=pfizer_doses, y=jj_doses)) + 
  geom_point() +
  geom_smooth(method = lm, formula = y ~ splines::bs(x, 3), se = FALSE)+
  labs(title = "JJ vs Pfizer") 

title <- ggdraw() + draw_label("Relationship between Vaccines", fontface='bold')
bottom_row <- plot_grid(sd, ak, ncol = 2, labels = "AUTO")
plot_grid(title, bottom_row, as, nrow = 3, labels = c("", "", "C"),
          rel_heights = c(0.2, 1, 1))
