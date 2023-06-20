include "globals.mzn";

int: NumCars;
enum Colors;
array[1..NumCars] of Colors: CarColors;
int: MaxD;

%% VARIABILI DECISIONALI

% Array che indica per ogni auto in che posizione si troverà nella sequenza finale 
array[1..NumCars] of var 1..NumCars: pos;

%% FUNZIONE OBIETTIVO

var int: changes = sum([pos[i]=pos[j]+1 | i,j in 1..NumCars where i!=j 
     /\ CarColors[i]!=CarColors[j]]);

solve minimize changes;

%% VINCOLI

% ogni auto nella sequenza finale può trovarsi al massimo a distanza +/- MaxD 
% rispetto alla sua posizione iniziale
constraint forall(i in 1..NumCars)
  (pos[i]-i <= MaxD);
constraint forall(i in 1..NumCars)
  (i-pos[i] <= MaxD);

% tutte le auto devono trovarsi in una posizione diversa della sequenza
constraint alldifferent(pos);


output ["Sequenza iniziale: \n"] ++ 
       [show(CarColors[i]) ++ " " | i in 1..NumCars] ++ 
       ["\nSequenza migliore trovata (cambi colore = " ++ show(changes) ++ "):\n"] ++ 
       [if i = fix(pos[j]) then show(CarColors[j]) ++ " " else "" endif | i,j in 1..NumCars];