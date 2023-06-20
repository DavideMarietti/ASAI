include "globals.mzn";
var 1..5 : X; 
var int : PrezzoX;
constraint element(X, [10,5,6,8,11], PrezzoX);
var 1..5 : Y; var int : PrezzoY;
constraint element(Y, [10,5,6,8,11], PrezzoY);
constraint X != Y;
constraint PrezzoX + PrezzoY < 15;
solve satisfy;