% A is directly left of B
leftof(A, B, [A, B|_]).
leftof(A, B, [_|R]) :- leftof(A, B, R).

%  which is a shorter version of:
%  leftof(A, B, C) :- 
%	C = [ A , B , _ , _ , _ ]; 
%	C = [ _ , A , B , _ , _ ]; 
%	C = [ _ , _ , A , B , _ ]; 
%	C = [ _ , _ , _ , A , B ].

rightof(A, B, C) :- leftof(B, A, C).

% A is next to B
nextto(A, B, C) :- leftof(A, B, C); rightof(A, B, C).

% A is on the first place
first(A, [A|_]).

% A steht in der Mitte
middle(A, [_, _, A, _, _]).

% The puzzle facts.
%
% There are five Consultants.
% Every consultant is represented by a list of 5 entries: [CUSTOMER, HARDWARE, EXPERTISE, DRINK, PROBLEM]
facts(CONSULTANTS) :-
  CONSULTANTS = [_, _, _, _, _],
  member( [ 'LE.com'       , 'MacBook Pro 15'       , _                   , _         , _               ], CONSULTANTS),
  
  member( [ 'Celest.com'   , _                      , _                   , _         , 'Maven problem' ], CONSULTANTS),
  
  member( [ 'Nappy.com'    , _                      , _                   , 'tea'     , _               ], CONSULTANTS),
  
  leftof( [ _              , 'MacBook Pro 13'       , _                   , _         , _               ], 
          [ _              , 'Dell XPS 15'          , _                   , _         , _               ], CONSULTANTS),
  
  member( [ _              , 'MacBook Pro 13'       , _                   , 'coffee'  , _               ], CONSULTANTS),
  
  member( [ _              , _                      , 'Docker'            , _         , 'lost code of Kensington Lock' ], CONSULTANTS),
  
  middle( [ _              , _                      , _                   , 'whiskey' , _               ], CONSULTANTS),
  
  member( [ _              , 'Dell Lattitude E7470' , 'Caching'           , _         , _               ], CONSULTANTS),                         
  
  first(  [ 'Bolts.com'    , _                      , _                   , _         , _               ], CONSULTANTS),
  
  nextto( [ _              , _                      , _                   , _         , 'lost key for storage container' ], 
          [ _              , _                      , 'Chef Cookbooks'    , _         , _               ], CONSULTANTS),
  
  nextto( [ _              , _                      , _                   , _         , 'Wifi problem'  ], 
          [ _              , _                      , 'Caching'           , _         , _               ], CONSULTANTS),
  
  member( [ _              , _                      , 'Cloud Deployment'  , 'beer'    , _               ], CONSULTANTS),
  
  nextto( [ 'Bolts.com'    , _                      , _                   , _         , _               ], 
          [ _              , 'Dell Precision 5510'  , _                   , _         , _               ], CONSULTANTS),
  
  member( [ 'Triangle.de'  , _                      , 'Studio Customizing', _         , _               ], CONSULTANTS),
  
  nextto( [ _              , _                      , 'Chef Cookbooks'    , _         , _               ], 
          [ _              , _                      , _                   , 'water'   , _               ], CONSULTANTS).

		  
search(N) :-
  facts(CONSULTANTS),
  member(N, CONSULTANTS).
  
solve :-
  facts(CONSULTANTS),
  member([KUNDE, HW, EXP, DRINK, 'no problem'], CONSULTANTS),
  write('The consultant working for '), write(KUNDE),
  write(', with a '), write(HW),
  write(', who is an expert in '), write(EXP),
  write(' and who is drinking '), write(DRINK),
  write(' is the only one who is productive.'),
  !.