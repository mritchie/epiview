# ________________________________________________________________________________________
# <><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><>
#
#	This demo draw human chromosome ideogram and data tracks for:
#
#	1.	Connectors
#	2.	Gene lables
#	3.	Heatmap
#	4.	Scatterplot 
#	5.	Line plot
#	6.	Histogram
#	7.	Tile plot
#	8.	Link lines
#
# ________________________________________________________________________________________
# <><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><RCircos DEMO><>


RCircos.Demo.Human <- function(input, output)
{
	#	Load RCircos package and defined parameters
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
	library(RCircos);


	#	Load human cytoband data 
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	data(UCSC.HG19.Human.CytoBandIdeogram);
	cyto.info <- UCSC.HG19.Human.CytoBandIdeogram;


	#	Setup RCircos core components:
	#
	#	1. Chromosome ideogram plot information
	#	2. x and y coordinates for a circular line and degrees of the
	#		text rotation at each point
	#	3. Plot parameters for image plot control
	#  
	#	These components will be stored in RCircos environment
	#
	#	Function arguments:
	#
	#	Chromosome ideogram data loaded above
	#	Chromosomes need be excluded from cytoinfo
	#	Number of tracks inside chromosome ideogram
	#	Number of tracks inside chromosome ideogram
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# newchrom = 11
	exclude = c(1:22,'X','Y')
	include = input$newchrom
  chroms = strsplit(input$newchrom,split=",")
  if (length(chroms[[1]]) == 0) chroms = c("default")
  #print(chroms)
  for (chrom in chroms){
    print(c('chrom',chrom))
    if (!grepl('-',chrom)) exclude = exclude[which(exclude != chrom)]
      else {    # range entered
    print("processing range")
    chromrange = strsplit(chrom,'-')[[1]]  # Identify range
    print(c(chromrange[1],chromrange[2]))
    for (ch in chromrange[1]:chromrange[2]) exclude = exclude[which(exclude != ch)]
      }
  }
  print(exclude)
	for (chrom in include) exclude = exclude[which(exclude != chrom)]
		#newchrom <- 11 #readline("Enter new chromosome to include: ")
	#} 
	if (length(exclude) == 24) exclude = c()	# Include all if none chosen
	exclude = paste0('chr',exclude)   # vector of excluded chromosomes 

	RCircos.Set.Core.Components(cyto.info, exclude, 10, 0);

	#outname = paste("Human",exclude,collapse=TRUE)  #TODO: concatenate to make filename
	#print(outname)
	#	Open the graphic device (here a pdf file)
	#
	#png(file="RCircos.Demo.Human.png", height=8, width=8, unit="in", type="cairo", res=300);
	#
 	#	tiff(file="RCircos.Demo.Human.tif", height=8, width=8, unit="in", 
	#		type="cairo", res=300);
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	cat("Open graphic device and start plot ...\n");
	#pdf(file="RCircos.Demo.Human.pdf", height=8, width=8);

	RCircos.Set.Plot.Area();
	title("RCircos 2D Track Plot with Human Genome");


	#	Draw chromosome ideogram
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	cat("Draw chromosome ideogram ...\n");
	RCircos.Chromosome.Ideogram.Plot();


	#	Connectors in first track and gene names in the second track. 
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	cat("Add Gene and connector tracks ...\n");
	data(RCircos.Gene.Label.Data);

	track.num <- 1;
	direction <- "in";
	RCircos.Gene.Connector.Plot(RCircos.Gene.Label.Data, 
			track.num, direction);
	name.col <- 4;
	track.num <- 2;
	RCircos.Gene.Name.Plot(RCircos.Gene.Label.Data, name.col, 
			track.num, direction);


	#	Heatmap plot.  Since some gene names plotted above are longer 
	#	than one track height, we skip two tracks 
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" # readline("Add heatmap track (y/n): ");
	if (input$heatmap){
		data(RCircos.Heatmap.Data);
		data.col <- 6;
		track.num <- 5;	
		RCircos.Heatmap.Plot(RCircos.Heatmap.Data, data.col, track.num, "in");
	}	

	#	Scatterplot
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" #readline("Add scatterplot track (y/n): ");
	if (input$scatterplot){
	data(RCircos.Scatter.Data);
	data.col <- 5;
	track.num <- 6; 
	RCircos.Scatter.Plot(RCircos.Scatter.Data, data.col, track.num, "in", 1);
	}

	#	Line plot.
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" #readline("Add line plot track (y/n): ");
	if (input$line){
	data(RCircos.Line.Data);
	data.col <- 5;
	track.num <- 7;
	RCircos.Line.Plot(RCircos.Line.Data, data.col, track.num, "in");
	}

	#	Histogram plot
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" #readline("Add histogram track (y/n): ");
	if (input$histogram){
	data(RCircos.Histogram.Data);
	data.col <- 4;
	track.num <- 8; 
	RCircos.Histogram.Plot(RCircos.Histogram.Data, data.col, track.num, "in");
	}

	#	Tile plot. Note: tile plot data have chromosome locations and each
	#	data file is for one track
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" #readline("Add tile track (y/n): ");
	if (input$tiletrack){
	data(RCircos.Tile.Data);
	track.num <- 9;
	RCircos.Tile.Plot(RCircos.Tile.Data, track.num, "in");
	}

	#	Link lines. Link data has only paired chromosome locations in
	#	each row and link lines are always drawn inside of chromosome 
	#	ideogram.
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	#rdline = readline("Add link track ...\n");	# Will probably remove this bit
	#if (rdline == 'y' & FALSE){
	#data(RCircos.Link.Data);
	#track.num <- 11;
	#RCircos.Link.Plot(RCircos.Link.Data, track.num, FALSE);
	#}

	#	Close the graphic device and clear memory
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	#dev.off();
	cat("R Circos Demo Done ...\n\n");
	rm(list=ls(all=T));
}












