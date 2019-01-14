data hw2;
 input v1 v2;
 variable=v1; group='x'; output;
 variable=v2; group='y'; output;
 drop v1 v2;
cards;
134.6	-120.3
99.5	34.3
54.6	104.7
-191.3	438.2
192.1	1.2
137.2	255.9
-125	466.8
48	247.4
-10.4	355.7
-61.6	338.4

;

proc sort data=hw2; 
  by group;
run;

title 'The boxplot for unpaired variable';
proc boxplot data=hw2;
  plot variable*group /boxstyle=schematic;
run;

title'The qqpolt of unpaired variable';
symbol v=circle;
proc univariate data=hw2;
by group;
qqplot variable / normal;
run;
goptions reset=all;


proc ttest data=hw2;
  var variable;
  class group;
run;

proc npar1way data=hw2 wilcoxon;
  var variable;
  class group;
run;



data hw;
 input x y;
cards;
134.6	-120.3
99.5	34.3
54.6	104.7
-191.3	438.2
192.1	1.2
137.2	255.9
-125	466.8
48	247.4
-10.4	355.7
-61.6	338.4

;
data hw2;
set hw;
variable = x;
group = 'x';
output;
variable = y;
group = 'y';
output;
run;


proc corr data=hw2;
var x y;
run;


proc ttest data=hw2;
  paired x*y;
run;

data hw22;
set hw;
 difference=x-y;
run;

proc univariate data=hw22;
  var difference;
run;



data hw;
input Gender $ Treatment $ Response $ n;
cards;
Female Active Better 16
Female placebo Better 5
Female Active Same 11
Female placebo Same 20
Male Active Better 12
Male placebo Better 7
Male Active Same 16
Male placebo Same 19
;
run;

ods graphics on;
proc freq data=hw order=data;
   tables Treatment*Response / chisq cellchi2 expected norow nocol;
   weight n;
run;
goptions reset=all;

ods graphics on;
proc freq data=hw order=data;
   tables Gender*Treatment*Response /
          chisq cmh plots(only)=freqplot(twoway=cluster) relrisk plots(only)=relriskplot(stats);
   weight n;
run;
ods graphics off;












