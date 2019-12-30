# Data Preprocessing
setwd("~/Projects/hernan/ml/multiple_linear_regression")

# Importing the dataset
dataset = read.csv('50_Startups.csv')

# Encoding categories (dummy)
dataset$State = factor(dataset$State, 
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Split Train and test set
#install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
train_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fit Regressor with training set
regressor = lm(formula = Profit ~ ., # `.` indicates that it should use all the independent variables. 
               data = train_set)

# Predictions
pred_test = predict(regressor, newdata = test_set)

# Backward elimination
# Use the whole dataset to improve the analysis on statistic impact of the independent variables
regressor = lm(formula = Profit ~ (R.D.Spend + Marketing.Spend),
               data = dataset)
summary(regressor)

