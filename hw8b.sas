dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW8B.doc';

proc print data=b;
run;

proc genmod data=b;
model y=x z/dist=poisson scale=d;
run;

proc gam data=b;
model y=loess(x) loess(z)/dist=poisson;
output out=output all;
run;




proc sort data=output;
by x;
run;
goptions reset=all;
symbol1 i=joint v=dot c="black";
symbol2 i=joint v=none c="blue";
symbol3 i=joint v=none c="blue";
proc gplot data=output;
  plot (p_x uclm_x lclm_x)*x /overlay;
run;

proc sort data=output;
by z;
run;
goptions reset=all;
symbol1 i=joint v=dot c="black";
symbol2 i=joint v=none c="blue";
symbol3 i=joint v=none c="blue";
proc gplot data=output;
  plot (p_z uclm_z lclm_z)*z /overlay;
run;

ods rtf close;







