require(RJDBC)
library(RJDBC)

drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver", "D:/Projects/Web/JDBC/sqljdbc_3.0/kor/sqljdbc4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:sqlserver://10.32.32.34", "sa", "123456!");


## Machine Learning Exercise
rm(x);
rm(y);
rm(z);

x <- c();
y <- c();
z <- c();

count = 0;
for( i in 0:30 ){
  
  StartDate <- Sys.Date() - (31-i);
  EndDate <- Sys.Date() - (30-i);
  
  sqlText_Total <- paste( "Select count(Result) AS Total from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' " );
  sqlText_Success <- paste( "Select count(Result) AS Success from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' and Result = 'E' " );
  
  sqlText_Total <- gsub( "START", StartDate, sqlText_Total );
  sqlText_Total <- gsub( "END", EndDate, sqlText_Total );
  
  sqlText_Success <- gsub( "START", StartDate, sqlText_Success );
  sqlText_Success <- gsub( "END", EndDate, sqlText_Success );
  
  queryResults_Total = dbGetQuery( conn, sqlText_Total );
  queryResults_Success = dbGetQuery( conn, sqlText_Success );

  if( queryResults_Total$Total > 0 ){
    print( queryResults_Total$Total );
    print( queryResults_Success$Success );
    
    y[count] <- queryResults_Total$Total;
    x[count] <- queryResults_Success$Success;
    count = count+1;
  }
}

z = c( x/y )

out = lm(z ~ y) # 단순선형회귀
out_summary <- summary(out) 
p_value <- pf(out_summary$fstatistic[1], out_summary$fstatistic[2], out_summary$fstatistic[3], lower.tail = FALSE) 

out_summary

pred_y = predict(out, newdata = data.frame(x = x)) # y의 예측값 구하기
pred_y
predict(out, newdata = data.frame(x = 100)) # x = 2.3에서의 y의 예측값 구하기
predict(out, newdata = data.frame(x = c(1, 2.2, 6.7))) # x = 1, 2.2, 6.7에서의 y의 예측값 구하기

#out = lm(y ~ x) # 단순선형회귀
#out_summary <- summary(out) 
#p_value <- pf(out_summary$fstatistic[1], out_summary$fstatistic[2], out_summary$fstatistic[3], lower.tail = FALSE) 

#pred_y = predict(out, newdata = data.frame(x = x)) # y의 예측값 구하기
#pred_y
#predict(out, newdata = data.frame(x = 100)) # x = 2.3에서의 y의 예측값 구하기
#predict(out, newdata = data.frame(x = c(1, 2.2, 6.7))) # x = 1, 2.2, 6.7에서의 y의 예측값 구하기


#fileConn<-file("/Users/changhokang/git/R/result.txt");
fileConn<-file("C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/Tracking_Result/Result.txt");

writeLines( as.character(out_summary), fileConn );
close( fileConn );

#write( gsub( "TARGET", p_value, "p_value : TARGET" ), file="/Users/changhokang/git/R/result.txt",append=TRUE )
write( gsub( "TARGET", p_value, "p_value : TARGET" ), file="C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/Tracking_Result/Result.txt",append=TRUE )

jpeg('C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/views/result.jpg')
plot(y, z) # plotting
abline(out) # 회귀선 추가
dev.off()
