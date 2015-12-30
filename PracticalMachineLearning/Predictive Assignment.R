---
title: "Practical Machine Learning Course Project Write Up"
author: "Chai Chuan Yen"
date: "Sunday, December 27, 2015"
output: html_document
---

##Prediction Assignment Write Up
###Executive Summary
####Background

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement - a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset). 

###Input Data

We will initialise by loading necessary library

```{r}
library(caret)
```

```{r}
library(randomForest)
```

```{r}
library(rpart)
set.seed(8888)
```
High level description of the raw data and detailed data description for this project came from source: http://groupware.les.inf.puc-rio.br/har.

We will load the csv file into R

```{r}
train<-read.csv("pml-training.csv",na.strings=c("NA",""), strip.white = T)
test <-read.csv("pml-testing.csv", na.strings=c("NA",""), strip.white = T)
```

###Formatting and cleaning data

The code fragment below is to clean and prepare the dataset for further processing, that step including the treatment of null value for data.

```{r}
isNA.train <- apply(train, 2, function(x) { sum(is.na(x)) })
isNA.test <- apply(test, 2, function(x) { sum(is.na(x)) })
training <- subset(train[, which(isNA.train == 0)], 
                   select=-c(X, user_name, new_window, num_window, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp))
testing <- subset(test[, which(isNA.test == 0)], 
                              select=-c(X, user_name, new_window, num_window, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp))
```
