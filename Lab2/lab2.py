# main file for ML lab 2 : support vector machine

# various imports
from cvxopt.solvers import qp
from cvxopt.base import matrix

import pylab, random, math
import numpy as np

def kernel( x, y, kind ): # x, y are vectors of ndarray type
  if( x.size == 3 ):
    # chop off the last element of x
    x = x[ 1:2 ]

  if( y.size == 3 ):
    # chop off the last element of y
    y = y[ 1:2 ]

  if( kind == 0 ): # linear kernel function
    return ( np.dot( x, y ) + 1 )
  else:
    print 'Not supported yet'


def testKer():
  x = np.array( [1,2] )
  y = np.array( [1,2] )

  print( x )
  print( y )
  print( kernel( x, y, 0 ) )
