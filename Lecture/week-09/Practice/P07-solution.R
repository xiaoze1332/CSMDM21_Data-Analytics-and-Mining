# uncomment the following line if you need to install the package
#install.packages('rpart.plot')

# load the libraries for this exercises
library(rpart) 
library(rpart.plot)

# read the data set
data(iris)
N <- nrow(iris) # number of records in the iris data set
numTrials <- 20

resub_accuracy <- vector()
hold_out_accuracy <- vector()

for (t in 1: numTrials)
{
  # set sample rate as 10%
  sampleRate <- 0.10 
  sampleSize <- N * sampleRate 
  #sampleSize
  
  # test set <- randomly sample 10% of input data 
  testSampleIdx <- sample(N, size=sampleSize) 
  #testSampleIdx
  
  testSet <- iris[testSampleIdx,] 
  #testSet 
  
  # training set <- input data \ test set 
  trainingSet <- iris[-testSampleIdx,] 
  #trainingSet 

  # build a predictive model from the training set
  iris.dt <- rpart(Species ~ Sepal.Length + Sepal.Width + Petal.Length +  
                  Petal.Width, data=trainingSet, method="class") 
  #iris.dt              # print the decision tree model
  #rpart.plot(iris.dt)  # plot the decision tree
  
  
  # Resubstitution method: apply the model dt to the training set
  prediction <- predict(iris.dt, newdata=trainingSet, type="class") 
  cM <- table(trainingSet$Species, prediction) 
  #print(cM) 
  
  acc <- sum(diag(cM))/sum(cM) 
  acc
  resub_accuracy[t] <- acc

  # Hold-out method: apply the model dt to the test set 
  prediction <- predict(iris.dt, newdata=testSet, type="class") 
  cM <- table(testSet$Species, prediction) 
  #print(cM) 
  
  acc <- sum(diag(cM))/sum(cM) 
  hold_out_accuracy[t] <- acc
}

# compute average and standard deviation of resub_accuracy[]
mean(resub_accuracy)
sd(resub_accuracy)

# compute average and standard deviation of hold_out_accuracy[]
mean(hold_out_accuracy)
sd(hold_out_accuracy)
