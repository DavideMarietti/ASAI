var 0..6: Nonni;
var 0..10: Genitori;
var 0..40: Bambini;

constraint Nonni * 6 + Genitori * 4 + Bambini = 40;
constraint Nonni + Genitori + Bambini = 20;

constraint Nonni > 0;
constraint Genitori > 0;
constraint Bambini > 0;

solve satisfy;