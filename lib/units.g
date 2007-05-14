#############################################################################
#
# ann.g                  The Congruence package                    Ann Dooms
#                                                               Eric Jespers
#                                                        Alexander Konovalov
#
# 
#
#############################################################################


#############################################################################
#
# HomomorphicImages(G,H)
#
# Returns a list of normal groups N of which the quotient G/N is H.
#
HomomorphicImages:=
function(G,H)
local m,l,k,i;
m:=[];
l:=NormalSubgroups(G);
#
# TODO: use sizes to speed up the code
#
k:=List(l, x->IdGroup(FactorGroup(G,x)));
  for i in [1..Length(k)] do
    if k[i]=IdGroup(H) then 
    Add(m,l[i]);
        else
    fi;
  od;
  return m;
end;


#############################################################################
#
# GeneratorsInM_2Q(G,H)
#
# Returns a list of lists of generators of a subgroup of f.i. in M_2(Q), 
# one for each homomorphic image. # H has to be S3 or D8!

GeneratorsInM_2Q:=
function(G,H)
local gen,k,m,i,p,fs;
gen:=[];
if IdGroup(H)=[6,1] then # H = S_3
    k:=3;  # H = S_3
else
    k:=4;  # H = D_8
fi;
m:=HomomorphicImages(G,H);
#
# TODO: return several copies of the same list of generators
#
if Length(m)<>0 then
        for i in [1..Length(m)] do
            p:=PrincipalCongruenceSubgroup(k*Size(m[i]));
            fs:=FareySymbol(p);
            gen[i]:=GeneratorsByFareySymbol(fs);
        od;
        return gen;
else
        return gen;
fi;
end;

#############################################################################
#
# Entries(matrix,k)
#
# Returns a list with integer entries. Will be applied with k=4n or 3n.
# PROBLEM: some matrices gave non-integers! SOLUTION: multiplied with -I_2!

Entries:=function(matrix,k)
local g11,g12,g21,g22;
g11:=(matrix[1][1]-1)/k;
if IsInt(g11)=false then
  matrix:=-matrix;
  g11:=(matrix[1][1]-1)/k;
fi;
g12:=matrix[1][2]/k;
g21:=matrix[2][1]/k;
g22:=(matrix[2][2]-1)/k;
return [g11,g12,g21,g22];
end;


#############################################################################
#
# D8Alpha(matrix,n)
#
# Returns a list with integer entries. 
# Will be applied with n=number of elements in the normal subgroup N determining M_2(Q).

D8Alpha:=
function(matrix,n)
local list,a0,a1,a2,a3;
list:=Entries(matrix,4*n);
a0:=list[1]+list[4];
a1:=list[1]-list[4]-list[2]+2*list[3];
a2:=list[1]-list[4]+2*list[3];
a3:=-list[1]+list[4]+list[2];
return [a0,a1,a2,a3];
end;

#############################################################################
#
# S3Alpha(matrix,n)
#
# Returns a list with integer entries.
# Will be applied with n=number of elements in the normal subgroup N determining M_2(Q).

S3Alpha:=
function(matrix,n)
local list,a0,a1,a2,a3;
list:=Entries(matrix,3*n);
a0:=list[1]+list[4];
a1:=2*list[1]-list[4]+3*list[2]-list[3];
a2:=-2*list[1]+2*list[4]-3*list[2]+list[3];
a3:=-list[1]+list[4]-3*list[2];
return [a0,a1,a2,a3];
end;


#############################################################################
#
# Alphas(G,H)
#
# Returns a list of lists with lists of integer entries which will serve for the units in U(ZG).

Alphas:=
function(G,H)
local m,gen,f,alpha,i,j;
m:=HomomorphicImages(G,H);
#
# avoid usage of m here
#
gen:=GeneratorsInM_2Q(G,H);
if IdGroup(H)=[6,1] then
    f:=S3Alpha;
else
    f:=D8Alpha;
fi;
alpha:=[];
if Length(gen)<>0 then
        for i in [1..Length(gen)] do
            alpha[i]:=[];
            for j in [1..Length(gen[i])] do
                alpha[i][j]:=f(gen[i][j],Size(m[i]));
            od;  
        od;
else
fi;          
return alpha;  
end;



#############################################################################
#
# LiftGenerator(G,N)
#
# Lifts a minimal list of generators form G/N to G.

LiftGenerator:=
function(G,N)
local l,q,s,hom,i;
l:=[];
q:=FactorGroup(G,N);
s:=MinimalGeneratingSet(q);
hom:=NaturalHomomorphismByNormalSubgroup(G,N);
for i in [1..Length(s)] do
    Add(l,Representative(PreImages(hom,s[i])));
od;
return l;
end;


#############################################################################
#
# CreateUnits(G,H)
#
# Creates units of ZG. H must be D8 or S3.

CreateUnits:=
function(G,H)
local m,alpha,a,b,ZG,emb,hat,u,i,j;
m:=HomomorphicImages(G,H);
alpha:=Alphas(G,H);
a:=[];
b:=[];
ZG:=GroupRing(Integers,G);
emb := Embedding(G,ZG);
hat:=[];
u:=[];
if Length(m)<>0 then
    for i in [1..Length(m)] do
        hat[i]:=Sum( List(m[i], x->x^emb));
        u[i]:=[];
        #
        # avoid double computation
        #
        if LiftGenerator(G,m[i])[1]^2=Identity(G) then
            a[i]:=LiftGenerator(G,m[i])[2]^emb;
            b[i]:=LiftGenerator(G,m[i])[1]^emb;
        else
            a[i]:=LiftGenerator(G,m[i])[1]^emb;
            b[i]:=LiftGenerator(G,m[i])[2]^emb;
        fi;
        if IdGroup(H)=[6,1] then
            for j in [1..Length(alpha[i])] do
                u[i][j]:=Identity(ZG)+(alpha[i][j][1]*Identity(ZG)+alpha[i][j][2]*a[i]+alpha[i][j][3]*b[i]+alpha[i][j][4]*a[i]^2*b[i])*(Identity(ZG)-a[i])*hat[i];
            od;
        else   
            for j in [1..Length(alpha[i])] do 
                u[i][j]:=Identity(ZG)+(alpha[i][j][1]*Identity(ZG)+alpha[i][j][2]*a[i]+alpha[i][j][3]*b[i]+alpha[i][j][4]*a[i]*b[i])*(Identity(ZG)-a[i]^2)*hat[i];
            od;
        fi;
    od;
else
fi;
return u;
end;


#############################################################################
#
# UnitsOfZGOfFiniteIndexInM_2Q(G)
#

UnitsOfZGOfFiniteIndexInM_2Q:=
function(G)
local u,v;
u:=[];
v:=[];
if IsNilpotent(G)=true then
   u:=CreateUnits(G,DihedralGroup(8));
else
   u:=CreateUnits(G,DihedralGroup(8));
   v:=CreateUnits(G,DihedralGroup(6));  
fi;
return [u,v];
end;
