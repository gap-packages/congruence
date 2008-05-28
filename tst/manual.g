#############################################################################
##  
#W  manual.g               The Congruence package         Alexander Konovalov
##
#H  $Id$
##
#############################################################################
#
# This file contains a function CONGRUENCETestManual() to test all examples
# from xml-files of package documentation. This file is a developer tool, 
# and it will not be included in the official Congruence release. 

#############################################################################
##
##  CONGRUENCETestManual()
##
CONGRUENCETestManual:=function()
local path, main, files, str, tst, i;
LogTo();
path:=DirectoriesPackageLibrary( "congruence", "doc" );
main:="manual.xml";
files:=[];
tst:=ManualExamples( path, main, files, "Chapter" );
for i in [ 1 .. Length(tst) ] do
  Print("###############################################################\n");
  Print("TESTING CHAPTER NUMBER ", i, "\n");
  Print("###############################################################\n");
  TestExamplesString( tst[i], true );
od;  
end;

#############################################################################
##
#E
##