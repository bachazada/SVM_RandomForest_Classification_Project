rm(list=ls())
library("e1071")
dat <- readRDS("data/data_PQN.rds")
dat[1:5,1:5]
res <- readRDS("data/responses.rds")
all(rownames(dat)==names(res))

fit <- svm(x = dat, y = as.factor(res))
str(fit)
fit2 <- svm(x = dat, y = as.factor(res), method="nu-classification")
str(fit2)

fit <- svm(x = dat, y = as.factor(res), kernel='polynomial', probability = TRUE)

probs <- predict(object = fit, newdata = dat, probability = TRUE)
str(probs)
probs <- attributes(probs)$probabilities[,2]

library(ROCR)
pred0 <- prediction(predictions = probs, labels = res)
perf0 <- performance(prediction.obj = pred0, 'tpr', 'fpr')
plot(perf0)

CV <- function(x, y){
  set.seed(1)
  pred.prob <- rep(NA, length(y))
  pred.label <- rep(NA, length(y))
  for(i in 1:length(y)){
    x.train <- x[-i,]
    x.test <- x[i, , drop=FALSE]
    y.train <- y[-i]
    fit <- svm(x = x.train, y = as.factor(y.train), kernel='sigmoid', type = 'nu-classification'
               , probability = TRUE)
    temp <- predict(object = fit, newdata = x.test, probability = TRUE)
    pred.prob[i] <- attributes(temp)$probabilities[,2]
    pred.label[i] <- as.integer(as.character(temp))
  }
  return(list(label=pred.label, prob=pred.prob))
}
result <- CV(x = dat, y = res)

table(result$label, res)
pred0 <- prediction(predictions = result$prob, labels = res)
perf0 <- performance(prediction.obj = pred0, 'tpr', 'fpr')
perf0 <- performance(prediction.obj = pred0, 'auc')

print(perf0@y.values[[1]])
#[1] 0.8461538      #polynomial kernel
#0.8350816          #radial
#[1] 0.787296       #linear kernel
#[1] 0.8181818      #sigmoid
rm(list=ls())
library(randomForest)
dat <- readRDS("data/processed_cleveland.rds")
rownames(dat) <- paste("sample", 1:nrow(dat))
readLines("data/description.txt")

sapply(dat, class)
IDs <- sample(x = rownames(dat), size = round(nrow(dat)*3/4), replace = FALSE)

x.train <- dat[IDs,]
x.test <- dat[!rownames(dat)%in%IDs,]
intersect(x.train, x.test)

fit <- randomForest(x = x.train[,-14], y =x.train[,14] )
plot(fit)
#browseVignettes("randomForest")
barplot(t(fit$importance), las=2)
str(fit)

pred <- predict(object = fit, newdata = x.test[,-14], type = "prob")[,2]
pred.label <- predict(object = fit, newdata = x.test[,-14])
table(pred.label, x.test[,14])
pred0 <- prediction(predictions = pred, labels = x.test[,14])

perf0 <- performance(pred0, 'prec', 'rec')
plot(perf0)
perf0 <- performance(pred0, 'tpr', 'fpr')
plot(perf0)



