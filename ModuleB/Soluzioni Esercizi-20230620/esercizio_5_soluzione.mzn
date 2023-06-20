include "globals.mzn"; 

int: num_jobs;
int: num_machines;

array[1..num_jobs, 1..num_machines] of int: job_duration;
array[1..num_jobs, 1..num_machines] of int: job_order;
int: max_time;

% risorse richieste da ogni job (ognuno richiede un numero di risorse pari a 1)
array[1..num_jobs] of int: resources;

%% VARIABILI DECISIONALI

% tempo di inizio e di fine di ogni job
array[1..num_jobs, 1..num_machines] of var 1..max_time: job_start;
array[1..num_jobs, 1..num_machines] of var 1..max_time: job_end;

% funzione obiettivo
var 0..max_time: earliest_end_time = max([job_end[job,machine] | job in 1..num_jobs, machine in 1..num_machines]);
solve minimize earliest_end_time;

%% VINCOLI

% calcolo il tempo di termine dei job per usarlo nella funzione obiettivo
constraint
    forall(job in 1..num_jobs, machine in 1..num_machines) (
        job_end[job,machine] = job_start[job,machine] + job_duration[job,machine]
    );

% ogni macchina può eseguire un solo lavoro per volta
constraint forall(machine in 1..num_machines) (
       cumulative([job_start[job,machine] | job in 1..num_jobs],
                  [job_duration[job,machine] | job in 1..num_jobs],
                  resources,
                  1)
    );
    
% verifico che l'ordine dei lavori sia rispettato
constraint forall(job in 1..num_jobs) (
      forall(machine1,machine2 in 1..num_machines where machine1 < machine2 /\ job_order[job,machine1] < job_order[job,machine2]) (
             job_end[job,machine1] <= job_start[job,machine2]
      )
   );

constraint forall(job in 1..num_jobs) (
      forall(machine1,machine2 in 1..num_machines where machine1 < machine2 /\ job_order[job,machine1] > job_order[job,machine2]) (
             job_start[job,machine1] >= job_end[job,machine2]
      )
   );

output 
[
  "\nEarliest end time: " ++ show(earliest_end_time) ++ "\n" ++
  "\nJob duration:"
]
++
[ 
  if machine = 1 then "\n" else " " endif ++
    show(job_duration[job,machine])
  | job in 1..num_jobs, machine in 1..num_machines
]
++ 
["\n\nMachine order"] 
++
[  if machine = 1 then "\n" else " " endif ++
     show(job_order[job,machine])
   | job in 1..num_jobs, machine in 1..num_machines
]
++
[ "\n\njob_start:\n", show2d(job_start), "\n",
  "\njob_end:\n", show2d(job_end), "\n" 
] 
++
[ "\n\nSchedule\n"]
++
[
  if machine = 1 then "\n" ++ show(job) ++ " : "  else " " endif ++
       show(job_start[job,machine]) ++ ".." ++ 
       show(job_end[job,machine]) ++ " "
  | job in 1..num_jobs, machine in 1..num_machines
]
++
[ "\n\nEarliest end time: " ++ show(earliest_end_time) ++ "\n" ]
++
["\n"];