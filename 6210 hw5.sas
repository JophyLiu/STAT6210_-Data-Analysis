goption reset=all;
proc gplot data=hw1;
plot x*y;
run;

proc corr data=hw1;
run;

proc corr spearman nosimple;
run;

proc kde data=hw1 out=result1;
var x y;
run;

proc gcontour data=result1;
plot x*y=density;
run;

ods graphics on;
proc kde data=hw1;
   bivar x y / plots=all;
run;
ods graphics off;


data anno;
  set hw1;
  retain xsys ysys '2' function 'SYMBOL' text 'CIRCLE';
  y=y;
  x=x;
run;
proc kde data=hw1 out=result2 bwm=.5,.5;
  var x y;
run;
proc gcontour data=result2;
  plot x*y=density / nlevels=25 nolegend  annotate=anno;
run;

proc kde data=hw1 out=result3 bwm=1,1;
  var x y;
run;
proc gcontour data=result3;
  plot x*y=density / nlevels=25 nolegend  annotate=anno;
run;
proc kde data=hw1 out=result4 bwm=2,2;
  var x y;
run;


ods graphics off;
proc gcontour data=result4;
  plot x*y=density / nlevels=25 nolegend  annotate=anno;
run;



proc g3d data=result2;
 plot x*y=density /rotate=30 tilt=45;
run;

proc g3d data=result3;
 plot x*y=density /rotate=30 tilt=45;
run;

proc g3d data=result4;
 plot x*y=density /rotate=30 tilt=45;
run;


ods graphics on;
proc kde data=hw1;
   bivar (x y) (x (bwm=0.5) y (bwm=0.5))/ plots=all;
run;



ods graphics on;
proc corr data=hw2 plots=matrix(histogram);
run;

goptions reset=all;
proc gplot data=hw2;
plot weight*age;
run;
proc corr data=hw2;
var weight; 
with age;
run;

proc corr data=hw2;
var weight;
with age;
partial height;
run;

data female;
set hw2;
if  sex='f';
run;

data male;
set hw2;
if  sex='m';
run;

proc corr data=female;
var weight;
with age;
partial height;
run;

proc corr data=male;
var weight;
with age;
partial height;
run;

proc sort data=hw2;
by age;
run;
proc print hw2;
run;

goptions reset=all;
proc reg data=hw2;
  model weight=age ;
  output out=regout p=pr uclm=upper lclm=lower;
  plot weight*age / conf;
run;

goptions reset=all;
symbol1 v=circle i=none c=black;
symbol2 v=none i=join c=gray l=2;
symbol3 v=none i=join c=gray l=3;
symbol4 v=none i=join c=gray l=3;
proc gplot data=regout;
  plot (weight pr upper lower)*age / overlay;
run;


ods graphics on;

proc loess data=hw2;
   ods output OutputStatistics = loessresult
              FitSummary=Summary;
   model weight = age / degree=2 select=AICC(steps) smooth = 0.6 1.0
                   direct alpha=.05 all details;
run;

ods graphics off;

proc loess data=hw2;
  model weight=age /  smooth=.99;
ods output Outputstatistics=lofit;
run;

proc loess data=hw2;
  model weight=age /  smooth=.01;
ods output Outputstatistics=lofit2;
run;

data lofit2 (keep = pred2);
set lofit2;
pred2 = pred;
run;

data both;
  set regout;
  set lofit;
  set lofit2;
run;

goptions reset=all;
symbol1 v=circle i=none c=black;
symbol2 v=none i=join c=blue l=1;
symbol3 v=none i=join c=red l=2;
symbol4 v=none i=join c=green l=3;
proc gplot data=both;
  plot (weight pr pred pred2)*age / overlay;
run;

