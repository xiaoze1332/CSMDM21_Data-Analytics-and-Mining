# install the dslabs package, load the dslabs library and 
# load the US murders dataset
install.packages("dslabs")
library(dslabs)
data(murders)

# 1.	Data Types
# 1.1.	Data frames
# To see that the murders data is in fact a data frame:
class(murders)

# Examining an object
# To finding out more about the structure of an object:
str(murders)

# show the first six lines 
head(murders)

# The accessor: $
# To access the population column of the murders data frame:
murders$population

# 1.2.	Vectors: numerics, characters, and logical
# The function length tells you how many entries are in the vector
# numerics
pop <- murders$population
length(pop)
class(pop)

# character
class(murders$state)

# logical 
z <- 3 == 2
z
class(z)

# 1.3.	Factors
class(murders$region)

# We can see that there are only 4 regions by using the levels function:
levels(murders$region)

# reorder the levels of the region by the total number of murders 
# rather than alphabetical order
region <- murders$region
value <- murders$total
region <- reorder(region, value, FUN = sum)
levels(region)

# 1.4.	Lists
# create a list 
record <- list(name = "John Doe",
               student_id = 1234,
               grades = c(95, 82, 91, 97, 93),
               final_grade = "A")
record
class(record)

# extract the components of a list using $
record$student_id

# extract the components of a list using double square brackets [[
record[["student_id"]]

# lists without variable names
record2 <- list("John Doe", 1234)
record2

# extract the components by list index
record2[[1]]

# Exercise 1
# q2.	What are the column names used by the data frame?
str(murders)

# q3.	Extract the state abbreviations and assign them to the object a. 
# What is the class of this object?
a <- murders$abb
class(a)

# q4.	With one line of code, use the function levels and length 
# to determine the number of regions defined by this dataset.
length(levels(murders$region))

# q5.	The function table takes a vector and 
# returns the frequency of each element. 
# Use this function in one line of code to create a table of states per region.
table(murders$region)

############################################################################
# 2.	Vectors
# 2.1.	Creating vectors
codes <- c(380, 124, 818)
codes

country <- c("italy", "canada", "egypt")
country

country <- c('italy', 'canada', 'egypt')
country

# 2.2.	Names
# defining a vector of country codes
codes <- c(italy = 380, canada = 124, egypt = 818)
codes

# The object codes continues to be a numeric vector:
class(codes)

# extract the country names
names(codes)

# assign names using the names functions:
codes <- c(380, 124, 818)
country <- c("italy","canada","egypt")
names(codes) <- country
codes

# 2.3.	Sequences
# creating vectors generates sequences
seq(1, 10)
seq(1, 10, 2)

# using shorthand
1:10
class(1:10) # gives integer

# create a sequence including non-integers
class(seq(1, 10, 0.5)) # gives numeric

# 2.4.	Subsetting
codes

# access the second element 
codes[2]

# get more than one entry 
codes[c(1,3)]

# get the first two elements
codes[1:2]

# access the entries using element names
codes["canada"]
codes[c("egypt","italy")]

# Exercise 2
# q1. define temperatures
temp <- c(35, 88, 42, 84, 81, 30)

# q2. define cities
city <- c('Beijing', 'Lagos', 'Paris', 'Rio de Janeiro', 'San Juan', 'Toronto')

# q3. associate the temperature data with its corresponding city
names(temp) <- city
temp

# q4. temperature of the first three cities 
temp[1:4]

# q5. temperature of Paris and San Juan
temp[c('Paris', 'San Juan')]

##############################################################################
# 3.	Sorting
# 3.1 sorts murders$total in increasing order
sort(murders$total)

# 3.2 order the state names by their total murders:
# first obtain the index that orders the vectors according to murder totals 
# and then index the state names vector
ind <- order(murders$total) 
murders$state[ind]

# 3.3 the largest value
max(murders$total)

# which.max for the index of the largest value
i_max <- which.max(murders$total)
i_max
murders$state[i_max]

# Exercise 3
# q1. Use the $ operator to access the population size data and store it as the object pop. 
# Then use the sort function to redefine pop so that it is sorted. 
# Finally, use the [ operator to report the smallest population size.
pop <- murders$population
pop <- sort(pop)
pop[1]

# q2. Now instead of the smallest population size, 
# find the index of the entry with the smallest population size. 
# Hint: use order instead of sort.
indx <- order(murders$population)
indx
indx[1]

# q3. repeat the previous question using the function which.min. 
# Write one line of code that does this.
which.min(murders$population)

# q4. the name of the state with the smallest population
murders$state[which.min(murders$population)]

#####################################################################
# 4.	Indexing
# 4.1.	Subsetting with logicals
# calculate the murder rate 
murder_rate <- murders$total / murders$population * 100000 

# test if EACH of the murder_rate is < 0.71
ind <- murder_rate < 0.71
ind

# return the states with murder_rate < 0.71
murders$state[ind]

# return the number of states with murder_rate < 0.71
sum(ind)

# 4.2.	Logical operators
# find safe states (murder rate to be at most 1) in the western region
west <- murders$region == "West"
safe <- murder_rate <= 1
ind <- safe & west
murders$state[ind]

# 4.3.	 which
# look up California's murder rate
which(murders$state == "California")
ind <- which(murders$state == "California")
murder_rate[ind]

# 4.4.	 match
# the function match tells us which indexes of a second vector 
# match each of the entries of a first vector
ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind

# Now we can look at the murder rates:
murder_rate[ind]

# 4.5.	 %in%
# find out if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state

# Exercise 4
# q1. which entries of murder_rate are lower than 1
low <- murder_rate < 1
low

# q2. indices of murder_rate associated with values lower than 1
low_ind <- which(murder_rate < 1)
low_ind

# q3. names of the states with murder rates lower than 1
murders$state[low_ind]

# q4. report the states in the Northeast with murder rates lower than 1
northeast <- murders$region == 'Northeast'
murders$state[low & northeast]

# q5. How many states are below the average murder rate?
murders$state[murder_rate < mean(murder_rate)]
length(murders$state[murder_rate < mean(murder_rate)])

######################################################################
# 5.	Basic plots
# 5.1.	 plot (scatterplot)
# total murders versus population
x <- murders$population / 10^6
y <- murders$total
plot(x, y)

# plot using the with function
with(murders, plot(population, total))

# 5.2 histogram
x <- with(murders, total / population * 100000)
hist(x)

# the state with maximum murder rate
murders$state[which.max(x)]

# 5.3.	 boxplot
# murder rate of different regions
murders$rate <- with(murders, total / population * 100000)
boxplot(rate~region, data = murders)

# Exercise 5
# q1. histogram of the state populations
population_in_million <- with(murders, population/1000000)
hist(population_in_million)

# q2. boxplots of the state populations by region
boxplot(population_in_million~region, data = murders)
