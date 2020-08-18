options(stringsAsFactors=FALSE)

source("per_over.R")

infile <- file.path("Data_New","Source_Images","Test_Image_Detection_Results","Detection_Results.csv")
x <- read.csv(infile)
outfile <- file.path("Data_New","Source_Images","Test_Image_Detection_Results","Detection_Results_corrected.csv")

bad <- numeric()
z <- x[1:2,]
nc <- ncol(x)
a <- table(x[,1])
twos <- names(a[a==2])
for (im in twos) {
	ind <- which(x[,1] == im)
	i <- ind[1]
	j <- ind[2]
	ov <- per_over(x$xmin[i],x$ymin[i],x$xmax[i],x$ymax[i],x$xmin[j],x$ymin[j],x$xmax[j],x$ymax[j])
	if (ov < 0.75) next
#	if (x$confidence[i] > x$confidence[j]) bad <- c(bad,j)
	if (x[i,nc] > x[j,nc]) bad <- c(bad,j)
	else y <- bad <- c(bad,i)
	z <- rbind(z,x[ind,])
}

write.csv(x[-bad,],outfile,quote=FALSE,row.names=FALSE)
z <- z[-(1:2),]
write.csv(z,"processed_images.csv",quote=FALSE,row.names=FALSE)
