# Data Preprocessing
setwd("~/Projects/hernan/ml/polinomial_linear_regression")

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Split Train and test set
# Not doing it cause dataset is too small

# Linear regression (to compare)
linear_regressor = lm(formula = Salary ~ ., 
                      data = dataset)
summary(linear_regressor)

# Polinomial regression
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
polinomial_regressor = lm(formula = Salary ~ ., 
                          data = dataset)
summary(polinomial_regressor)

# Increase dataset for visualization
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)


# Visualize linear
library(ggplot2)
pred_linear = predict(linear_regressor, newdata = data.frame(Level = x_grid))
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') + 
  geom_line(aes(x = x_grid, y = pred_linear), 
            colour = 'blue') +
  ggtitle('Level vs Salary') +
  xlab('Level') +
  ylab('Salary')

# Visualize polinomial
pred_poly = predict(polinomial_regressor, 
                    newdata = data.frame(Level = x_grid, 
                                         Level2 = x_grid ^ 2,
                                         Level3 = x_grid ^ 3,
                                         Level4 = x_grid ^ 4))
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary), 
             colour = 'red') + 
  geom_line(aes(x = x_grid, y = pred_poly), 
            colour = 'blue') +
  ggtitle('Level vs Salary') +
  xlab('Level') +
  ylab('Salary')

# Predict linear
y_pred = predict(linear_regressor, data.frame(Level = 6.5))

# Predict Poly
y_pred2 = predict(polinomial_regressor, 
                  newdata = data.frame(Level = 6.5, 
                                       Level2 = 6.5^2,
                                       Level3 = 6.5^3,
                                       Level4 = 6.5^4))
