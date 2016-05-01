include "cumulative.mzn";

int: n; % number of objects;
int: C; % maximum consumptionof a facility at each moment

% objects == tasks
set of int: Tasks = 1..n;
array[Tasks] of int: d; % due times
array[Tasks] of int: r; % release times
array[Tasks] of int: c; % consumption rates
array[Tasks] of int: p; % processing times

% start time's domain is an interval <0, maximum of due times>
array[Tasks] of var 0..max(d): s;

% sum of consumption rates cannot exceed C at any moment
constraint cumulative(s, p, c, C);

% A task cant start before its release time
constraint forall(j in Tasks)(s[j] >= r[j]);
% A task cant run longer than its due time
constraint forall(j in Tasks)(s[j] <= d[j] - p[j]);

% Minimize total time (so the last start time)
solve minimize max(s);

output [ "start = ", show(s), "\n"];