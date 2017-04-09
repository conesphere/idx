#!/usr/bin/make 
# install an uninstall that beast 

# variables to be set externally
DESTDIR= 
PREFIX=/usr/local

# variables used by make 
TARGETS=$(addprefix $(DESTDIR)$(PREFIX)/share/idx/,$(wildcard idx-*)) $(addprefix $(DESTDIR)$(PREFIX)/bin/,idx)
DEPS=sha256sum date file bash

all:
	@echo usage:
	@echo make install
	@echo make PREFIX=~/bin install
	@echo make DESTDIR=/tmp/urpackagebase install
	@echo make uninstall
	@echo make clean

.checkdeps: $(addprefix .which-,$(DEPS))
	@echo testing /bin/bash
	@which /bin/bash
	@echo -------------------
	@touch $@

.which-%:
	@echo testing depency
	@which $(patsubst .which-%,%,$@)
	@echo -------------------
	@touch $@

clean:
	rm -f .checkdeps install $(addprefix .which-,$(DEPS))

install: .checkdeps $(TARGETS)
	@touch install
	@echo done

uninstall:  $(TARGETS) 
	rm -f $^
	rm -f install
	@echo done

$(DESTDIR)$(PREFIX)/share/idx:
	install -d $@
	
$(DESTDIR)$(PREFIX)/share/idx/idx-%: idx-% $(DESTDIR)$(PREFIX)/share/idx
	install $< $@

$(DESTDIR)$(PREFIX)/bin:
	install -d $@

$(DESTDIR)$(PREFIX)/bin/idx: idx $(DESTDIR)$(PREFIX)/bin
	install $< $@

