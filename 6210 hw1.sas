
proc univariate data=hw;
var x;
run;

title 'Analysis of Variable x for testing mu0=23';
ods select TestsForLocation LocationCounts;
proc univariate data=hw mu0=23 loccount;
   var x;
run;

title 'Histogram of variable x and its fiting curve';
ods graphics on;
proc univariate data=hw noprint;
   histogram x / odstitle = title;
run;

title 'Histogram of variable x and its fiting curve';
proc univariate data=hw noprint;
   histogram x / midpoints    = 22 to 24 
                     rtinclude
					 cprop
                     normal(noprint)
                     odstitle     = title;
run;


title 'Normal Quantile-Quantile Plot for variable x';
ods graphics on;
proc univariate data=hw noprint;
   qqplot x / odstitle = title
              outqqplot=;
run;


title 'Histogram of variable x with different y value ';
proc univariate data=hw noprint;
class y;
   histogram x / midpoints    = 22 to 24 
                     rtinclude
					 cprop
                     normal(noprint)
					 ncols=1
					 nrows=3
                     odstitle     = title;
	inset mean std="Std Dev" / pos = ne format = 6.3;
run;

proc sort data=hw out=hwy;
by y;
run;

ods graphics on;
ods select Plots SSPlots;
title 'boxplot of variable with differnt y values';
proc univariate data=hwy plot;
   by y;
   var x;
run;


title 'Histogram of variable x with different z value ';
proc univariate data=hw noprint;
class z;
   histogram x / midpoints    = 22 to 24 
                     rtinclude
					 cprop
                     normal(noprint)
					 ncols=1
					 nrows=3
                     odstitle= title;
    inset mean std="Std Dev" / pos = ne format = 6.3;
run;

proc sort data=hw out=hwz;
by z;
run;

ods graphics on;
ods select Plots SSPlots;
title 'boxplot of variable with differnt z values';
proc univariate data=hwy plot;
   by z;
   var x;
run;



proc sort data=hw2 out=hw2x;
by x;
run;

proc sort data=hw2 out=hw2y;
by y;
run;

title 'bar chart of z with differnt y and x values';
proc gchart data=hw2;
vbar3d y / sumvar=z subgroup=x inside=subpct
     outside=sum
     cframe=white
	 width=9
     space=7
     autoref cref=gray;
run;


title 'bar chart of z with differnt x values';
proc gchart data=hw2;
vbar3d x / sumvar=z
     inside=subpct
     outside=sum
     cframe=white
	 width=9
     space=7
     autoref cref=gray;
run;



















