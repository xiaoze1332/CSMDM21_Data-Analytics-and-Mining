# uncomment the following line if you need to install the package
#install.packages('rpart.plot')

# load the libraries for this exercises
library(rpart) 
library(rpart.plot)

# read the data set
data(iris)
N <- nrow(iris) # number of records in the iris data set
numTrials <- 20

#################################################################
# 10-fold xVal method on all input data (training on 90% of input data) 
xVal_accuracy <- vector()

for (t in 1: numTrials)
{
  # shuffle the input data 
  rows <- sample(N)    # use the sample() function to shuffle the row indices of the data set
  iris <- iris[rows, ] # use this random vector to reorder the iris data set
  #iris
  correct_predictions <- 0 
  
  # create 10 equally size folds
  # cut: Convert Numeric to Factor
  # labels = FALSE, simple integer codes are returned instead of a factor
  folds <- cut(seq(1,N),breaks=10,labels=FALSE)
  #folds

  # perform 10 fold cross validation
  for(i in 1:10)
  {
    # segement the data by fold 
    # arr.ind=TRUE to return array indices 
    testIndexes <- which(folds==i,arr.ind=TRUE)
    testSet <- iris[testIndexes, ]
    trainingSet <- iris[-testIndexes, ]
    
    # build a predictive model from all partitions but f 
    iris.dt <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length +  
                    Petal.Width, data=trainingSet, method="class")
  
    # apply the model dt to the partition f
    prediction <- predict(iris.dt, newdata=testSet, type="class") 
    cM <- table(testSet$Species, prediction) 
    #cM
    
    correct_predictions = correct_predictions + sum(diag(cM))
  }
  xVal_accuracy[t] <- correct_predictions / N 
}

# compute average and standard deviation of xVal_accuracy[] 
mean(xVal_accuracy)
sd(xVal_accuracy)

#################################################################
# LOOCV method on a sample of the data (training on 90% of input data) 
sampleSize <- N * 0.9 + 1 

loocv_accuracy <- vector()

for (t in 1: numTrials)
{
  # randomly sample sampleSize records from input data
  dataSampleIdx <- sample(N, size=sampleSize) 
  data <- iris[dataSampleIdx,]
  
  correct_predictions <- 0 
  
  for (i in 1:sampleSize)
  {
    # build a predictive model from all records n data but i
    testSet <- data[i,] 
    trainingSet <- data[-i,]
    
    iris.dt <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length +  
                    Petal.Width, data=trainingSet, method="class")
    
    # apply the model dt to the record i
    prediction <- predict(iris.dt, newdata=testSet, type="class") 
    cM <- table(testSet$Species, prediction) 

    correct_predictions = correct_predictions + sum(diag(cM))
  }
  
  loocv_accuracy[t] <- correct_predictions / sampleSize
}

# compute average and standard deviation of loocv_accuracy[] 
mean(loocv_accuracy)
sd(loocv_accuracy)