% Use this editor as a MiniZinc scratch book
%1.
int: n_disciplinas=4;%n disciplinas
int: n_participantes=6;%participantes
int: n_lugares=2;%lugares
array[1..n_disciplinas] of var 0..10:Di;%horarios inicio disciplinas
array[1..n_disciplinas]of var 1..n_lugares:Li;%lugares asignados a disciplina
array[1..n_disciplinas, 1..n_participantes] of var bool:Pi_j;%matriz booleana que indica si el participante j esta asigna a la disciplina i
array[1..n_disciplinas]of int : duraciones=[2,3,1,2];
%Restricciones
constraint forall(i, j in 1..n_disciplinas where i!=j)( forall(p in 1..n_participantes)(
if Pi_j[i,p]==1/\ Pi_j[j,p]==1 then Di[i]+duraciones[i]<=Di[j]\/ Di[j]+duraciones[j]<=Di[i]
endif));
constraint forall(i,j in 1..n_disciplinas where i!=j)(
if Li[i]==Li[j]then Di[i]+duraciones[i]<=Di[j]\/Di[j]+duraciones[j]<=Di[i]
endif);
int:capacidad_L1=5;
int:capacidad_L2=6;
constraint
sum([duraciones[i]| i in 1..n_disciplinas where Li[i]==1])<=capacidad_L1 /\
sum([duraciones[i]| i in 1..n_disciplinas where Li[i]==2])<=capacidad_L2;
var int:tiempo_total=max([Di[i]|i in 1..n_disciplinas]);
solve minimize tiempo_total;
output [
"Horarios de las disciplinas: ", show(Di), "\n",
"Lugares asignados: ", show(Li), "\n",
"Participantes asignados: ", show(Pi_j), "\n",
"Tiempo total del evento: ", show(tiempo_total)
];
