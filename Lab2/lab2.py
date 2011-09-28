# main file for ML lab 2 : support vector machine

# various imports
from cvxopt.solvers import qp
from cvxopt.base import matrix

import pylab, random, math
import numpy as np


# Building the hyper plan

def Lab2( amountOfPoints, kernelKind ):

  # generate dataset TODO
  dataset = generateData()

  P = computePMatrix( dataset, kernelKind )

  alpha = callToQP( P )

  # point initialization...

  for i in range( len( alpha ) ):
    if alpha[ i ] > 1e-5:
      points[ i ] = Sample( alpha[ i ], dataset[ i ] )


# Implementations needed for the lab

class Sample:
  def __init__( alpha, point ):
    self.alpha = alpha
    self.point = point


def kernel( x, y, kind ): # x, y are vectors of ndarray type
  if x.size == 3:
    # chop off the last element of x
    x = x[ 0:2 ]

  if y.size == 3:
    # chop off the last element of y
    y = y[ 0:2 ]

  if( kind == 0 ): # linear kernel function
    return ( np.dot( x, y ) + 1 )
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


def callToQP( PMatrix ):
  amountOfPoints = PMatrix.shape[0]

  # first build helper matrixes to pass to qp
  h = np.zeros( ( amountOfPoints, 1 ) )
  q = np.zeros( ( amountOfPoints, 1 ) )
  q[::] = -1

  G = np.zeros( ( amountOfPoints, amountOfPoints ) )

  for i in range( amountOfPoints ):
    G[ i, i ] = -1

  print( h )
  print( q )
  print( G )

  # actual call to qp
  r = qp( matrix(PMatrix), matrix(q), matrix(G), matrix(h) )
  alpha = list( r['x'] )

  return alpha


def generateData():
  classA = [ (random.normalvariate(1.5, 1), random.normalvariate(1.5,1),1.0) for i in range( 10 )]

  classB = [ (random.normalvariate(0.0, 0.5), random.normalvariate(0.0,0.5), -1.0) for i in range( 10 ) ]

  data = classA + classB

  random.shuffle( data )

  return data, classA, classB


def plotEverytthing( classA, classB ):
  pylab.hold( True )

  pylab.plot( [ p[0] for p in classA ], [ p[1] for p in classA ], 'bo' )
  pylab.plot( [ p[0] for p in classB ], [ p[1] for p in classB ], 'ro' )


  xrange = np.arrange( -4, 4, 0.05 )
  yrange = np.arrange( -4, 4, 0.05 )

  grid = matrix( [ [ indicator( x, y ) for y in yrange ] for x in xrange ] )

  pylab.contour( xrange, yrange, grid, (-1.0, 0.0, 1.0), colors=('red', 'black', 'blue'), linewidths=(1, 3, 1) )

  pylab.show()


# Test for the above implementations

def testKer():
  x = np.array( [1,2,-1] )
  y = np.array( [1,2,1] )

  print( x )
  print( y )
  print( kernel( x, y, 0 ) )

def testMatP():
  x = np.array( [1,2,-1] )
  y = np.array( [1,2,1] )

  print( x )
  print( y )

  L = [ x, y ]

  print( L )
  print( computePMatrix( L, 0 ) )

def testCallQP():
  x = np.array( [11,32,-1] )
  y = np.array( [1,2,1] )
  L = [ x, y ]
  P = computePMatrix( L, 0 )

  print( P )

  alpha = callToQP( P )

  print( alpha )
