% Policy iteration algorithm

nIterations = 100;
nStates     = 16;
nActions    = 4;

% initialisation of stuff

% gamma, discount factor
g = 0.5

trans = [ 2,  4,  5,  13 ; ... % 1
          1,  3,  6,  14 ; ...
          4,  2,  7,  15 ; ...
          3,  1,  8,  16 ; ...
          6,  8,  1,  9  ; ... % 5
          5,  7,  2,  10 ; ...
          8,  6,  3,  11 ; ...
          7,  5,  4,  12 ; ...
          10, 12, 13, 5  ; ...
          9,  11, 14, 6  ; ... % 10
          12, 10, 15, 7  ; ...
          11, 9,  16, 8  ; ...
          14, 16, 9,  1  ; ...
          13, 15, 10, 2  ; ...
          16, 14, 11, 3  ; ... % 15
          15, 13, 12, 4 ];

% initial policy does action one in every state
policy = ones( 1, nStates );

% initial values are zero for every state
value = zeros( 1, nStates );

% rewards
rew = [ -1, -1, -1,  0 ; ...  % 1
        -1,  1, -1, -1 ; ...
         0, -1, -1, -1 ; ...
        -1, -1,  0, -1 ; ...
        -1, -1, -1,  1 ; ... % 5
        -1, -1, -1, -1 ; ...
         0, -1,  1, -1 ; ...
        -1, -1, -1,  0 ; ...
        -1, -1,  0, -1 ; ...
         1, -1,  0, -1 ; ... % 10
         0, -1,  0, -1 ; ...
        -1,  1, -1, -1 ; ...
         0, -1, -1, -1 ; ...
        -1,  0, -1, -1 ; ...
        -1, -1, -1,  1 ; ... % 15
        -1, -1, -1,  0 ];

% a good walking pattern seems to be, for instance :
% 13 14 15 3 4 8 12 9 and again

% Learning phase
for p = 1 : nIterations

  for s = 1:nStates
    [ dummy, policy( s ) ] = max( rew(s, :) + g * value(trans( s, : )) );
  end

  for s = 1 : nStates
    a = policy( s );

    value( s ) = rew( s, a ) + g * value( trans( s, a ) );
  end

end

value
policy

% Test phase ; start from state 13 and do the next ten steps.
nTest = 10;
initS = ceil( rand( 1 ) * nStates )

seq = zeros( 1, nTest  );

seq( 1 ) = initS;

for i = 2 : nTest
  seq( i ) = trans( seq( i - 1 ), policy( seq( i - 1 ) ) );
end

% see how bad the bot performs !
walkshow( seq );
