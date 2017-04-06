#!/usr/bin/make 
# install an uninstall that beast 

# variables to be set externally
DESTDIR= 
PREFIX=/usr/bin

# variables used by make 
TARGETS=$(addprefix $(DESTDIR)$(PREFIX)/,$(wildcard idx-*))
DEPS=sha256sum date file bash

all:
	echo use: make install for installation

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
	rm -f .checkdeps install

install: .checkdeps $(TARGETS)
	@touch install
	@echo done

uninstall:  $(TARGETS) 
	rm -f $^
	rm -f install
	@echo done

$(DESTDIR)$(PREFIX):
	install -d $@
	
$(DESTDIR)$(PREFIX)/%: % $(DESTDIR)$(PREFIX)
	install $< $@
