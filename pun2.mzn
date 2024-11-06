%2.% Paso 1: Definir las variables principales
int: P1 = 4;
int: P2 = 3;
int: P3 = 5;
int: P4 = 2;
int: P5 = 1;
array[1..5] of int: vol = [4, 3, 5, 2, 1]; % Volúmenes de productos
% Estanterías disponibles
set of int: Estanterias = 1..3;
array[1..5] of var Estanterias: Ei; % Estanterías asignadas
% Paso 4: Definir las restricciones de entrega y prioridad
array[1..5] of int: tiempo_entrega = [2, 5, 3, 1, 4]; % Tiempos de entrega
array[1..5] of int: prioridad = [3, 1, 2, 5, 4]; % Prioridades
% Paso 5: Definir la capacidad de las estanterías
array[1..3] of int: capacidad = [8, 6, 5]; % Capacidades de las estanterías
% Paso 6: Compatibilidad de productos usando una lista de pares incompatibles
set of int: incompatibles = { (1, 4), (2, 3) }; % P1 y P4 incompatibles, P2 y P3 incompatibles
% Paso 8: Restricciones
% Capacidad de las estanterías
constraint forall(e in Estanterias) (
sum([vol[p] | p in 1..5 where Ei[p] == e]) <= capacidad[e]
);
% Compatibilidad entre productos
constraint forall(i, j in incompatibles) (
Ei[i] != Ei[j]
);
% Paso 9: Minimizar el espacio total utilizado
var int: espacio_usado = sum(e in Estanterias) (
max(0, capacidad[e] - sum([vol[p] | p in 1..5 where Ei[p] == e]))
);
solve minimize espacio_usado;
% Paso 10: Salida
output ["Estantería asignada para cada producto: ", show(Ei), "\n"];


