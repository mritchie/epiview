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
    #source("./RCircos/RCircos/R/RCircos.rdx")  # Need proper address to alter


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
    include = strsplit(input$newchrom,split=",")[[1]]
    
    #Remove spaces
    include = gsub(" ","",include,fixed=TRUE)

  if (length(include) == 0) include = c("default")
  print(include)
  for (chrom in include){
      print(c('chrom',chrom))
    if (!grepl('-',chrom)) exclude = exclude[which(exclude != chrom)]
      else {    # range entered
          print("processing range");
    chromrange = strsplit(chrom,'-')[[1]];  # Identify range
    for (ch in chromrange[1]:chromrange[2]) exclude = exclude[which(exclude != ch)];
      }
  }
	for (chrom in include) exclude = exclude[which(exclude != chrom)]
	if (length(exclude) == 24) exclude = c();	# Include all if none chosen
	exclude = paste0('chr',exclude);   # vector of excluded chromosomes
	RCircos.Set.Core.Components(cyto.info, exclude, 10, 0);

	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    print("cat");
	cat("Open graphic device and start plot ...\n");
	#pdf(file="RCircos.Demo.Human.pdf", height=8, width=8);
    print("RCircos.Set.Plot>Area");
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
	track.num <- 1;
	direction <- "in";
	name.col <- 4;
	track.num <- 2;
    data(RCircos.Gene.Label.Data);
    RCircos.Gene.Connector.Plot(RCircos.Gene.Label.Data,track.num, direction);
    RCircos.Gene.Name.Plot(RCircos.Gene.Label.Data, name.col,track.num, direction);
    
	#	Heatmap plot.  Since some gene names plotted above are longer 
	#	than one track height, we skip two tracks 
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	if (input$heatmap){
		data.col <- 6;
		track.num <- 5;	
        data(RCircos.Heatmap.Data);
        RCircos.Heatmap.Plot(RCircos.Heatmap.Data, data.col, track.num, direction);
	}

	#	Scatterplot
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    if (input$scatterplot){
        data.col <- 5;
        track.num <- 6;
        data(RCircos.Scatter.Data);
        RCircos.Scatter.Plot(RCircos.Scatter.Data, data.col, track.num, direction, 1);
	}

	#	Line plot.
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	if (input$line){
        data.col <- 5;
        track.num <- 7;
        data(RCircos.Line.Data);
        RCircos.Line.Plot(RCircos.Line.Data, data.col, track.num, direction);
	}

	#	Histogram plot
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    print(input$histonefile$name)
	if (input$histogram){
        data.col <- 4;
        track.num <- 8;
        
        # If no histone file selected use default
        if (is.null(input$histonefile)) histonename = "RCircos.Histogram.Data"
        else {
            histonename = input$histonefile$name
            # Remove '.RData' from end if necessary
            if (substr(histonename,nchar(histonename)-4,nchar(histonename))=="RData"){
            histonename = substr(histonename,1,nchar(histonename)-6)
            }
        }
        # read data
        readstring = paste("data(",histonename,")");
        eval(parse(text=readstring));
        #plot data
        RCircos.Histogram.Plot(eval(parse(text=histonename)), data.col, track.num, direction);
    }
    

	#	Tile plot. Note: tile plot data have chromosome locations and each
	#	data file is for one track
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	# rdline = "y" #readline("Add tile track (y/n): ");
	if (input$tiletrack){
	data(RCircos.Tile.Data);
	track.num <- 9;
	RCircos.Tile.Plot(RCircos.Tile.Data, track.num, direction);
	}

	#	Link lines. Link data has only paired chromosome locations in
	#	each row and link lines are always drawn inside of chromosome 
	#	ideogram.
	#  	_________________________________________________________________
	#	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	data(RCircos.Link.Data);
	track.num <- 11;
	RCircos.Link.Plot(RCircos.Link.Data, track.num, FALSE);
	#}

	cat("R Circos Demo Done ...\n\n");
	rm(list=ls(all=T));
}












