# Data Preprocessing
setwd("~/Projects/hernan/ml/decision_tree_regression")

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Split Train and test set
# Not doing it cause dataset is too small

# Fit the regressor
#install.packages('e1071')
library(rpart)
regressor = rpart(formula = Salary ~ Level, 
                  data = dataset,
                  control = rpart.control(minsplit = 0.1))

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