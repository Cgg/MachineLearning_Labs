
epsilon = 0.5;

nIterations = 50;
nStates     = 16;
nActions    = 4;

rate     = 0.9;
discount = 0.1;

QVal = zeros( nStates, nActions );

curState = floor( rand( 1 ) * nStates );

for i = 1 : nIterations
  if ( rand( 1 ) >= epsilon )
    [ dummy, curAct ] = max( QVal( curState, : ) );
  else
    curAct = ceil( rand( 1 ) * nActions );
  end

  [ nextState, reward ] = go( curState, curAct );

  [ dummy, bestNewVal ] = max( QVal(nextState, :) );

  oldVal = QVal( curState, curAct );

  QVal( curState, curAct ) = oldVal + ...
    rate * ( reward + discount * bestNewVal - oldVal );

  curState = nextState;

end

QVal

% Test phase ; start from state 13 and do the next ten steps.
nTest = 10;
initS = ceil( rand( 1 ) * nStates );

seq = zeros( 1, nTest  );

seq( 1 ) = initS;

for i = 2 : nTest
  [ dummy, curAct ] = max( QVal( curState, : ) );

  [ nextState, reward ] = go( curState, curAct );

  seq( i ) = nextState;

  curState = nextState;
end

% see how bad the bot performs !
walkshow( seq );
