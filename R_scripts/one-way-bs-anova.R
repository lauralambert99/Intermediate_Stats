#Load the data
bugs <- InsectSprays
  
#Look at the data
head(bugs)


#Call the package
library(psych)
  
#Get the descriptives by group
describeBy(bugs$count, group = bugs$spray)

#Call ggplot
library(ggplot2)
  
#Generate a boxplot
ggplot(data = bugs, aes(x = spray, y = count)) + 
  geom_boxplot() +
  geom_jitter(width = .2)

#Call tidyverse package
library(tidyverse)

#Run the Shapiro-Wilk test
bugs %>%   #Call our dataframe and send it on
  group_by(spray) %>%    #Group by our grouping variable
  summarise("S-W Statistic" = shapiro.test(count)$statistic,   #Give us the statistics we want, in a table
            "p-value" = shapiro.test(count)$p.value)


#Generate side-by-side histograms
ggplot(data = bugs, aes(x = count)) +
  geom_histogram() +
  facet_grid(~ spray) +
  theme_minimal()

#Call qqplotr
library(qqplotr)

#Call viridis
library(viridis)

#Perform QQ plots by group
ggplot(data = bugs, mapping = aes(sample = count, color = spray, fill = spray)) +
  stat_qq_band(alpha = 0.5, conf = 0.95, bandType = "pointwise") +
  stat_qq_line(identity = TRUE) +
  stat_qq_point(col = "black") +
  facet_wrap(~ spray, scales = "free") +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") + 
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  theme_bw()


#Perform detrended QQ plots by group
ggplot(data = bugs, mapping = aes(sample = count, color = spray, fill = spray)) +
  stat_qq_band(alpha = 0.5, conf = 0.95, bandType = "pointwise", detrend = TRUE) +
  stat_qq_line(identity = TRUE, detrend = TRUE) +
  stat_qq_point(col = "black", detrend = TRUE) +
  facet_wrap(~ spray, scales = "free") +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") + 
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  theme_bw()

#Call the car package
library(car)

#Perform Levene's Test
LT_bugs <- leveneTest(count ~ spray, data=bugs, center="mean")
  
#Perform Brown-Forsythe test
BFT_bugs <- leveneTest(count ~ spray, data=bugs, center="median")
  
#Print both of them
print(LT_bugs)
print(BFT_bugs)

#Using aov
model_b1 <- aov(count ~ spray, data = bugs)

#Get the model summary
summary(model_b1)

#Using lm
model_b2 <- lm(count ~ spray, data = bugs)

#Get the model summary
summary(model_b2)

#Then an anova table for model b2
anova(model_b2)

#Call onewaytests package for Brown-Forsythe test for equal means
library(onewaytests)
  
#Perform the test
bf.test(count ~ spray, data = bugs)
  
#Perform Welch's test for equal means
oneway.test(count ~ spray, data = bugs, var.equal = FALSE)


#Load lsr package
library(lsr)
  
#Calculate eta-squared
etaSquared(model_b1)
etaSquared(model_b2)
  

#Call emmeans package
library(emmeans)

#Compute expected marginal means post-hoc tests
posthocs <- emmeans(model_b1, pairwise ~ spray, adjust = "bonferroni")
posthocs2 <- emmeans(model_b1, pairwise ~ spray, adjust = "tukey")
posthocs3 <- emmeans(model_b1, pairwise ~ spray, adjust = "scheffe")

#Bonferroni adjustment results
posthocs

#Tukey's HSD adjustment results
  posthocs2
  
  #Scheffe adjustment results
  posthocs3

***JOE SHOULD THIS BE INCLUDED????***

#Bonferroni pairwise comparison
pairwise.t.test(bugs$count, bugs$spray, p.adj = "bonf")

#Tukey's HSD pairwise comparison
  TukeyHSD(model_b1, conf.level = .95)

#Call the DescTools package
library(DescTools)

#Run the Scheffe adjustment pairwise comparison
ScheffeTest(model_b1, g = spray)


#Restate our emmeans model - get rid of pairwise comparisons
b1.emm <- emmeans(model_b1, "spray", data = bugs)

#State the contrasts
plan_con <- contrast(b1.emm, list(c1 = c(1, 0, -0.5, -0.5, 0, 0), c2 = c(0, 1, -1, 0, 0, 0), c3 = c(0.5, 0.5, 0, 0, -0.5, -0.5)))

#Test the contrasts
test(plan_con, adjust = "none")
