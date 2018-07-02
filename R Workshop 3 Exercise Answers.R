### R Workshop 3 Exercise Answers ####

# 1)
Ticks = read.csv("~/Downloads/TickCounts.csv", header = TRUE, row.names = 1)

# 1.1)
class(Ticks) # it's a dataframe. If it wasn't, use code below to convert it to a dataframe:
Ticks = as.data.frame(Ticks)

# 1.2)

sapply(Ticks[,1:5], FUN = range)
# sapply function lets you apply a function to multiple columns & rows at once

# 1.2.1)
hist(Ticks$TickCount)

# 1.3)
plot(TickCount ~ DeerCount, data = Ticks)
# No apparent trend

# 1.4)
plot(TickCount ~ SiteSize, data = Ticks,
     main = "Tick Counts Versus Site Size",
     pch = 16, 
     col = "darkblue")
abline(lm(TickCount ~ SiteSize, data = Ticks))
# Does appear to be a relationship between site size and tick counts

# 1.5) 
model1 = lm(TickCount ~ SiteSize + HostDiversity + LizardCount, data = Ticks)
summary(model1)
# pretty high R squared (in ecology, R2 > 0.5 is AMAZING!)

# 1.6) 
Actual = as.data.frame(cbind(Ticks$SiteSize, Ticks$HostDiversity, Ticks$LizardCount))
colnames(Actual) = c("SiteSize", "HostDiversity", "LizardCount")

# 1.7)
PredictTicks = predict.lm(model1, Actual)

# 1.8)
plot(Ticks$TickCount ~ PredictTicks, pch = 16)
abline(lm(Ticks$TickCount ~ PredictTicks), col = "red")

# 1.9)
Diff = PredictTicks - Ticks$TickCount

# 1.10)
sort(Diff) 
# Site 8 has many more actual ticks than expected 
# Site 6 has many fewer actual ticks than expected

# 1.10.1)
model2 = lm(TickCount~ SiteSize + HostDiversity + LizardCount + DeerCount, data = Ticks)
# Model 2 is slightly worse (although differences <2 in AIC don't really matter)
# But essentially adding deer count info doesn't substantially improve our model

# 1.11) 
North = Ticks[Ticks$SiteLocation == "North",]
South = Ticks[Ticks$SiteLocation == "South", ]

# 1.12)
t.test(North$TickCount, South$TickCount)

# 1.13)
# mean for North sites = 58.4, mean for South sites = 64.5
# No statistical difference between sites

# 1.14)
t.test(Ticks$TickCount ~ Ticks$RatCount)
# Doesn't work because rat count is numeric data with >2 levels
# Can only do a t.test on a vector or data with 2 levels

# 1.15)
class(SizeCat)
SizeCat = as.factor(SizeCat) 

# 1.16)
Ticks2= cbind(Ticks, SizeCat)
View(Ticks2)

# 1.17)
fit = aov(HostDiversity ~ SizeCat, data = Ticks)
boxplot(HostDiversity ~ SizeCat, data = Ticks)
# These are two ways of determining whether host diversity differs based on site size
# The ANOVA can tell us the p-value of the statistical test on this relationship
# The boxplot can graphically show us how sites differ 
# (and the overlapping ranges of the boxplot indicate that there is no statistical difference)


# 1.17.1)
slices = c(71, 65, 41.75)
labels = c("Large", "Med", "Small")
pie(slices, labels = labels, col = c("darkblue", "blue", "lightblue"),
    main = "Tick Counts By Site")

# 1.18)
cor(Ticks$RatCount, Ticks$MouseCount)
cor(Ticks$RatCount, Ticks$DeerCount)

# 1.19
chisq.test(Counts1998, Ticks$TickCount)
# Not significantly different

# 1.20
# The par line adjusted the plotting window to allow us to 2 plots in a single row 
# The distributions look roughly similar, but the current year's counts appear higher



# 2)
# Using example dataset "road"
# Which has info about road deaths in the US

plot(deaths ~ popden, data = road)
# Removing DC (outlier, masking trends)

roads2 = road[-9,]
plot(deaths ~ popden, data = roads2)
abline(lm(deaths ~ popden, data = roads2))
# No apparent trend between population density and road deaths

# Trying now to understand what variables relate to road deaths
fit = lm(deaths ~ rural + popden + fuel + temp, data = roads2)
summary(fit)
# Looks like rural and temp are important
fit2 = lm(deaths ~ rural + temp, data = roads2)
summary(fit2)
AIC(fit) - AIC(fit2)
# They're essentially equivalent models 


# How do road deaths vary by state?
# pie charts are THE WORST, but this is just for practice
pie(roads2$deaths, labels = rownames(roads2),
    col = sample(palette(rainbow(30)), 25, replace = FALSE))
#

# Much better to do a histogram or barplot
barplot(roads2$deaths, main = "road deaths by state", las =2,
        ylim = c(0,5000))
# Challenge: Can you figure out how to add the x-axis labels? 
# i.e. so that each bar has it's corresponding state label?