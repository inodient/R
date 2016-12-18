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
  #drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","/etc/sqljdbc_2.0/sqljdbc4.jar")
} else {
  #drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","C:/Program Files/Microsoft SQL Server JDBC Driver 3.0/sqljdbc_3.0/enu/sqljdbc4.jar")
}

drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver", "/Users/changhokang/Downloads/sqljdbc_4.0/enu/sqljdbc4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:sqlserver://10.32.32.34", "sa", "123456!");


## Machine Learning Exercise
rm(x);
rm(y);

x <- c();
y <- c();

for( i in 0:8 ){
    
  StartDate <- Sys.Date() - (7-i);
  EndDate <- Sys.Date() - (7-i-1);
  
  sqlText_Total <- paste( "Select count(Result) AS Total from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' " );
  sqlText_Success <- paste( "Select count(Result) AS Success from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' and Result = 'E' " );

  sqlText_Total <- gsub( "START", StartDate, sqlText_Total );
  sqlText_Total <- gsub( "END", EndDate, sqlText_Total );
  
  sqlText_Success <- gsub( "START", StartDate, sqlText_Success );
  sqlText_Success <- gsub( "END", EndDate, sqlText_Success );
  
  queryResults_Total = dbGetQuery( conn, sqlText_Total );
  queryResults_Success = dbGetQuery( conn, sqlText_Success );

  #print( sqlText_Total );
  #print( sqlText_Success );
  
  #print( queryResults_Total$Total );
  #print( queryResults_Success$Success );    

  #x <- c( x, queryResults_Total$Total );
  #y <- c( y, queryResults_Success$Success );
  
  x[i] <- queryResults_Total$Total;
  y[i] <- queryResults_Success$Success;
  
  #print( summary( queryResults_Total ) );
  #print( summary( queryResults_Success ) );    
}

out = lm(y ~ x) # 단순선형회귀
out_summary <- summary(out) 
p_value <- pf(out_summary$fstatistic[1], out_summary$fstatistic[2], out_summary$fstatistic[3], lower.tail = FALSE) 

fileConn<-file("/Users/changhokang/git/R/result.txt");
writeLines( as.character(out_summary), fileConn );
close( fileConn );
write( gsub( "TARGET", p_value, "p_value : TARGET" ), file="/Users/changhokang/git/R/result.txt",append=TRUE )

#jpeg('09_01.jpg')
#plot(x, y) # plotting
#abline(out) # 회귀선 추가
#dev.off()
#attributes(out)
#pred_y = predict(out, newdata = data.frame(x = x)) # y의 예측값 구하기
#pred_y
#predict(out, newdata = data.frame(x = 2.3)) # x = 2.3에서의 y의 예측값 구하기
#predict(out, newdata = data.frame(x = c(1, 2.2, 6.7))) # x = 1, 2.2, 6.7에서의 y의 예측값 구하기



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

# SQLs
#sqlText <- paste("SELECT CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 101))", sep="" );
#sqlText <- paste("select case Result when 'S' then 1 when 'E' then 0 else -1 END  from rddb.dbo.TB_InterfaceResult where DateTime >= CONVERT(DATETIME, CONVERT(varchar(10), GETDATE(), 101))", sep="" );
#sqlText <- paste("select distinct( count(DateTime) ) from rddb.dbo.TB_InterfaceResult", sep="" );
sqlText <- paste("select case Result when 'S' then 1 when 'E' then 0 else -1 END  from rddb.dbo.TB_InterfaceResult where DateTime >= '2016-11-01'", sep="" );
sqlText <- paste("select * from rddb.dbo.TB_InterfaceResult where DateTime >= '2016-12-16' and DateTime < '2016-12-17' and Result = 'E' ", sep="" );

queryResults <- dbGetQuery(conn, sqlText);
queryResults

summary( queryResults );
sum( queryResults )


