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
