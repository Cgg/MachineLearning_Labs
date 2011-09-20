import random

import monkdata as m

import dtree as dT

import drawtree as draw

def A1():
  print "Entropy for Monk1 is : ", dT.entropy( m.monk1 )
  print "Entropy for Monk2 is : ", dT.entropy( m.monk2 )
  print "Entropy for Monk3 is : ", dT.entropy( m.monk3 )

def A2():
  for att in m.attributes:
    #print att[ 0 ]
    print "Gain in Monk1 is : ", dT.averageGain( m.monk1, att )
    print "Gain in Monk2 is : ", dT.averageGain( m.monk2, att )
    print "Gain in Monk3 is : ", dT.averageGain( m.monk3, att )
    print '\n'


def A3():
  t1 = dT.buildTree( m.monk1, m.attributes )
  print( dT.check( t1, m.monk1test ) )
  print( dT.check( t1, m.monk1 ) )
  print '\n'
  #draw.drawTree( t1 )

  t2 = dT.buildTree( m.monk2, m.attributes )
  print( dT.check( t2, m.monk2test ) )
  print '\n'
  #draw.drawTree( t2 )

  t3 = dT.buildTree( m.monk3, m.attributes )
  print( dT.check( t3, m.monk3test ) )
  print '\n'
  #draw.drawTree( t3 )


def A31():
  tree = dT.buildTree( m.monk1, m.attributes, 5 )
  print tree
  draw.drawTree( tree )


# ----------------------------------------------
def A4( number ):
  fractions = [ 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9 ]

  results = [[0 for col in range(2)] for row in range(len(fractions))]

  intermediatesResults = [0 for i in range(number)]

# M1
  for f in fractions:
    for i in range( number ):
      intermediatesResults[ i ] = pruning( m.monk1, m.monk1test, f )

    results[ fractions.index(f) ][ 0 ] = sum(intermediatesResults)/len(intermediatesResults)

#M3
  for f in fractions:
    for i in range( number ):
      intermediatesResults[ i ] = pruning( m.monk3, m.monk3test, f )

    results[ fractions.index(f) ][ 1 ] = sum(intermediatesResults)/len(intermediatesResults)

  for i in range(len(fractions)):
    print fractions[ i ], '\t', results[i][0], '\t', results[i][1]


# --------------------------------------------
def pruning( trainingSet, testSet, fraction ):
  train1, train2 = partition( trainingSet, fraction )

  bestTree = dT.buildTree( train1, m.attributes )
  bestTreePerf = dT.check( bestTree, train2 )
  bestTreeFound = True

  while bestTreeFound == True:
    bestTreeFound = False

    prunedTrees = dT.allPruned( bestTree )

    for candidateTree in prunedTrees:

      if dT.check( candidateTree, train2 ) >= bestTreePerf:
        bestTree = candidateTree
        bestTreePerf = dT.check( candidateTree, train2 )
        bestTreeFound = True

  return dT.check( bestTree, testSet )


def partition( data, fraction ):
  ldata = list( data )
  random.shuffle( ldata )
  breakPoint = int( len( data ) * fraction )
  return ldata[:breakPoint], ldata[breakPoint:]
