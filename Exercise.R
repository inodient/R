########################################################################################################################
## Data
## Data Type
## 1. Numeric
## 2. Logical
## 3. Character
## Data Object
## 1. Basic
##  (1) Scalar, Vector
##  (2) Array
##  (3) Matrix
##  (4) Factor
## 2. Collection of Basic Types
##  (1) List
##  (2) Data Frame
########################################################################################################################

########################################################################################################################
## Data Transform
##                  | To one long vector        | To Matrix                     | To Data Frame
## ---------------------------------------------------------------------------------------------------------------------
## From vector      | c(x,y)                    | cbind(x,y) / rbind(x,y)       | data.frame(x,y)
## ---------------------------------------------------------------------------------------------------------------------
## From Matrix      | as.vector(mymatrix)       | -                             | as.data.frame(mymatrix)
## ---------------------------------------------------------------------------------------------------------------------
## From Data Frame  | -                         | as.matrix(myframe)            | -
########################################################################################################################

v1 <- c(1,2,3,4,5,6,7)
v2 <- c(9,10,11,12,13,14,15)
v <- c(rep=(1:3))
v

m <- cbind(v1,v2)
m
m <- rbind(v1,v2)
m

names <- c("Changho Kang", "Dongwon Lee", "Minjae Lee")
positions <- c("DR", "DR", "SW")
management <- c("RND Portal", "EPTS", "Engineering System")
tels <- c("1625", "1626", "1627")
sex <- factor( c("MALE", "MALE", "MALE"), levels=c("MALE", "FEMALE") )

matrix1 <- cbind(names, positions, management, tels, sex)
matrix1
matrix2 <- rbind(names, positions, management, tels, sex)
matrix2

dataframe1 <- data.frame( names, positions, management, tels, sex, stringsAsFactors = F)
dataframe1

matrix3 <- as.matrix( dataframe1 )
matrix3

list1 <- list( name=names[1], position=positions[1], management=management[1], tel=tels[1], sex=sex[1] )
list1
list1$name
## list and data frame only access their element using $ symbol.



########################################################################################################################
## File Save, Write and Load
########################################################################################################################

save( matrix1, file="/Users/changhokang/inno/05. Workspaces/RTest/exercies_data.RData")
save( matrix1, matrix2, matrix3, file="/Users/changhokang/inno/05. Workspaces/RTest/exercies_data.RData")

rm( matrix1, matrix2, matrix3 )
load( "/Users/changhokang/inno/05. Workspaces/RTest/exercies_data.RData") 

write.csv( dataframe1, file="/Users/changhokang/inno/05. Workspaces/RTest/exercies_csv.csv", row.names=F )

dataframe2 <- read.csv( "/Users/changhokang/inno/05. Workspaces/RTest/exercies_csv.csv", header=T) 
dataframe2

usedcars <- read.csv("/Users/changhokang/inno/05. Workspaces/RTest/usedcars.csv")




########################################################################################################################
## Understanding of data
##    : str, summary
##    : range, diff, IQR, quantile
##    : boxplot, hist
##    : Variance-var, StdDev-sd
##    : table, prop.table
##    : plot
##    : crossTable
########################################################################################################################

usedcars
str(usedcars)
summary(usedcars$mileage)

range(usedcars$mileage)
diff(range(usedcars$mileage))
IQR(usedcars$mileage)

quantile(usedcars$mileage)
quantile(usedcars$mileage, prob=c(0.0,0.99))
quantile(usedcars$mileage, seq(from=0, to=1, by=0.25))

boxplot(usedcars$mileage, main="main title", ylab="ylab", xlab="xlab")
boxplot(usedcars$price)

hist(usedcars$mileage, main="main title", ylab="ylab", xlab="xlab")
hist(usedcars$price, main="main title", ylab="ylab", xlab="xlab")

var(usedcars$price)
var(usedcars$mileage)
sd(usedcars$price)
sd(usedcars$mileage)

table(usedcars$year)
table(usedcars$model)
table(usedcars$color)

prop.table(table(usedcars$year))
prop.table(table(usedcars$model))
prop.table(table(usedcars$color))

color_table <- table(usedcars$color)
color_pt <- prop.table(color_table) * 100
round(color_pt, digit=2)

plot(x=usedcars$mileage, y=usedcars$price)

table(usedcars$color)
usedcars$conservative <- usedcars$color %in% c("Black","Silver","Gray","White")

      ## Install Package
      ## install.packages("gmodels")
      ## library("gmodels")
CrossTable(x=usedcars$model, y=usedcars$conservative)
CrossTable(x=usedcars$year, y=usedcars$conservative)
CrossTable(x=usedcars$year, y=usedcars$model)



########################################################################################################################
## Pre-executioning data 01
##  head
##  apply, lapply, sapply, tapply, mapply
##  apply  - apply to matrix
##  laaply - return as list
##  sapply - return as vector, matrix
##  tapply - group data, return as array
##  mapply - multiple input parameter
########################################################################################################################

head(iris)
d <- matrix(1:9, nrow=3, byrow=T)
d

apply(d, 1, sum)
apply(d, 2, sum)
apply(d, 1, mean)
apply(d, 2, mean)

lapply(1:3, function(x) { x*2 }) # apply to list
lapply(iris[,1:4], mean) # apply to data frame --> return as list

d <- as.data.frame(matrix(unlist(lapply(iris[,1:4], mean)), ncol=4, byrow=T))
names(d) <- names(iris[,1:4])

data.frame(do.call(cbind, lapply(iris[,1:4], mean)))

sapply(iris[,1:4], mean)

tapply(1:10, rep(1,10), sum)
tapply(1:10, 1:10 %% 2 == 1, function(x){x})
class(tapply(1:10, 1:10 %% 2 == 1, function(x){x}))

mapply(function(i,s){sprintf(" %d %s", i, s);}, 1:3, c("a","b","c"))
mapply(function(species, sepal_length){sprintf(" %s : %s", species, sepal_length);}, iris[1:20,5], iris[1:20,1])
class(mapply(function(species, sepal_length){sprintf(" %s : %s", species, sepal_length);}, iris[1:20,5], iris[1:20,1]))



########################################################################################################################
## Pre-executioning data 02
##  with - convenient accessing to fields
##  within - correct(update) data
##  which - index of location of searching data
########################################################################################################################

with(iris, {print(mean(Sepal.Length));print(mean(Sepal.Width))})
class(with(iris, {print(mean(Sepal.Length));print(mean(Sepal.Width))}))

x <- data.frame(val=c(1,2,3,4,NA,5,NA))
x
x <- within(x, {val<-ifelse(is.na(val), median(val,na.rm=T),val)})
x
      ## ifelse expression
      ##  ifelse(test_expression, x, y)
      ##  if you using C,C++,JAVA or common programming language,
      ##  below expression is written as,
      ##  if( text_expression ){
      ##      execute x;
      ##  } else {
      ##      execute y;
      ##  }

numbers <- 1:203
oddeven <- ifelse( 1:20 %% 2 == 1, "odd", "even")
numeric_df <- data.frame( numbers, oddeven )
str(numeric_df)
table(numeric_df)
summary(numeric_df$oddeven)

x <- c(2,4,6,7,10)
x %% 2
which(x%%2==0)
x[which(x%%2==0)]
x
which.min(x)
which.max(x)
