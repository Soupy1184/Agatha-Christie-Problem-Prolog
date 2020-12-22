%==========
%FACTS
%==========

man(husband).
man(son).
man(brother).
woman(alice).
woman(daughter).

child(son).
child(daughter).

twin(alice, brother).
twin(brother, alice).
twin(daughter, son).
twin(son, daughter).

younger(son, alice).
younger(son, husband).
younger(daughter, alice).
younger(daughter, husband). 
younger(husband, brother). %we know husband is younger from assignment output

%==========
%RULES
%==========

person(X) :- man(X) ; woman(X) ; child(X).
%rule 
togetherAH(X, Y) :- X = alice, Y = husband.
togetherAH(X, Y) :- Y = alice, X = husband.
%children cannot be together at the bar because one of them is alone
%alice and husband cannot be at the bar together from the clue
%twins cannot be at the bar together because one is victim and one is innocent, therefore, 
%one twin must be with the killer and one twin must be at the bar
manWomanTogether(X, Y) :- man(X), woman(Y), \+togetherAH(X, Y), \+twin(X, Y).
isAlone(X) :- child(X).

%==========
%MAIN
%==========

solve(Killer, Victim, Man, Woman, Child) :- 
	person(Killer),
	person(Victim),
	person(Killer) \= person(Victim), %killer and victim cant be the same person
	person(Victim) \= person(Killer), %victim and killer cant be the same person
	\+togetherAH(Killer, Victim),	%alice and husband cant be together
	\+twin(Killer, Victim),			%twins cant be together because because one is victim and one is innocent
	younger(Killer, Victim),		%killer is younger than the victim
	manWomanTogether(Man, Woman),   %man and woman at the bar
	person(Man) \= person(Killer),	%man cannot be killer or victim at the bar
	person(Man) \= person(Victim),
	person(Woman) \= person(Killer), %woman cannot be killer or victim at the bar
	person(Woman) \= person(Victim),
	isAlone(Child),						%child cannot be victim, killer, man, or woman
	person(Child) \= person(Killer),
	person(Child) \= person(Victim),
	person(Child) \= person(Man),
	person(Child) \= person(Woman).

%==========
%ENTRANCE
%==========

runProgram :-
	solve(Killer, Victim, Man, Woman, Child),
	%if using SWISH prolog this format output should work. 
	format('~s killed ~s.~n~s and ~s were at the bar.~n~s was alone.', [Killer, Victim, Man, Woman, Child]).

%otherwise this output works. 
	%write(Killer), write(' killed '), write(Victim), nl,
	%write(Man), write(' and '), write(Woman), write(' were at the bar.'), nl,
	%write(Child), write(' was alone.').

%[exercise3].
