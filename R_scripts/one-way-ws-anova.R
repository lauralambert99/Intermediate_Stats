#Load packages
library(datarium)
library(tidyverse)
library(psych)
library(ggplot2)
library(qqplotr)
library(viridis)
library(afex)
library(emmeans)

#Assign data set to an object
se <- selfesteem

#See what it looks like
head(se)

#Gather columns t1, t2 and t3 into long format
se_long <- se %>%
  gather(key = "time", value = "score", t1, t2, t3)

#Convert time column to a factor
se_long$time <- as.factor(se_long$time)

#Check work
head(se_long)

#Get descriptive statistics by group
describeBy(se_long$score, se_long$time)

#Generate a boxplot
ggplot(data = se_long, aes(x = time, y = score)) + 
  geom_boxplot() +
  geom_jitter(width = .2)

#Run the Shapiro-Wilk test
se_long %>%   #Call our dataframe and send it on
  group_by(time) %>%    #Group by our grouping variable
  summarise("S-W Statistic" = shapiro.test(score)$statistic,   #Give us the statistics we want, in a table
            "p-value" = shapiro.test(score)$p.value)

#Generate side-by-side histograms
ggplot(data = se_long, aes(x = score)) +
  geom_histogram() +
  facet_grid(~ time) +
  theme_minimal()

#Perform QQ plots by group
ggplot(data = se_long, mapping = aes(sample = score, color = time, fill = time)) +
  stat_qq_band(alpha = 0.5, conf = 0.95, bandType = "pointwise") +
  stat_qq_line(identity = TRUE) +
  stat_qq_point(col = "black") +
  facet_wrap(~ time, scales = "free") +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") + 
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  theme_bw()

#Perform detrended QQ plots by group
ggplot(data = se_long, mapping = aes(sample = score, color = time, fill = time)) +
  stat_qq_band(alpha = 0.5, conf = 0.95, bandType = "pointwise", detrend = TRUE) +
  stat_qq_line(identity = TRUE, detrend = TRUE) +
  stat_qq_point(col = "black", detrend = TRUE) +
  facet_wrap(~ time, scales = "free") +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") + 
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  theme_bw()

#Perform the ANOVA
model_se <- aov_car(score ~ time + Error(id/time), data = se_long)

#Look at the model summary - includes Mauchly test of sphericity
summary(model_se)

#Look at estimated marginal means
#First, run emmeans() 
model_se_em <- emmeans(model_se, pairwise ~ time, adjust = "bonferroni")

#Look at just the estimated means
model_se_em$emmeans

#Plot estimated marginal means
#Plot estimated marginal means
ggplot(data = as.data.frame(model_se_em$emmeans), aes(x = time, y = emmean)) +
  geom_line(group = 1) +
  geom_point()

#Run pairwise comparisons
model_se_em <- emmeans(model_se, pairwise ~ time, adjust = "bonferroni")

#Print results
model_se_em

#Prep for planned contrasts
#Restate our emmeans model - get rid of pairwise comparisons
se.emm <- emmeans(model_se, "time", data = se_long)

#State the contrasts
con_se <- contrast(se.emm, list(se1 = c(0.5, 0.5, -1)))

#Test the contrasts
test(con_se, adjust = "none")

