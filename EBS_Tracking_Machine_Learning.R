require(RJDBC)
library(RJDBC)

drv <- JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver", "D:/Projects/Web/JDBC/sqljdbc_3.0/kor/sqljdbc4.jar",identifier.quote="`")
conn <- dbConnect(drv, "jdbc:sqlserver://10.32.32.34", "sa", "123456!");


## Machine Learning Exercise
rm(x);
rm(y);

x <- c();
y <- c();

count = 0;
for( i in 0:31 ){
  
  StartDate <- Sys.Date() - (30-i);
  EndDate <- Sys.Date() - (30-i-1);
  
  sqlText_Total <- paste( "Select count(Result) AS Total from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' " );
  sqlText_Success <- paste( "Select count(Result) AS Success from rddb.dbo.TB_InterfaceResult where DateTime >= 'START' and DateTime < 'END' and Result = 'E' " );
  
  sqlText_Total <- gsub( "START", StartDate, sqlText_Total );
  sqlText_Total <- gsub( "END", EndDate, sqlText_Total );
  
  sqlText_Success <- gsub( "START", StartDate, sqlText_Success );
  sqlText_Success <- gsub( "END", EndDate, sqlText_Success );
  
  queryResults_Total = dbGetQuery( conn, sqlText_Total );
  queryResults_Success = dbGetQuery( conn, sqlText_Success );

  if( queryResults_Total$Total > 0 ){
    x[count] <- queryResults_Total$Total;
    y[count] <- queryResults_Success$Success;
    count = count+1;
  }
}

out = lm(y ~ x) # 단순선형회귀
out_summary <- summary(out) 
p_value <- pf(out_summary$fstatistic[1], out_summary$fstatistic[2], out_summary$fstatistic[3], lower.tail = FALSE) 

#fileConn<-file("/Users/changhokang/git/R/result.txt");
fileConn<-file("C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/Tracking_Result/Result.txt");

writeLines( as.character(out_summary), fileConn );
close( fileConn );

#write( gsub( "TARGET", p_value, "p_value : TARGET" ), file="/Users/changhokang/git/R/result.txt",append=TRUE )
write( gsub( "TARGET", p_value, "p_value : TARGET" ), file="C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/Tracking_Result/Result.txt",append=TRUE )

jpeg('C:/__Repo.Workspace/Nodejs/EBS_Tracking_System/views/result.jpg')
plot(x, y) # plotting
abline(out) # 회귀선 추가
dev.off()