var 1..150: Gedeone;
var 1..150: Dario;
var 1..150: Umberto;
var 1..150: DarioPassato;
var 1..150: GedeonePassato;

constraint GedeonePassato = Dario + 11;
constraint GedeonePassato = DarioPassato * 6; 
constraint Gedeone - GedeonePassato = Dario - DarioPassato;
constraint Umberto = Dario + 3;
constraint Umberto = Gedeone - Dario - 3;

solve satisfy;