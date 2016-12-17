## swiss machine learning
require(datasets);
require(ggplot2);
data(swiss);
str(swiss);
summary(swiss);

hist(swiss$Infant.Mortality);
qqnorm(swiss$Infant.Mortality);
qqline(swiss$Infant.Mortality);

model<-lm(Infant.Mortality~. ,data=swiss);
summary(model);



## DB Connection
install.packages('/private/var/folders/jy/52qr5ksd1dd66y9vc08z6zhw0000gn/T/RtmphPVqQb/downloaded_packages/RODBC_1.3-14.tar.gz', repos = NULL, type="source")
install.packages('RODBC');
library('RODBC');
dbhandle <- odbcDriverConnect('driver={SQLServerDriver};server=10.32.32.35;database=rddb;trusted_connection=false')
res <- sqlQuery(dbhandle, 'select * from information_schema.tables')

## DB Connection
install.packages('/private/var/folders/jy/52qr5ksd1dd66y9vc08z6zhw0000gn/T/RtmphPVqQb/downloaded_packages/RJDBC_0.2-5.tgz', repos = NULL, type="source")
require(RJDBC)
library(RJDBC)

if (.Platform$OS.type == "unix"){
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver",
              "/etc/sqljdbc_2.0/sqljdbc4.jar")
} else {
  drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver",
              "C:/Program Files/Microsoft SQL Server JDBC Driver 3.0/sqljdbc_3.0
              /enu/sqljdbc4.jar")
}

drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver", "/Users/changhokang/Downloads/sqljdbc_4.0/enu/sqljdbc4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:sqlserver://10.32.32.34", "sa", "123456!");

sqlText <- paste("select GETDATE()", sep="" );
queryResults <- dbGetQuery(conn, sqlText);

queryResults


## Machine Learning Simple Example
x = c(1.9, 0.8, 1.1, 0.1, -0.1, 4.4, 4.6, 1.6, 5.5, 3.4) # 독립변수
y = c(0.7, -1.0, -0.2, -1.2, -0.1, 3.4, 0.0, 0.8, 3.7, 2.0) # 종속변수

out = lm(y ~ x) # 단순선형회귀
summary(out) # 기본 분석결과 확인
jpeg('09_01.jpg')
plot(x, y) # plotting
abline(out) # 회귀선 추가
dev.off()
attributes(out)
pred_y = predict(out, newdata = data.frame(x = x)) # y의 예측값 구하기
pred_y
predict(out, newdata = data.frame(x = 2.3)) # x = 2.3에서의 y의 예측값 구하기
predict(out, newdata = data.frame(x = c(1, 2.2, 6.7))) # x = 1, 2.2, 6.7에서의 y의 예측값 구하기