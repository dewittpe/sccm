PKG_ROOT    = .
PKG_VERSION = $(shell gawk '/^Version:/{print $$2}' $(PKG_ROOT)/DESCRIPTION)
PKG_NAME    = $(shell gawk '/^Package:/{print $$2}' $(PKG_ROOT)/DESCRIPTION)

CRAN = "https://cran.rstudio.com"
BIOC = "https://bioconductor.org/packages/3.4/bioc"

SRC       = $(wildcard $(PKG_ROOT)/src/*.cpp)
RFILES    = $(wildcard $(PKG_ROOT)/R/*.R)
EXAMPLES  = $(wildcard $(PKG_ROOT)/examples/*.R)
TESTS     = $(wildcard $(PKG_ROOT)/tests/testthat/*.R)
VIGNETTES = $(wildcard $(PKG_ROOT)/vignettes/*.R)
RAWDATAR  = $(wildcard $(PKG_ROOT)/data-raw/*.R)

.PHONY: all check install clean

all: $(PKG_NAME)_$(PKG_VERSION).tar.gz

.document.Rout: $(RFILES) $(SRC) $(EXAMPLES) $(RAWDATAR) $(VIGNETTES) $(PKG_ROOT)/DESCRIPTION
	if [ -d "$(PKG_ROOT)/data-raw" ]; then $(MAKE) -C $(PKG_ROOT)/data-raw/; fi
	echo "options(repo = c('$(CRAN)', '$(BIOC)'))" > .document.R
	echo "devtools::install_dev_deps()" >> .document.R
	echo "devtools::document('$(PKG_ROOT)')" >> .document.R
	Rscript --vanilla --quiet .document.R 2>&1 | tee .document.Rout
	/bin/rm .document.R
	if [ -e "$(PKG_ROOT)/vignettes/makefile" ]; then $(MAKE) -C $(PKG_ROOT)/vignettes/; fi

$(PKG_NAME)_$(PKG_VERSION).tar.gz: .document.Rout $(TESTS) $(PKG_ROOT)/DESCRIPTION
	R CMD build --no-resave-data --md5 $(build-options) $(PKG_ROOT)

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

clean:
	/bin/rm -f  $(PKG_NAME)_$(PKG_VERSION).tar.gz
	/bin/rm -rf $(PKG_NAME).Rcheck
	/bin/rm -f .document.Rout

