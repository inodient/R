#http://bigbigdata.tistory.com/78

aFile = readLines("C:/__Repo.Workspace/R/Total_Oct.txt");

data = sapply(aFile, extractNoun, USE.NAMES=T );

undata = unlist(data);

data = Filter( function(x){nchar(x)>=2}, undata );

gsub("결정권자(파트리더","결정권자(파트리더)",data);
gsub("3DPDM등)에","3DPDM",data);
gsub("동안","",data);
gsub("팀원에","팀원",data);
gsub("팀원들에게","팀원",data);
gsub("내달","",data);
gsub("팀원을","팀원",data);
gsub("개월","",data);
gsub("R&R이","R&R",data);
gsub("(창원","창원",data);
gsub("분위","분위기",data);
gsub("in","",data);
gsub("house","",data);
gsub("부재(이전","부재",data);
gsub("(팀원을","팀원",data);
gsub("계열사(제조업)들이","계열사",data);
#gsub("(다쏘","",data);


write(unlist(data), "C:/__Repo.Workspace/R/Total_Oct_Parsing.txt");

table_data <-read.table("C:/__Repo.Workspace/R/Total_Oct_Parsing.txt");

wordcount<-table(table_data);

#install.packages('RColorBrewer');
#library(RColorBrewer);

#install.packages('KoNLP');
#library('KoNLP');

#install.packages('wordcloud');
#library('wordcloud');

wordcloud(names(wordcount), freq=wordcount, scale=c(5,1), rot.per=0.25, min.freq=1.5, random.order=F, random.color=T, colors=brewer.pal(9,"Set1"));



