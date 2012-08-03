TestMyPackage := function( pkgname )
local pkgdir, testfiles, testresult, ff, fn;
LoadPackage( pkgname );
pkgdir := DirectoriesPackageLibrary( pkgname, "tst" );

# Arrange chapters as required
testfiles := [ 
"cong.tst",
"congruence02.tst",
"congruence03.tst",
"congruence04.tst",
"congruence05.tst",
"congruence06.tst"
];

testresult:=true;
for ff in testfiles do
  fn := Filename( pkgdir, ff );
  Print("#I  Testing ", fn, "\n");
  if not Test( fn, rec(compareFunction := "uptowhitespace") ) then
    testresult:=false;
  fi;
od;  
if testresult then
  Print("#I  Tests of ", pkgname, " package completed without errors\n");
else
  Print("#I  Errors detected during tests of ", pkgname, " package\n");
fi;
end;

# Set the name of the package here
TestMyPackage( "congruence" );
