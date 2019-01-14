dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW9A.doc';

/******************   HW9A  *********************/

/*
Compare the survivor functions estimated by the product-limit and life-table methods
*/

proc lifetest data=HW9A plots=(s) outsurv=temp;
  time time*status(1);
run;


proc lifetest data=HW9A method=life plots=(h,s) outsurv=templt;
  time time*status(1);   
run;




/*
Generate confidence intervals for the survivor function estimated by the product-limit method
*/

goptions reset=all;
symbol1 i=join v=none c=black;
symbol2 i=join v=none l=2 c=blue;
symbol3 i=join v=none l=2 c=blue;
proc gplot data=temp;
plot (survival sdf_lcl sdf_ucl)*time / overlay;
run;




/*
Generate confidence intervals for the hazard function estimated by the life-table method
*/

proc gplot data=templt;
plot (hazard haz_lcl haz_ucl)*time / overlay;
run;



/*
With the consideration of group information, compare the survivor functions of different groups estimated by the product-limit method
*/

goptions reset=all;
symbol1 i=join v=none c=black;
symbol2 i=join v=none c=yellow;
symbol3 i=join v=none c=red;
proc lifetest data=HW9A plots=(s) outsurv=tempgroup;
  time time*status(1);
  strata group / test=(all);
run;



ods rtf close;
