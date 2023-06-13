include "globals.mzn";

int: NumCars;
enum Colors;
array[1..NumCars] of Colors: CarColors;
int: MaxD;

%% VARIABILI DECISIONALI
array[1..NumCars, 1..NumCars] of var 0..1: pos;

constraint forall(i in 1..NumCars)
  (sum([pos[i,j] | j in 1..NumCars where j >= i - MaxD /\ j <= i + MaxD]) = 1 
   /\
   sum([pos[j,i] | j in 1..NumCars]) = 1);


%% FUNZIONE OBIETTIVO 
var int: changes = sum([pos[x,j]*pos[y,j+1] | x in 1..NumCars, y in 1..NumCars, j in 1..NumCars-1 where CarColors[x] != CarColors[y]]);

solve minimize changes;