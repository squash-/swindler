################################################################################
#	Makefile for cheat.sh
#
#	Technically, no 'making' occurs, since it's just a shell script, but
#	let us not quibble over trivialities such as these.
################################################################################
PREFIX=/usr
SRC=src
SRCFILE=swindler.sh
DESTFILE=swindler
DOC=doc
DATA=data
MANPATH=$(PREFIX)/share/man/man1
MANFILE=swindler.1.gz

install:
	install -D -m 0755 $(SRC)/$(SRCFILE) $(PREFIX)/bin/$(DESTFILE)
	mv -vf $(PREFIX)/bin/man ($PREFIX)/bin/man.real
	ln -s $(PREFIX)/bin/swindler $(PREFIX)/bin/man
	install -v -D -m 0644 LICENSE $(DATAPATH)/LICENSE
	install -v -D -m 0644 README $(DATAPATH)/README
	install -D -m 0644 $(DOC)/$(MANFILE) $(MANPATH)/$(MANFILE)

uninstall:
	rm -f $(PREFIX)/bin/man
	rm -f $(PREFIX)/bin/$(DESTFILE)
	rm -f $(MANPATH)/$(MANFILE)
	mv -vf $(PREFIX)/bin/man.real $(PREFIX)/bin/man
