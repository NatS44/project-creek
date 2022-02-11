%natalia.schendzielorz@uni-potsdam.de
%Jeder Hint kann bis zu vier Adjazente schwarze Felder haben
go(0,0).
go(1,0).
go(0,1).
go(1,1).

%generiere für jedes Feld eine schwarze oder weisse Färbung
{black(X,Y);white(X,Y)}=1 :- cell(X,Y).
%acc.: die Anzahl schwarzer Felder entspricht dem hint
blackAdjacent(X+X1,Y+Y1,X,Y):-hint(X,Y,_),go(X1,Y1),black(X+X1,Y+Y1).
:- not S = #count{X1,Y1,X,Y:blackAdjacent(X1,Y1,X,Y)}, hint(X,Y,S).

  
    
%whiteCells(S):-S=#count{W1,W2:white(W1,W2)}.
%pathLength(L) :- L=S-1, whiteCells(S).

%Setze Startknoten für das Zählen der weißen Felder in "Ecke"    
startX(X):- X=#max{W1:white(W1,_)}.
startY(Y):- Y=#max{W2:white(W1,W2),startX(W1)}.
startXY(X,Y):-startX(X),startY(Y).

%Weisse Felder können adjazente Weisse Felder in alle Himmelsrichtungen haben    
goW(0,1). 
goW(1,0). 
goW(0,-1). 
goW(-1,0).
    
%Rekursion: Zuerst alle Nachbarn des ersten Knotens erzeugen (N;S;O;W)
path(SX,SY,SX+W1,SY+W2):-startXY(SX,SY), white(SX,SY), white(SX+W1,SY+W2), goW(W1,W2).
%Nachbarn erzeugen für Knoten, die bereits auf Pfad sind, gehe ein Feld weiter (N;S;O;W)
path(X,Y,X+W1,Y+W2):-path(_,_,X,Y), white(X,Y), white(X+W1,Y+W2), goW(W1,W2).
:-not path(X,Y,_,_), white(X,Y).
:-not path(_,_,X,Y), white(X,Y).
    
#show black/2.
    
