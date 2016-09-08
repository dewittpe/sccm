PKG_VERSION = $(shell awk '/^Version:/{print $$2}' DESCRIPTION)
PKG_NAME    = $(shell awk '/^Package:/{print $$2}' DESCRIPTION)

.PHONY: data

DATA   = $(wildcard data/*.rda)
SRC    = $(wildcard src/*.cpp)
RFILES = $(wildcard R/*.R)
MANS   = $(wildcard man/*.Rd)

all: $(PKG_NAME)_$(PKG_VERSION).tar.gz

data/CircleLimitI.rda: data-raw/mcescher.R
	Rscript data-raw/mcescher.R

$(PKG_NAME)_$(PKG_VERSION).tar.gz: DESCRIPTION $(RFILES) $(SRC) $(DATA)
	R -e "devtools::document()"
	R CMD build .

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

clean:
	/bin/rm -f  src/*.o
	/bin/rm -f  src/*.so
	/bin/rm -f  $(PKG_NAME)_*.tar.gz
	/bin/rm -rf $(PKG_NAME).Rcheck
