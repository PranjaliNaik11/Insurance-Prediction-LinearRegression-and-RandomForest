Data <- read.csv(file="insurance.csv", header=TRUE, sep=",")
Data
sample_size <- round(0.8 * nrow(Data))
train_ind <- sample(1:nrow(Data), sample_size)
data_train <- Data[train_ind, ]
data_test <- Data[-train_ind, ]
model_a <- lm(charges ~ age + sex + bmi + children + smoker + region, data = data_train)
summary(model_a)
#Saving R-squared
r_sq_a <- summary(model_a)$r.squared
#predict data on test set
prediction_a <- predict(model_a, newdata = data_test)
#calculating the residuals
residuals_a <- data_test$charges - prediction_a
#calculating Root Mean Squared Error
rmse_a <- sqrt(mean(residuals_a^2))
model_b <- lm(charges ~ age + bmi + children + smoker + region, data = data_train)
summary(model_b)
r_sq_b <- summary(model_b)$r.squared
prediction_b <- predict(model_b, newdata = data_test)
residuals_b <- data_test$charges - prediction_b
rmse_b <- sqrt(mean(residuals_b^2))
print(paste0("R-squared for first model:", round(r_sq_a, 4)))
print(paste0("R-squared for new model: ", round(r_sq_b, 4)))
print(paste0("RMSE for first model: ", round(rmse_a, 2)))
print(paste0("RMSE for new model: ", round(rmse_b, 2)))
Bob <- data.frame(age = 19,
                  bmi = 27.9,
                  children = 0,
                  smoker = "yes",
                  region = "northwest")
print(paste0("Health care charges for Bob: ", round(predict(model_b, Bob), 2)))
Lisa <- data.frame(age = 40,
                   bmi = 50,
                   children = 2,
                   smoker = "no",
                   region = "southeast")
print(paste0("Health care charges for Lisa: ", round(predict(model_b, Lisa), 2)))
John <- data.frame(age = 30,
                   bmi = 31.2,
                   children = 0,
                   smoker = "no",
                   region = "northeast")
print(paste0("Health care charges for John: ", round(predict(model_b, John), 2)))

library(randomForest)
predict_rf = randomForest(x = data_train[,1:6],y = data_train$charges,ntree = 100,importance = T)
summary(predict_rf)
output.forest <- randomForest(smoker~., data = data_train)
# View the forest results.
print(output.forest) 
print(importance(output.forest,type = 2)) 
pred2 = predict(predict_rf,newdata = data_test[,1:6])
varimp <- data.frame(predict_rf$importance)
varimp

library(ggplot2)
ggplot(varimp, aes(x=reorder(rownames(varimp),IncNodePurity), y=IncNodePurity)) +
  geom_bar(stat="identity", fill="blue", colour="black") + theme_bw(base_size = 8) +
  labs(title="Prediction using RandomForest with 100 trees", subtitle="Variable importance (IncNodePurity)", x="Variable", y="Variable importance (IncNodePurity)")

ggplot(data_test)+  geom_jitter(aes(x=age , y = charges))+geom_smooth(aes(x=age , y  = pred2))

library(ggplot2)
library(dplyr)
library(Hmisc)
library(cowplot)
#library(WVPlots)
set.seed(123)
x <- ggplot(Data, aes(age, charges)) +
  geom_smooth(color = "red", alpha = 0.5) +
  theme_light()
y <- ggplot(Data, aes(bmi, charges)) +
  geom_jitter(color = "blue", alpha = 0.5) +
  theme_light()
p <- plot_grid(x, y) 
title <- ggdraw() + draw_label("1. Correlation between Charges and Age / BMI", fontface='bold')
plot_grid(title, p, ncol=1, rel_heights=c(0.1, 1))

x <- ggplot(Data, aes(smoker, charges)) +
  geom_jitter(aes(color = smoker), alpha = 0.7) +
  theme_light()
y <- ggplot(Data, aes(region, charges)) +
  geom_jitter(aes(color = region), alpha = 0.7) +
  theme_light()
p <- plot_grid(x, y) 
title <- ggdraw() + draw_label("3. Correlation between Charges and Smoker / Region", fontface='bold')
plot_grid(title, p, ncol=1, rel_heights=c(0.1, 1))

x <- ggplot(Data, aes(smoker, charges)) +
  geom_jitter(aes(color = smoker), alpha = 0.7) +
  theme_light()
y <- ggplot(Data, aes(region, charges)) +
  geom_jitter(aes(color = region), alpha = 0.7) +
  theme_light()
p <- plot_grid(x, y) 
title <- ggdraw() + draw_label("3. Correlation between Charges and Smoker / Region", fontface='bold')
plot_grid(title, p, ncol=1, rel_heights=c(0.1, 1))
