dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW4B.doc';


data PainRelief;
input PainLevel Codeine Acupuncture Relief @@;
datalines;
1 1 1 0.0  1 2 1 0.5  1 1 2 0.6  1 2 2 1.2
2 1 1 0.3  2 2 1 0.6  2 1 2 0.7  2 2 2 1.3
3 1 1 0.4  3 2 1 0.8  3 1 2 0.8  3 2 2 1.6
4 1 1 0.4  4 2 1 0.7  4 1 2 0.9  4 2 2 1.5
5 1 1 0.6  5 2 1 1.0  5 1 2 1.5  5 2 2 1.9
6 1 1 0.9  6 2 1 1.4  6 1 2 1.6  6 2 2 2.3
7 1 1 1.0  7 2 1 1.8  7 1 2 1.7  7 2 2 2.1
8 1 1 1.2  8 2 1 1.7  8 1 2 1.6  8 2 2 2.4
;
run;



/*************************** factorial ANOVA ******************************/

proc anova data=PainRelief;
class PainLevel Codeine Acupuncture;
model Relief=PainLevel Codeine|Acupuncture;
run;



/********* multiple comparison for the different pairs of pain level ***********/


* Scheffe’s method;

proc glm data = PainRelief;
class PainLevel;
model Relief = PainLevel;
means PainLevel / scheffe;
run;

* Boxplot;

proc sort data=PainRelief;by PainLevel;run;
proc boxplot data=PainRelief;
plot Relief*PainLevel/boxstyle=schematic;
run;


ods rtf close;
