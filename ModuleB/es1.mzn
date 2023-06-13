% Use this editor as a MiniZinc scratch book
var 1..6: nonni;
var 1..10: genitori;
var 1..40: bambini;

constraint nonni + genitori + bambini = 20;
constraint nonni*6 + genitori*4 + bambini = 40;


solve satisfy;