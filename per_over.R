per_over <- function(xmin1,ymin1,xmax1,ymax1,xmin2,ymin2,xmax2,ymax2) {
	x <- min(xmax1,xmax2) -max(xmin1,xmin2)
	if (x < 0) return(0)
	y <- min(ymax1,ymax2) -max(ymin1,ymin2)
	if (y < 0) return(0)
	s <- (x+1)*(y+1)
	S <- min((xmax1-xmin1+1)*(ymax1-ymin1+1),(xmax2-xmin2+1)*(ymax2-ymin2+1))
	return(s/S)
}
