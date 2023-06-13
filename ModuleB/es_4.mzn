% lista ingredienti
enum Ingredienti = {Carne, Pane, Formaggio, Cipolla, Cetriolo, Lattuga, Ketchup, Pomodoro}; 

enum DatiNutrizionali = {Sodio, Grassi, Calorie};

% matrice di dati
array[Ingredienti, 1..4] of int: Valori;

% per rendere il programma più dichiarativo e poter utilizzare
% LimitiNutrizionali[Sodio], LimitiNutrizionali[Grassi] e LimitiNutrizionali[Calorie]
array[DatiNutrizionali] of int : LimitiNutrizionali;


% variabili decisionali

% array che rappresenta la quantità di ogni ingrediente, da 1 a 8
array[Ingredienti] of var 1..8: porzioni;

% variabili booleane per i vincoli reificati
var bool: B0;
var bool: B1;
var bool: B2;


% funzione obiettivo
var int: costo = sum([porzioni[i]*Valori[i,4] | i in Ingredienti]);


% chiamata al solver
solve maximize costo;

% devo rispettare i limiti nutrizionali
constraint
   forall(j in DatiNutrizionali) (
     sum([porzioni[i]*Valori[i,j] | i in Ingredienti]) < LimitiNutrizionali[j]
   );

% la quantità di pomodoro è il doppio di quella di ketchup
constraint B0 <-> (porzioni[Ketchup] * 2 = porzioni[Pomodoro]);

% la quantità di pomodoro è uguale a quella di cetrioli
constraint B1 <-> (porzioni[Pomodoro] = porzioni[Cetriolo]);

% la quantità di cipolla è maggiore di quella di pomodoro
constraint B2 <-> (porzioni[Cipolla] > porzioni[Pomodoro]);

% almeno 2 dei 3 vincoli sopra devono essere soddisfatti
constraint bool2int(B0) + bool2int(B1) + bool2int(B2) >= 2;

% output formattato
output [
  "costo   : ", show(costo), " centesimi\n",
  "sodio   : ", show(sum([porzioni[i]*Valori[i,1] | i in Ingredienti])), " mg\n",
  "grassi  : ", show(sum([porzioni[i]*Valori[i,2] | i in Ingredienti])), " g\n",
  "calorie : ", show(sum([porzioni[i]*Valori[i,3] | i in Ingredienti])), "\n",
  "porzioni: ", show(porzioni), "\n",
]
++
[
  show(i) ++ ": \t" ++ show(porzioni[i]) ++ " (" ++ show_int(3,porzioni[i]*Valori[i,4]) ++ " centesimi)\n"
  | i in Ingredienti
]
;

% risultato
% costo   : 343 centesimi
% sodio   : 2890 mg
% grassi  : 148 g
% calorie : 2221
% porzioni: [6, 2, 2, 8, 3, 8, 3, 6]
% Carne: 	6 (150 centesimi)
% Pane: 	2 ( 30 centesimi)
% Formaggio: 	2 ( 20 centesimi)
% Cipolla: 	8 ( 72 centesimi)
% Cetriolo: 	3 (  9 centesimi)
% Lattuga: 	8 ( 32 centesimi)
% Ketchup: 	3 (  6 centesimi)
% Pomodoro: 	6 ( 24 centesimi)