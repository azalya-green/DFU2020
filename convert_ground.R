options(stringsAsFactors=FALSE)

infile <- file.path("Data_New","groundtruth.csv")
copyfile <- file.path("Data_New","groundtruth_orig.csv")
outfile1 <- file.path("Data_New","VoTT","groundtruth.csv")
outfile2 <- infile
file.copy(infile,copyfile)
x <- read.csv(infile)
nams <- colnames(x)
nams[1] <- "image"
nams <- c("label",nams)
x <- cbind("u",x)
colnames(x) <- nams
write.csv(x,outfile1,quote=FALSE,row.names=FALSE)
write.csv(x,outfile2,quote=FALSE,row.names=FALSE)
