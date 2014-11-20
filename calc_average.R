library(plyr)
library(data.table)

calc_average <- function(inDT) {
  aggrDT <- aggregate(inDT[,3:88],by=list(subject=inDT$subject,activity=inDT$activity),sum)
  aggrDT <- arrange(aggrDT,subject)
  counts <- count(inDT,c("subject","activity"))
  aveDT <- aggrDT[,3:88]/counts[1:180,3]
  aggrDT <- cbind(aggrDT[,1:2],aveDT[])

  aggrDT
  
}
