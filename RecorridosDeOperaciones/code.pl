:- module(_,_,[classic,assertions,regtypes]).
author_data('Naval','Rodriguez','Ernesto','C200343').

pos(Row, Col).

op(Op, Val) :-
    member(Op, [+, -, *, //]),
    number(Val).

cell(pos(_, _), op(_, _)).

board1([cell(pos(1 ,1),op(*,-3)),
cell(pos(1 ,2),op(-,1)),
cell(pos(1 ,3),op(-,4)),
cell(pos(1 ,4),op(- ,555)),
cell(pos(2 ,1),op(-,3)),
cell(pos(2 ,2),op(+ ,2000)),
cell(pos(2 ,3),op(* ,133)),
cell(pos(2 ,4),op(- ,444)),
cell(pos(3 ,1),op(*,0)),
cell(pos(3 ,2),op(* ,155)),
cell(pos(3 ,3),op(// ,2)),
cell(pos(3 ,4),op(+ ,20)),
cell(pos(4 ,1),op(-,2)),
cell(pos(4 ,2),op(- ,1000)),
cell(pos(4 ,3),op(-,9)),
cell(pos(4 ,4),op(*,4))]).


% efctuar_movimiento: posición resultante de moverse desde 
% Pos en la dirección indicada por Dir

efectuar_movimiento(pos(Row, Col), n, pos(NewRow, Col)) :-
    NewRow is Row - 1.
efectuar_movimiento(pos(Row, Col), s, pos(NewRow, Col)) :-
    NewRow is Row + 1.
efectuar_movimiento(pos(Row, Col), e, pos(Row, NewCol)) :-
    NewCol is Col + 1.
efectuar_movimiento(pos(Row, Col), o, pos(Row, NewCol)) :-
    NewCol is Col - 1.
efectuar_movimiento(pos(Row, Col), no, pos(NewRow, NewCol)) :-
    NewRow is Row - 1,
    NewCol is Col - 1.
efectuar_movimiento(pos(Row, Col), ne, pos(NewRow, NewCol)) :-
    NewRow is Row - 1,
    NewCol is Col + 1.
efectuar_movimiento(pos(Row, Col), so, pos(NewRow, NewCol)) :-
    NewRow is Row + 1,
    NewCol is Col - 1.
efectuar_movimiento(pos(Row, Col), se, pos(NewRow, NewCol)) :-
    NewRow is Row + 1,
    NewCol is Col + 1.


% movimiento_valido: Comprueba si es válido el movimiento en
% el tablero dado

movimiento_valido(N, pos(Row, _), n) :-
    NewRow is Row - 1,
    NewRow >= 1,
    NewRow =< N.

movimiento_valido(N, pos(Row, _), s) :-
    NewRow is Row + 1,
    NewRow >= 1,
    NewRow =< N.

movimiento_valido(N, pos(_, Col), e) :-
    NewCol is Col + 1,
    NewCol >= 1,
    NewCol =< N.

movimiento_valido(N, pos(_, Col), o) :-
    NewCol is Col - 1,
    NewCol >= 1,
    NewCol =< N.

movimiento_valido(N, pos(Row, Col), no) :-
    NewRow is Row - 1,
    NewCol is Col - 1,
    NewRow >= 1,
    NewRow =< N,
    NewCol >= 1,
    NewCol =< N.

movimiento_valido(N, pos(Row, Col), ne) :-
    NewRow is Row - 1,
    NewCol is Col + 1,
    NewRow >= 1,
    NewRow =< N,
    NewCol >= 1,
    NewCol =< N.

movimiento_valido(N, pos(Row, Col), so) :-
    NewRow is Row + 1,
    NewCol is Col - 1,
    NewRow >= 1,
    NewRow =< N,
    NewCol >= 1,
    NewCol =< N.

movimiento_valido(N, pos(Row, Col), se) :-
    NewRow is Row + 1,
    NewCol is Col + 1,
    NewRow >= 1,
    NewRow =< N,
    NewCol >= 1,
    NewCol =< N.


% select_cell extrae la celda con posición IPos de la lista Board obteniendo 
% La operación y una lista nueva sin esa celda
select_cell(IPos, Op, Board, NewBoard) :-
    select(cell(IPos, Op), Board, NewBoard).

% select_dir extrae una direccion Dir de la lista Dirs obteniendo una nueva lista
select_dir(Dir, Dirs, NewDirs) :-
    select(dir(Dir, 1), Dirs, NewDirs),
    !.

select_dir(Dir, [dir(Dir, N) | Rest], [dir(Dir, NewN) | Rest]) :-
    N > 1,
    NewN is N - 1.

select_dir(Dir, [Other | Rest], [Other | NewRest]) :-
    select_dir(Dir, Rest, NewRest).

%aplicar_op: aplica la operacion
aplicar_op(op(+, Operando), Valor, Valor2) :-
    Valor2 is Valor + Operando.

aplicar_op(op(-, Operando), Valor, Valor2) :-
    Valor2 is Valor - Operando.

aplicar_op(op(*, Operando), Valor, Valor2) :-
    Valor2 is Valor * Operando.

aplicar_op(op(//, Operando), Valor, Valor2) :-
    Valor2 is Valor // Operando.


%generar_recorrido: 

generar_recorrido(Ipos, N, Board, DireccionesPermitidas, Recorrido, Valor) :-
    generar_recorrido_aux(Ipos, N, Board, DireccionesPermitidas, [], 0, Valor, RecorridoRev),
    reverse(RecorridoRev, Recorrido).

generar_recorrido_aux(_, _, [], _, Recorrido, Valor, Valor, Recorrido).
generar_recorrido_aux(_, _, _, [], Recorrido, Valor, Valor, Recorrido).
generar_recorrido_aux(Ipos, N, Board, DireccionesPermitidas, RecorridoParcial, ValorIni, Valor, Recorrido) :-
    movimiento_valido(N, Ipos, Dir),
    select_dir(Dir, DireccionesPermitidas, NewDireccionesPermitidas),
    select_cell(Ipos, Op, Board, NewBoard),
    efectuar_movimiento(Ipos, Dir, NewPos),
    aplicar_op(Op, ValorIni, NewValor),
    generar_recorrido_aux(NewPos, N, NewBoard, NewDireccionesPermitidas, [(Ipos, NewValor) | RecorridoParcial], NewValor, Valor, Recorrido).


generar_recorridos(N, Board, DireccionesPermitidas, Recorrido, Valor) :-
    generar_posiciones(N, Pos),
    generar_recorrido(Pos, N, Board, DireccionesPermitidas, Recorrido, Valor).

generar_posiciones(N, Pos) :-
    between(1, N, Row),
    between(1, N, Col),
    Pos = pos(Row, Col).

tablero(N, Tablero, DireccionesPermitidas, ValorMinimo, NumeroDeRutasConValorMinimo).

:- doc(title, "Programción Lógica").

:- doc(author, "Ernesto Naval, c200343").

:- pred author_data(Name, LastName, LastName2, Matricula)
   # "Author of the script.".

:- pred board1(Board)
   # "@var{Board} is the definition of the board itself.".

:- pred efectuar_movimiento(Pos, Dir, NewPos)
   # "@var{NewPos} is the position resulting from moving from @var{Pos}
      in the direction specified by @var{Dir}.".

:- pred movimiento_valido(N, Pos, Dir)
   # "Checks if a movement in the given direction @var{Dir} is valid
      for the board of size @var{N} with the current position @var{Pos}.".

:- pred select_cell(IPos, Op, Board, NewBoard)
   # "Extracts the cell with position @var{IPos} from the @var{Board},
      obtaining the operation @var{Op}, and a new board @var{NewBoard}
      without that cell.".

:- pred select_dir(Dir, Dirs, NewDirs)
   # "Extracts a direction @var{Dir} from the list of directions @var{Dirs},
      obtaining a new list of directions @var{NewDirs}.".

:- pred aplicar_op(Op, Valor, Valor2)
   # "Applies the operation @var{Op} to the value @var{Valor},
      resulting in @var{Valor2}.".

:- pred generar_recorrido(Ipos, N, Board, DireccionesPermitidas, Recorrido, Valor)
   # "Generates a path @var{Recorrido} and a value @var{Valor} by exploring
      the board from the initial position @var{Ipos} using the allowed
      directions @var{DireccionesPermitidas} and the operations on the cells
      @var{Board}.".

:- pred generar_recorrido_aux(Ipos, N, Board, DireccionesPermitidas, Recorrido, Valor, Valor, Recorrido)
    # "Auxiliar predicate for generar_recorrido.".

:- pred generar_recorridos(N, Board, DireccionesPermitidas, Recorrido, Valor)
   # "Generates multiple paths @var{Recorrido} and values @var{Valor}
      by exploring the board of size @var{N} using the allowed directions
      @var{DireccionesPermitidas} and the operations on the cells @var{Board}.".

:- pred generar_posiciones(N, Pos)
   # "Generates all possible positions @var{Pos} on a board of size @var{N}.".

:- pred tablero(N, Tablero, DireccionesPermitidas, ValorMinimo, NumeroDeRutasConValorMinimo)
   # "@var{ValorMinimo} unifies with the minimum final value that can be obtained by considering 
      all possible routes starting from any cell on the N-dimensional board, using only the movements 
      indicated in the @var{DireccionesPermitidas} list.".

:- regtype cell(pos, op) # "Represents a cell on the board".

:- regtype op(Op, Val) # "Represents an operation".

:- regtype pos(Row, Col) # "Represents a position on the board".











    


