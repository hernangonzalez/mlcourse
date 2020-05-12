# Data Preprocessing
setwd("~/Projects/hernan/ml/random_forest_regression")

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Split Train and test set
# Not doing it cause dataset is too small

# Fit the regressor
# install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor = randomForest(x = dataset[1],
                         y = dataset$Salary,
                         ntree = 500)

# Predict linear
y_pred = predict(regressor, data.frame(Level = 6.5))

# Increase dataset for visualization
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
pred_poly = predict(regressor, 
                    newdata = data.frame(Level = x_grid))

# Visualize 
library(ggplot2)
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') + 
  geom_line(aes(x = x_grid, y = pred_poly), 
            colour = 'blue') +
  ggtitle('Level vs Salary') +
  xlab('Level') +
  ylab('Salary')