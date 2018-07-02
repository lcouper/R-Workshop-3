## R Workshop 3 Exercises ##

# 1) 
# Download and import the "TickCounts" csv
# Make sure to specify that this data DOES have row names and column names when you bring it in

# 1.1)
# What class is the "Ticks" data set?
# Make sure it is a data frame before proceeding

# 1.2) 
# Lets do some quick descriptive stats --
# Lets find the average tick, lizard, rat, deer, and mouse counts 
# using a powerful function we haven't talked about yet:

sapply(Ticks[,1:5], FUN = mean)

# What does the sapply function do?
# Modify the above code to also get the range of these counts at each site

# 1.2.1)
# Lets also take a look at the distribution of tick counts
# by creating a histogram of the tick count column

# 1.3) 
# With this dataset, we're curious about what factors relate to the tick counts at a site
# To start, plot the tick counts against the deer counts (a scatterplot)
# Does there appear to be any relationship between these variables?

# 1.4) 
# Lets do the same for the site size (i.e. plot tick counts against site size)
# Create a title for this plot, change the plotting symbols and colors to something different (whatever you want)
# Add a line of best fit to your plot
# Does there appear to be a relationship here?

# 1.5)
# Create a linear model of tick counts starting with the predictor variables:
# site size, host diversity, and lizard counts
# Save this model call into a variable called "model1"
# Examine the output of model1 using the 'summary' function
# How "good" is this model? (A subjective question, but can be answered based on R2, pvalue, plot of residuals, etc)

# 1.6)
# Create a new data frame with just the site size, host diversity, and lizard count info
# using the code below:

Actual = as.data.frame(cbind(Ticks$SiteSize, Ticks$HostDiversity, Ticks$LizardCount))
View(Actual)

# Add the column names "SiteSize", "HostDiversity" and "LizardCount" to this dataset
# It's important to match the case & spacing of the above names in order for the next step to work

# 1.7)
# Now use the "predict.lm" function to get estimated tick counts
# based on the site size, host diversity, and lizard counts for each site
# Store the predicted values in a variable called "PredictTicks"

# 1.8)
# Now plot the actual tick counts against the predicted tick counts (a scatterplot)
# Add a regression line (for a model of actual tick counts against predicted tick counts)
# to this plot in red

# 1.9) 
# Lets measure the difference in the actual tick counts and the predicted tick counts for each site
# Create a new variable called "Diff" which subtracts the Actual from the predicted

# 1.10)
# Use the sort function on the Diff variable to see:
# Which site has the most actual ticks compared to expectations?
# Which site has the fewest actual ticks compared to expections?

# 1.10.1) We'd like to incorporate deer counts into our model.
# Create a new model (call it model2) with the same predictors as before
# but adding in DeerCounts
# Compare the AIC of these 2 models -- which is better?

# 1.11) 
# We'd now like to see if there is a statistical difference in the tick counts
# in the northern vs southern sites
# Split up these two parts of the dataset (using the subsetting commands we learned last week)
# Call one subset "North" and the other "South"

# 1.12)
# Use the "t.test" function to compare tick counts from these two groups
# Hint: the first argument to the t.test function should be the tick count
# column from the North group, and the second argument is the tick count column
# from the South group

# 1.13)
# What are the sample estimates of the mean for each site? 
# Is there a statistical difference in tick counts based on sample location?

# 1.14)
# Instead of breaking apart the data to run the t-test as we've done above,
# we could have also used the code below to achieve the same result:
t.test(Ticks$TickCount ~ Ticks$SiteLocation)
# What would have happened if we had tried to adapt the above code to 
# run a t.test on tick counts based on the rat counts? (i.e. why doesn't this work?)

# 1.15
# We later decided to create categories for the sites based on their relative sizes
# The new data is stored in this vector:
SizeCat = c("Med", "Large", "Med", "Large", "Large", "Large", "Small", "Small", 
            "Med", "Large", "Med", "Med", "Small", "Large", "Small", "Med")

# What class is SizeCat?
# Convert SizeCat to a factor, and overwrite the original vector (i.e save it as SizeCat)

# 1.16
# Now cbind the SizeCat vector onto the Ticks dataframe 
# And store this output in a new data frame called "Ticks2"

# 1.17
# Run an ANOVA to see if host diversity relates to site size based on the new site size category
# Also create a boxplot of host diversity broken down by SizeCat

# 1.17.1
# The mean value for tick counts based on size are:
# 71 at LARGE, 65 at MED, and 41.75 at SMALL
# Create a vector containing these values (e.g. x = c(71, 65, 41.75))
# And create a pie chart displaying this data
# Include a label for each slice indicating the size of the site

# 1.18
# We are curious how the rat counts and mouse counts compare across sites
# Calculate the Pearon's correlation coefficient between these two columns
# (Will probably require googling what function to use unless you are a very good guesser)
# Also calculate the Pearson's correlation between rat counts and deer counts

# 1.19
# We also obtain some historic data about tick counts at these same sites
# This data is stored in the following column:

Counts1998 = c(21, 9, 13, 14, 27, 18, 6, 15, 10, 11, 4, 29, 18, 7, 18, 19)

# Perform a chi-squared test on Counts1998 and the current Tick Counts
# to test if they are different. What does the test output indicate?

# 1.20
# Create side-by-side histograms from the two years using the following code:
par(mfrow = c(1,2))
hist(Counts1998,col = "pink")
hist(Ticks$TickCount, col = "skyblue")

# What did the "par" line do? How do the 2 distributions compare?



# 2) If not doing so already, I encourage you to explore 
# basic stats & plotting on your own data if you have it!

# Otherwise, try loading and exploring an R dataset of your interest
# To pull up the list of available datasets:

data()

# Look through these options and see which interset you. 
# View that dataset
# If the column names are uninformative, you can also google the name of the dataset to get more info
# Get a sense for what type of data you're working with and what types of plots/stats may be useful
# Then try doing some exploratory plotting/ preliminary stats on that dataset
# There are no wrong answers here!


