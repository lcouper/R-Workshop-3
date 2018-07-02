### Workshop 3 Notes ####

# Today we will cover: 1) basic statistics and 2) plotting 


### 1: Statistics #####
# We've previously worked through examples of calculating descriptive statistics
# like the mean, range, etc on whole data & subsets of data
# There are many, many tools for statistical analysis either within base R or contained in other packages 
# Some examples include: 
# Chi-squared, fisher's exact test, correlations, t-tests, non-parametric stats, 
# multiple regression, cross-validation, variable selection, outlier detection
# ANOVAs, power calculations

#### ANOVA Example ####

View(ChickWeight)
# You have info on the weights of chicks on different diets (1-4)
# You want to see if there's a mean difference in chick weight based on diet
# This can be tested statistically using an ANOVA function executed through the "aov" function in base R

# If you wanted to check the assumptions of equal variance - you could run:
aggregate(ChickWeight$weight ~ ChickWeight$Diet, FUN = var)

# Assuming your data are appropriate for ANOVA:
fit = aov(ChickWeight$weight ~ ChickWeight$Diet)
# aov is the name of the function that fits an analysis of variance model
# The first argument is the dependent or outcome variable
# The second argument, after the ~, is the independent variable
# To see the results of this model fit:
summary(fit)

# Another way you could have coded this:
fit = aov(weight ~ Diet, data = ChickWeight)

#### Multiple regression Example ####

# Will be using the mtcars dataset (info about fuel consumption & other features of cars for 32 cars)
View(mtcars)

# Want to create a model to understand how different car features affect the fuel consumption
# You have prior knowledge that displacement, horsepower, weight and 1/4 mile time are related to fuel consumption

model = lm(mpg ~ disp + hp + wt + qsec, data = mtcars)

# lm is the function used to fit linear models (with single or multiple explanatory variables)
# Again the left most argument is the outcome variable and the variables after the '~' are the explanatory variables

# Use the summary command to inspect the model output
summary(model)
# We can see we get estimates of the coefficients, pvalues, info about the R^2, etc.

# But we're not sure this is the best model... want to do variable selection to figure this out
# Can do this using tools in the "MASS" package which you may have already installed
# install.packages("MASS")
library(MASS)

step.model = stepAIC(model, direction = "both")
# The stepAIC function provides step-wise variable selection
# If the AIC of the new model (after adding or removing variables) is lower, it keeps going in that direction

# Look at the output of this model selection process by again using the summary tool
summary(step.model)

# Can also examine the appropriateness of the model by looking at residuals:
plot(step.model)
# If you wanted to compare AIC of your original model to your new model from variable selection

AIC(model)
AIC(step.model)
BIC(model)
BIC(step.model)

# If we had data about some new car that's being made and we wanted to predict their gas mileage,
# we can do that using this model output
# Example new data:

HondaRoadster = c(145, 2.7) # horse-power and weight
VolvoP1900 = c(150, 4.2)
NewCars = as.data.frame(rbind(HondaRoadster, VolvoP1900))
colnames(NewCars) = c("hp", "wt")
View(NewCars)

# Now use the predict.lm function to predict the mpg based on the known horsepower and weight
predict.lm(step.model, NewCars)
# Obtain predicted values for mpg based on inputs

#### Plotting ####

# Similar to the stats, there are MANY types of plots we can create in R
# Examples include:
# boxplots, scatterplots, piecharts, histograms, linecharts, etc

# Again, we'll just go through a couple basic plottings examples so you get the feel for how these functions work
# and see what arguments you can pass to the plot commands

#### Boxplot Example ####
# We'll go back to the ChickWeight example from above
# Let's say in addition to running the ANOVA, we'd like to visualize differences
# in chick weight based on their diet
# We can do this by creating a boxplot 

boxplot(ChickWeight$weight ~ ChickWeight$Diet)
# Notice that the arguments are structured similarly to the ANOVA

# Let's spruce up this plot!

boxplot(weight ~ Diet, data = ChickWeight,
        main = "Chick weight based on diet",    # Adds a tile
        col = c("red", "green", "blue", "yellow"),   # Adds color
        ylim = c(0, 400),  # Adds y-axis bounds (xlim does the same for x-axis)
        xlab = "Chick diet 1-4",   
        ylab = "Chick weight in g")

### Scatterplot Example ####

plot(mpg ~ wt, data = mtcars)

# Again, spruce it up
plot(mpg ~ wt, data = mtcars,
     main = "Mpg based on car weight",
     col = "black",   # Lots of color options in R -- can google to find others
     pch = 16,    # changes the plotting "symbol"
     xlab = "Car Weight (1000 lbs)",
     ylab = "Miles per gallon")

# We can also add a line of best fit based on our model call
Model2= lm(mpg~ wt, data = mtcars)
abline(Model2, col = "red")  # abline functino adds straight lines to plot
text(x = 4.8, y= 31.6, labels = "R2 = 0.753")  # add text

### ggplot ####

# There is another method for plotting -- ggplot

# install.packages("ggplot2")
library(ggplot2)

ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point(size=4, shape= 1, col = "darkred") + 
#geom_text(label=rownames(mtcars)) + 
  geom_smooth(method=lm, se = FALSE, linetype = "dashed")





