include "globals.mzn";

enum Talento = {Piano, Matematica, Computer, Violino, Nuoto};
enum Figlio = {Anna, Carla, Stefano, Giovanna, Roberto};

array[Talento] of var Figlio: talento;
array[Figlio] of var 4..8 : eta;

constraint talento[Matematica] != Carla;
constraint eta[Carla] = 4;

constraint eta[talento[Computer]] = 1 + eta[Stefano];

constraint eta[talento[Violino]] = 7;

constraint eta[Giovanna] != 8;

constraint eta[Roberto] = 5;

constraint eta[Roberto] < eta[talento[Nuoto]];

constraint all_different(eta);
constraint all_different(talento);

solve satisfy;