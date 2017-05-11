#!/usr/bin/make 
# install an uninstall that beast 

# variables to be set externally
DESTDIR= 
PREFIX=/usr/local
TARGETDIR=share/bim/modules

# variables used by make 
TARGETS=$(addprefix $(DESTDIR)$(PREFIX)/$(TARGETDIR)/idxmenus/,$(wildcard *.bim))
DEPS=idx bash

all:
	@echo usage:
	@echo make install
	@echo make PREFIX=~ TARGETDIR=.bim/modules install
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

$(DESTDIR)$(PREFIX)/$(TARGETDIR)/idxmenus/%.bim: %.bim 
	install -d $(dir $@)
	shellcheck $<
	install $< $@

