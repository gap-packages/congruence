###########################################################################
##
#W makedoc.g              The Congruence package         Olexandr Konovalov
##
###########################################################################

if fail = LoadPackage("AutoDoc", ">= 2019.04.10") then
    Error("AutoDoc 2019.04.10 or newer is required");
fi;

AutoDoc(rec(
    scaffold := rec(
        bib := "manual.bib",
        MainPage := false,
        TitlePage := false,
    ),
    extract_examples := rec( skip_empty_in_numbering := false ),
    gapdoc := rec( main := "manual.xml" ),
));
