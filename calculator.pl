% --- Табличные производные ---
diff(X, X, 1).              % d(x)/dx = 1
diff(C, X, 0) :- number(C). % d(C)/dx = 0 (если C - число)
diff(sin(U), X, CosU * DU)  :- diff(U, X, DU), CosU = cos(U).  % d(sin(U))/dx = cos(U) * dU/dx
diff(cos(U), X, -SinU * DU) :- diff(U, X, DU), SinU = sin(U).  % d(cos(U))/dx = -sin(U) * dU/dx
diff(exp(U), X, ExpU * DU)  :- diff(U, X, DU), ExpU = exp(U).  % d(exp(U))/dx = exp(U) * dU/dx

% --- Производная суммы ---
diff(U + V, X, DU + DV) :-
    diff(U, X, DU),
    diff(V, X, DV).

% --- Производная разности ---
diff(U - V, X, DU - DV) :-
    diff(U, X, DU),
    diff(V, X, DV).

% --- Производная произведения ---
diff(U * V, X, U * DV + V * DU) :-
    diff(U, X, DU),
    diff(V, X, DV).

% --- Производная частного ---
diff(U / V, X, (V * DU - U * DV) / (V * V)) :-
    diff(U, X, DU),
    diff(V, X, DV).

% --- Производная сложной функции (цепное правило) ---
diff(f(U), X, DF * DU) :-
    diff(U, X, DU),
    diff(f(U), U, DF).

% --- Частная производная ---
partial_diff(F, X, D) :- diff(F, X, D).

% --- Упрощение выражений (упрощенный вариант) ---
simplify(X, X) :- atomic(X), !.
simplify(A + 0, A) :- !.
simplify(0 + A, A) :- !.
simplify(A * 1, A) :- !.
simplify(1 * A, A) :- !.
simplify(A * 0, 0) :- !.
simplify(0 * A, 0) :- !.
simplify(A - 0, A) :- !.
simplify(A / 1, A) :- !.
simplify(A / A, 1) :- A \= 0, !.
simplify(Exp, Exp).  % Возвращает, если нет упрощения

% --- Пример работы ---
test :-
    diff(sin(x) + x^2, x, D),
    simplify(D, S),
    write('Производная: '), write(D), nl,
    write('Упрощенный результат: '), write(S), nl.
