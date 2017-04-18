#!/usr/bin/make 
# install an uninstall that beast 

# variables to be set externally
DESTDIR= 
PREFIX=/usr/local
EXTDIR=share/idx/extensions

# variables used by make 
TARGETS=$(addprefix $(DESTDIR)$(PREFIX)/$(EXTDIR)/,$(wildcard idx-*)) $(addprefix $(DESTDIR)$(PREFIX)/bin/,idx)
DEPS=sha256sum date file bash pdftotext grep shellcheck

all:
	@echo usage:
	@echo make install
	@echo make PREFIX=~ EXTDIR=.idx/extensions install
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

$(DESTDIR)$(PREFIX)/$(EXTDIR):
	install -d $@
	
$(DESTDIR)$(PREFIX)/$(EXTDIR)/idx-%: idx-% $(DESTDIR)$(PREFIX)/$(EXTDIR)
	shellcheck $<
	install $< $@

$(DESTDIR)$(PREFIX)/bin:
	install -d $@

$(DESTDIR)$(PREFIX)/bin/idx: idx $(DESTDIR)$(PREFIX)/bin
	shellcheck -x $<
	install $< $@

