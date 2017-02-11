PKG_VERSION = $(shell awk '/^Version:/{print $$2}' DESCRIPTION)
PKG_NAME    = $(shell awk '/^Package:/{print $$2}' DESCRIPTION)

.PHONY: data vignettes

DATA      = $(wildcard data/*.rda)
SRC       = $(wildcard src/*.cpp)
RFILES    = $(wildcard R/*.R)
MANS      = $(wildcard man/*.Rd)
VIGNETTES = $(wildcard vignettes/*.Rmd)

all: $(PKG_NAME)_$(PKG_VERSION).tar.gz

data/CircleLimitI.rda: data-raw/mcescher.R
	Rscript data-raw/mcescher.R

data/HexagonalFish.rda: data-raw/hexagonal-fish.R
	Rscript data-raw/hexagonal-fish.R

vignettes: vignettes/sccm-overview.Rmd
	R -e "devtools::build_vignettes()" 

$(PKG_NAME)_$(PKG_VERSION).tar.gz: DESCRIPTION $(RFILES) $(SRC) $(DATA) $(VIGNETTES)
	R -e "devtools::document()"
	R CMD build .

tarnovign: DESCRIPTION $(RFILES) $(SRC) $(DATA)
	R CMD build --no-build-vignettes .

installnovign: tarnovign
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz
 

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

clean:
	/bin/rm -f  src/*.o
	/bin/rm -f  src/*.so
	/bin/rm -f  $(PKG_NAME)_*.tar.gz
	/bin/rm -rf $(PKG_NAME).Rcheck
