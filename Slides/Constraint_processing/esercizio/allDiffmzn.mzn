include "globals.mzn";

 var 4..6:A;
 var 1..6:B;
 var 1..6:C;
 var 4..6:D;
 var 4..6:E;
 var 1..5:F;
 var 1..8:G;
 var 1..8:H;
 constraint alldifferent([ A , B ,C ,D ,E ,F , G , H ]);