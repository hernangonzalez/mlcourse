# Data Preprocessing
setwd("~/Projects/hernan/ml/simple linear regression")

# Importing the dataset
dataset = read.csv('Salary_Data.csv')

# Split Train and test set
#install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
train_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fit SL Regressor with training set
regressor = lm(formula = Salary ~ YearsExperience, 
               data = train_set)

#Coefficients:
#                Estimate Std. Error t value Pr(>|t|)    
#(Intercept)        25592       2646   9.672 1.49e-08 ***   
#YearsExperience     9365        421  22.245 1.52e-14 ***
# *** means it is highly significant
# p(1...5) means highly significant 

# Predict test results
pred_test = predict(regressor, newdata = test_set)
pred_train = predict(regressor, newdata = train_set)

# Visualization 
#install.packages('ggplot2')
library(ggplot2)
ggplot() + 
  geom_point(aes(x = train_set$YearsExperience, y = train_set$Salary), 
             colour = 'red') + 
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary), 
             colour = 'green') + 
  geom_line(aes(x = train_set$YearsExperience, y = pred_train), 
              colour = 'blue') +
  ggtitle('Salary vs Experience') +
  xlab('Years of experience') +
  ylab('Salary')
