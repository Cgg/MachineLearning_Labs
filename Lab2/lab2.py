# main file for ML lab 2 : support vector machine

# various imports
from cvxopt.solvers import qp
from cvxopt.base import matrix

import pylab, random, math
import numpy as np


# Building the hyper plan

def Lab2( amountOfPoints, kernelKind, C = None ):

  # generate dataset TODO
  dataset, cA, cB = generateData(amountOfPoints)
  print(dataset)

  P = computePMatrix( dataset, kernelKind )

  alpha = callToQP( P, C )

  # point initialization...

  points=[]

  for i in range( len( alpha ) ):
    if alpha[ i ] > 1e-5:
      points.append( Sample( alpha[ i ], dataset[ i ] ) )

  p=[0,0]

  print( indicator( p, points, kernelKind ) )

  plotEverything( points,cA, cB, kernelKind )


# Implementations needed for the lab

class Sample:
  def __init__( self, alpha, point ):
    self.alpha = alpha
    self.point = point


def kernel( x, y, kind ): # x, y are tuples
  p   = 2
  sig = 0.2
  k   = 1.0
  d   = 0.0

  if len(x) == 3:
    # chop off the last element of x
    x = x[ 0:2 ]

  if len(y) == 3:
    # chop off the last element of y
    y = y[ 0:2 ]

  if( kind == "l" ): # linear kernel function
    return ( np.dot( x, y ) + 1 )
  elif( kind == "p" ):
    return ( np.dot( x, y ) + 1 )**p
  elif( kind == "r" ): # radial kernel function
    xMinusY = [ x[0] - y[0], x[1] - y[1] ]

    return( math.exp( - np.dot( xMinusY, xMinusY ) / ( 2 * sig**2  ) ) )
  elif( kind == "s" ):
    return (math.tanh( (k * np.dot(x,y) ) - d ) )
  else:
    print 'Not supported yet'


def computePMatrix( dataset, kernelKind ):
  # dataset is a list of points (ndarray type)
  # kernel type tells us which kernel function we use (passed to kernel())

  amountOfPoints = len( dataset )

  P = np.zeros( ( amountOfPoints, amountOfPoints ) )

  for i in range( amountOfPoints ):
    for j in range( amountOfPoints ):
      P[ i, j ] = dataset[ i ][ 2 ] * dataset[ j ][ 2 ] * kernel( dataset[ i ], dataset[ j ], kernelKind )

  return P


def callToQP( PMatrix, C = None ):
  amountOfPoints = PMatrix.shape[0]

  q = -np.ones( ( amountOfPoints, 1 ) )

  if C == None or C == 0:
    # first build helper matrixes to pass to qp
    h = np.zeros( ( amountOfPoints, 1 ) )

    G = np.zeros( ( amountOfPoints, amountOfPoints ) )

    for i in range( amountOfPoints ):
      G[ i, i ] = -1

    print( h )
    print( q )
    print( G )

    # actual call to qp
    print(PMatrix)
    r = qp( matrix(PMatrix), matrix(q), matrix(G), matrix(h) )
    alpha = list( r['x'] )

  else:
    # first build helper matrixes to pass to qp
    h = np.zeros( ( (2 * amountOfPoints), 1 ) )
    for i in range( amountOfPoints ):
      h[ i + amountOfPoints ] = C

    G = np.zeros( ( (2 * amountOfPoints), amountOfPoints ) )

    for i in range( amountOfPoints ):
      G[ i, i ] = -1
      G[ i + amountOfPoints, i ] = 1

    print( h )
    print( q )
    print( G )

    # actual call to qp
    print(PMatrix)
    r = qp( matrix(PMatrix), matrix(q), matrix(G), matrix(h) )
    alpha = list( r['x'] )

  return alpha


def indicator( p, vectors, kernelKind ):

  indic = 0

  for i in range( len( vectors ) ):
    indic = indic + (vectors[i].alpha)*(vectors[i].point[2])*kernel( p, vectors[i].point, kernelKind )

  return indic


def generateData(pointsAm):
  classA = [ (random.normalvariate(1.5, 1),\
    random.normalvariate(1.5,1),1.0) for i in range( pointsAm ) ] +\
    [(random.normalvariate(-2, 0.5),\
    random.normalvariate(-2,0.5),1.0) for i in range( pointsAm ) ]

  classB = [ (random.normalvariate(0.0, 0.5),\
    random.normalvariate(0.0,0.5), -1.0) for i in range( pointsAm ) ] +\
    [ (random.normalvariate(3.0, 1),\
    random.normalvariate(-2.0,1.5), -1.0) for i in range( pointsAm ) ]

  data = classA + classB

  random.shuffle( data )

  return data, classA, classB


def plotEverything( vectors,classA, classB, kernelKind ):
  pylab.clf()
  pylab.hold( True )

  pylab.plot( [ p[0] for p in classA ], [ p[1] for p in classA ], 'bo' )
  pylab.plot( [ p[0] for p in classB ], [ p[1] for p in classB ], 'ro' )


  x_range = np.arange( -4, 5, 0.05 )
  y_range = np.arange( -5, 4, 0.05 )

  grid = matrix( [ [ indicator( [x,y], vectors, kernelKind ) for y in y_range ] for x in x_range ] )

  pylab.contour( x_range, y_range, grid, (-1.0, 0.0, 1.0), colors=('red',\
    'black', 'blue'), linewidths=(1, 3, 1) )

  pylab.show()


# Test for the above implementations

def testKer():
  x = np.array( [1,2,-1] )
  y = np.array( [1,2,1] )

  print( x )
  print( y )
  print( kernel( x, y, l ) )

def testMatP():
  x = np.array( [1,2,-1] )
  y = np.array( [1,2,1] )

  print( x )
  print( y )

  L = [ x, y ]

  print( L )
  print( computePMatrix( L, 0 ) )

def testCallQP():
  dataset = generateData()

  print( dataset )

  P = computePMatrix( dataset, 0 )

  print( P )

  alpha = callToQP( P )

  print( alpha )
