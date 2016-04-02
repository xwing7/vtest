VALAC=valac-0.16
VALAFILES=vtest.vala
VALAPKGS=--pkg libxml-2.0
VALAOPTS=

EXEC=vtest

default:
	$(VALAC) $(VALAFILES) -o $(EXEC) $(VALAPKGS) $(VALAOPTS)


run:
	./$(EXEC)
