#############################################################################
##
#W cong.gd                 The Congruence package                   Ann Dooms
#W                                                               Eric Jespers
#W                                                        Alexander Konovalov
##
#H $Id$
##
#############################################################################


#############################################################################
##
## InfoCongruence
##  
## We declare new Info class for algorithms from the Congruence package. It
## has 3 levels - 0, 1 and 2. Default level is 1, and it is used to display
## messages when the package is used to replace existing GAP methods.
## To change Info level to k, use command SetInfoLevel(InfoCongruence, k)
DeclareInfoClass("InfoCongruence");


#############################################################################
##
## IsCongruenceSubgroup( <G> )
## 
## We create category of congruence subgroups as a subcategory of matrix 
## groups, and declare properties that are used to distinguish several
## important classes of congruence subgroups
DeclareCategory( "IsCongruenceSubgroup", IsMatrixGroup );


#############################################################################
##
## IsPrincipalCongruenceSubgroup( <G> )
## 
## The principal congruence subgroup of level N consists of all matrices
## of the form   [ 1+N    N ]
##               [   N  1+N ]
##
DeclareProperty( "IsPrincipalCongruenceSubgroup", IsCongruenceSubgroup );


#############################################################################
##
## IsGamma0( <G> )
## 
## The congruence subgroup Gamma0(N) consists of all matrices
## of the form   [   *    * ]
##               [   N    * ]
##
DeclareProperty( "IsGamma0", IsCongruenceSubgroup );


#############################################################################
##
## IsGammaUpper0( <G> )
## 
## The congruence subgroup GammaUpper0(N) consists of all matrices
## of the form   [   *    N ]
##               [   *    * ]
##
DeclareProperty( "IsGammaUpper0", IsCongruenceSubgroup );


#############################################################################
##
## IsGamma1( <G> )
## 
## The congruence subgroup Gamma1(N) consists of all matrices
## of the form   [ 1+N    * ]
##               [   N  1+N ]
##
DeclareProperty( "IsGamma1", IsCongruenceSubgroup );


#############################################################################
##
## IsGammaUpper1( <G> )
## 
## The congruence subgroup GammaUpper1(N) consists of all matrices
## of the form   [ 1+N    N ]
##               [   *  1+N ]
##
DeclareProperty( "IsGammaUpper1", IsCongruenceSubgroup );


#############################################################################
##
## IsIntersectionOfCongruenceSubgroups( <G> )
## 
## This property will be uses for subgroups of SL_2(Z) that were constructed
## as intersection of a finite number of congruence subgroups of types 
## Gamma, Gamma_0, Gamma^0, Gamma_1 and Gamma^1
##
DeclareProperty( "IsIntersectionOfCongruenceSubgroups", IsCongruenceSubgroup );


#############################################################################
##
## PrincipalCongruenceSubgroup( n )
## Gamma0( n )
## GammaUpper0( n )
## Gamma1( n )
## GammaUpper1( n )
##
## Declaration of global functions - constructors of congruence subgroups
##
DeclareGlobalFunction("PrincipalCongruenceSubgroup");
DeclareGlobalFunction("Gamma0");
DeclareGlobalFunction("GammaUpper0");
DeclareGlobalFunction("Gamma1");
DeclareGlobalFunction("GammaUpper1");


#############################################################################
##
## LevelOfCongruenceSubgroup( <G> )
##
## The (arithmetic) level of a congruence subgroup G is the smallest positive
## number N such that G contains the principal congruence subgroup of level N
##
DeclareAttribute( "LevelOfCongruenceSubgroup", IsCongruenceSubgroup );


#############################################################################
##
## IndexInSL2Z( <G> )
##
## The index of a congruence subgroup in SL_2(Z) will be stored as its 
## attribute. This also will allow us to install a method for Index(G,H) when
## G is SL_2(Z) and H is a congruence subgroup. You should remember that we
## are working with the SL_2(Z), because it is available in GAP, and not with
## the PSL_2(Z) since the latter is not implemented in GAP.
##
DeclareAttribute( "IndexInSL2Z", IsCongruenceSubgroup );


#############################################################################
##
## IntersectionOfCongruenceSubgroups( <list of subgroups> )
##
## We declare special type of congruence subgroups that are intersections of
## a finite number congruence subgroups of types Gamma, Gamma_0, Gamma^0, 
## Gamma_1 and Gamma^1. The list of subgroups defining this intersection will
## be stored in the attribute "DefiningCongruenceSubgroups" 
##
DeclareGlobalFunction("IntersectionOfCongruenceSubgroups");
DeclareAttribute( "DefiningCongruenceSubgroups", 
                  IsIntersectionOfCongruenceSubgroups );
                  
#############################################################################
#
# CanEasilyCompareCongruenceSubgroups( G, H )
#
DeclareGlobalFunction( "CanEasilyCompareCongruenceSubgroups" );


#############################################################################
#
# CanReduceIntersectionOfCongruenceSubgroups( G, H )
#
# This function mimics the structure of the method for Intersection for
# congruence subgroups. It returns true, if their intersection can be reduced
# to one of the canonical congruence subgroups, and false otherwise, i.e. the
# intersection can be expressed only as IntersectionOfCongruenceSubgroups.
# This is used in IntersectionOfCongruenceSubgroups to reduce the list of
# canonical subgroups forming the intersection.
#
DeclareGlobalFunction( "CanReduceIntersectionOfCongruenceSubgroups" );


#############################################################################
#
# NumeratorOfGFSElement( gfs, i )
#
# Returns the numerator of the i-th term of the generalised Farey sequence 
# gfs: for the 1st infinite entry returns -1, for the last one returns 1,
# for all other entries returns usual numerator.
#  
DeclareGlobalFunction( "NumeratorOfGFSElement" );


#############################################################################
#
# DenominatorOfGFSElement( gfs, i )
#
# Returns the denominator of the i-th term of the generalised Farey sequence 
# gfs: for both infinite entries returns 0, for the other ones returns usual 
# denominator.
# 
DeclareGlobalFunction( "DenominatorOfGFSElement" );


#############################################################################
#
# IsValidFareySymbol( fs )
#
# This function is used in FareySymbolByData to validate its output
# 
DeclareGlobalFunction( "IsValidFareySymbol" );


#############################################################################
#
# MatrixByEvenInterval( gfs, i )
#
DeclareGlobalFunction( "MatrixByEvenInterval" );


#############################################################################
#
# MatrixByOddInterval( gfs, i ) 
#
DeclareGlobalFunction( "MatrixByOddInterval" );


#############################################################################
#
# MatrixByFreePairOfIntervals( gfs, k, kp )
#
DeclareGlobalFunction( "MatrixByFreePairOfIntervals" );


#############################################################################
##
#E
##
