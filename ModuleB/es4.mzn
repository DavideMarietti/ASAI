var int : Gedeone;
var int : Fra;
var int : Dario;
var int : DarioPassato;
var int : Umberto;
var int : GedeonePassato;

constraint Fra = 11;
constraint GedeonePassato = Dario + 11;
constraint GedeonePassato = DarioPassato * 6;
constraint Gedeone - GedeonePassato = Dario - DarioPassato;
constraint Umberto = Dario + 3;
constraint Umberto = Gedeone - Dario - 3;

solve satisfy;