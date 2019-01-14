dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW4A.doc';




data drugtest; 
input Drug $ PreTreatment PostTreatment @@; 
datalines; 
A 11  6   A  8  0   A  5  2   A 14  8   A 19 11 
A  6  4   A 10 13   A  6  1   A 11  8   A  3  0 
D  6  0   D  6  2   D  7  3   D  8  1   D 18 18 
D  8  4   D 19 14   D  8  9   D  5  1   D 15  9 
F 16 13   F 13 10   F 11 18   F  9  5   F 21 23 
F 16 12   F 12  5   F 12 16   F  7  1   F 12 20 
; 
run;

proc print data=drugtest;
run;


goptions reset=all;
symbol v=dot;
proc boxplot data=drugtest;
plot PostTreatment*Drug;
run;

proc boxplot data=drugtest;
plot preTreatment*Drug;
run;



proc gplot data=drugtest;
plot PostTreatment*PreTreatment=Drug;
run;



proc glm; 
class Drug; 
model PostTreatment = Drug PreTreatment; 
run;

proc glm;
class Drug;
model PostTreatment =Drug | PreTreatment;
run;



/************ “PostTreatment?as response and “Drug?as factor *************/

*One-way ANOVA (parametric);

proc anova data=drugtest;
class Drug;
model PostTreatment=Drug;
run;


*One-way ANOVA with contrasts;

proc glm data=drugtest;
class Drug;
model PostTreatment=Drug;
contrast 'A vs. F' Drug 1 0 -1;
contrast 'D vs. F' Drug 0 1 -1;
contrast 'A & D vs. F' Drug 1 1 -2;
run;

*Nonparametric one-way ANOVA (Kruskal-Wallis rank sum test);

proc npar1way data=drugtest wilcoxon;
class drug;
var PostTreatment;
run;






/************ “PreTreatment?as response and “Drug?as factor *************/

*One-way ANOVA (parametric);

proc anova data=drugtest;
class Drug;
model PreTreatment=Drug;
run;

*One-way ANOVA with contrasts;

proc glm data=drugtest;
class Drug;
model PreTreatment=Drug;
contrast 'A vs. F' Drug 1 0 -1;
contrast 'D vs. F' Drug 0 1 -1;
contrast 'A & D vs. F' Drug 1 1 -2;
run;

*Nonparametric one-way ANOVA (Kruskal-Wallis rank sum test);

proc npar1way data=drugtest wilcoxon;
class drug;
var PreTreatment;
run;








/************ overall correlation between the variables “PreTreatment?and “PostTreatment?*************/

ods graphics on;
proc corr data=drugtest pearson spearman plots=scatter(alpha=0.2 0.3 ) plots=matrix(histogram);
 var PostTreatment PreTreatment;
run;
ods graphics off;






/************ within-group correlation between the variables “PreTreatment?and “PostTreatment?*************/

data drugtest1;
set drugtest;
Drug=tranwrd(Drug,'A',"1");
Drug=tranwrd(Drug,'D',"2");
Drug=tranwrd(Drug,'F',"3");
Druggroup=Drug-0;
*drop sex;
run;
proc print data=drugtest1;
run;


ods graphics on;
proc corr data=drugtest1 pearson spearman  plots=scatter(alpha=0.2 0.3 ) plots=matrix(histogram);
 var PostTreatment PreTreatment;
 partial Druggroup;
run;
ods graphics off;

ods rtf close;
