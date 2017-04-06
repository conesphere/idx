#!/usr/bin/make 
# install an uninstall that beast 

DESTDIR= 
PREFIX=/usr/bin
TARGETS=$(wildcard idx-*)

all:
	echo use: make install for installation

.checkdeps:
	@echo testing sha256sum
	@which sha256sum
	@echo -------------------
	@echo testing date
	@which date
	@echo -------------------
	@echo testing file
	@which file
	@echo -------------------
	@echo testing bash
	@which /bin/bash
	@echo -------------------
	@touch $@

clean:
	rm -f .checkdeps install

install: .checkdeps $(TARGETS) 
	@touch install
	@echo done

uninstall:  $(TARGETS) 
	rm -f $^
	rm -f install
	@echo done

$(DESTDIR)$(PREFIX):
	echo install -d $@
	
$(DESTDIR)$(PREFIX)/%: % $(DESTDIR)$(PREFIX)
	install $< $@
