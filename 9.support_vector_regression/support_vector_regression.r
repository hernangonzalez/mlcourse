# Data Preprocessing
setwd("~/Projects/hernan/ml/support_vector_regression")

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Split Train and test set
# Not doing it cause dataset is too small

# Fit the regressor
#install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ ., 
                data = dataset,
                type = 'eps-regression')
summary(regressor)

# Predict linear
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualize 
library(ggplot2)
pred_linear = predict(regressor, newdata = dataset)
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') + 
  geom_line(aes(x = dataset$Level, y = pred_linear), 
            colour = 'blue') +
  ggtitle('Level vs Salary (SVR)') +
  xlab('Level') +
  ylab('Salary')