# Insurance Data Analysis

## Project Overview

This project involves analyzing insurance data to calculate insurance charges using basic demographic information. The data includes age, sex, BMI, number of children, smoking status, and region. The goal is to create models that predict insurance charges and evaluate their performance using various metrics. Additionally, predictions are made for hypothetical individuals, and the results are visualized using the `ggplot2` package in R.

## Dataset Description:

The dataset consists of the following columns:

- **age**: The age of the individual.
- **sex**: The gender of the individual (male/female).
- **bmi**: Body Mass Index of the individual.
- **children**: The number of children/dependents covered by the insurance.
- **smoker**: Smoking status of the individual (yes/no).
- **region**: The residential region of the individual.
- **charges**: The insurance charges billed to the individual (target variable).

## Analysis Steps

### 1. Linear Regression Model

#### Model 1: All Variables

- **Predictors**: age, sex, bmi, children, smoker, region.
- **Target**: charges.

**Steps**:
1. Create a linear regression model using all the predictor variables.
2. Calculate the R-squared value and store it in a variable.
3. Predict charges on the test set.
4. Calculate residuals and the Root Mean Squared Error (RMSE).

#### Model 2: Selected Variables

- **Predictors**: age, bmi, children, smoker, region.
- **Target**: charges.

**Steps**:
1. Create a linear regression model using the selected predictor variables.
2. Calculate the R-squared value and store it in a variable.
3. Predict charges on the test set.
4. Calculate residuals and the Root Mean Squared Error (RMSE).

### 2. Predictions for Hypothetical Individuals

Predict insurance charges for three hypothetical individuals (Bob, John, and Lisa) using the linear regression model.

### 3. Random Forest Model

- **Predictors**: age, sex, bmi, children, smoker, region.
- **Target**: charges.

**Steps**:
1. Install and load the `randomForest` package.
2. Fit a Random Forest model with 100 trees.
3. Predict insurance charges.
4. Plot the model using the `ggplot2` package.

### 4. Data Visualization

Create various plots to visualize the relationship between insurance charges and different variables.

**Plots**:
1. Correlation between Charges and Age / BMI
    ```R
    library(ggplot2)
    library(cowplot)
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
    ```

2. Correlation between Charges and Smoker / Region
    ```R
    x <- ggplot(Data, aes(smoker, charges)) +
      geom_jitter(aes(color = smoker), alpha = 0.7) +
      theme_light()
    
    y <- ggplot(Data, aes(region, charges)) +
      geom_jitter(aes(color = region), alpha = 0.7) +
      theme_light()
    
    p <- plot_grid(x, y) 
    title <- ggdraw() + draw_label("3. Correlation between Charges and Smoker / Region", fontface='bold')
    plot_grid(title, p, ncol=1, rel_heights=c(0.1, 1))
    ```

## How to Run the Project

1. Ensure you have the necessary libraries installed:
    ```R
    install.packages(c("ggplot2", "dplyr", "Hmisc", "cowplot", "randomForest"))
    ```

2. Load the dataset `insurance_data.csv` into R.

3. Preprocess the data if necessary (e.g., handle missing values, encode categorical variables).

4. Fit the linear regression models and calculate the R-squared values, residuals, and RMSE.

5. Make predictions for the hypothetical individuals (Bob, John, Lisa).

6. Fit the Random Forest model and make predictions.

7. Create the visualizations using the provided `ggplot2` code snippets.
