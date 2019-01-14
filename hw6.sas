proc print data=a;
run;

goption reset=all;
proc reg data=a;
model y=x;
plot y*x;
run;
quit;

data temp;
set a;
alpha=1.65;
beta=y-alpha;
run;

proc gplot data=temp;
plot alpha*beta;
run;


proc nlin data=a;
parms alpha=1.6579 beta=1.2 theta=23;
model y=alpha+(beta*x)/(theta+x);
output out=nlout p=pr;
run;

goption reset=all;
proc gplot data=nlout;
plot (y pr)*x/overlay;
  symbol1 i=none v=plus;
  symbol2 i=join v=none; 
run;
quit;






******question 2 ************************;
proc print data=b;
run;

data b;
set b;
logtime=log(T);
run;

proc genmod data=b;
model Y= X Z /offset=logtime dist=p;
output out=pout resdev=rs;
run;

proc univariate data=pout noprint;
var rs;
qqplot rs/normal;
run;





