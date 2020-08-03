library(dplyr)
library(scales)
library(ggplot2)
library(magrittr)
houseSale <- read.csv("data/Kaggle_HouseSale_train.csv", stringsAsFactors = F)
table(houseSale$OverallQual)

#kaggle data 
plotData <-
  houseSale %>% 
  mutate(OverallQual_factor = factor(ifelse(OverallQual < 5 ,
                                     'lower',
                                     ifelse(OverallQual >= 7.5 , 
                                            'higher',
                                            'middle')),
                                     levels = c('lower','middle','higher'))
         ) %>%
  select(OverallQual,OverallQual_factor)
#arrange second label dataframe xmin xmax ymin ymax label 
round(max(table(plotData$OverallQual)),-1)
#400
secLabelData <- 
  plotData %>%
  group_by(OverallQual_factor) %>% 
  summarise(rect_xmax = max(OverallQual) + 0.5,
            rect_xmin = min(OverallQual) - 0.5) %>%
  mutate(rect_ymax = -75,rect_ymin = -50,
         label = as.character(OverallQual_factor),
         label_x = (rect_xmax + rect_xmin)/2,
         label_y = (rect_ymax + rect_ymin)/2,
         fill_color = hue_pal()(3))
  
  

plotData %>%
  ggplot() +
  geom_bar(aes(x = as.factor(OverallQual),
               fill = OverallQual_factor),
           show.legend = F) + 
  geom_rect(data = secLabelData,
            aes(xmin = rect_xmin, xmax = rect_xmax, 
                ymin = rect_ymin, ymax = rect_ymax),
            fill = secLabelData$fill_color) +
  geom_text(data = secLabelData,
            aes(x = label_x,
                y = label_y,
                label = label)) +
  coord_cartesian(ylim = c(0, 400), clip = "off") +
  scale_x_discrete(expand = c(0.01, 0.01)) +
  labs(x = '') + 
  theme_bw() +
  theme(plot.margin = unit(c(1,1,3,1), "lines"))

#hue_pal()(3) ggplot調色盤 第二個為n個數