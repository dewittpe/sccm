# sccm: Schwarz-Christoffel Conformal Mapping

An R package Providing a conformal mapping of one 2D polygon to a rectangular
region via the Schwarz-Christoffel theorem.

Methods are provide to find a convex hull for an arbitrary set (x, y)
coordinates.  This hull, and the points within, are, via an (inverse)
Schwarz-Christoffel mapping, mapped to the unit disk.  A second
Schwarz-Christoffel mapping from the unit disk to an arbitrary rectangle is use
to finish the conformal mapping.

This package builds hulls via Andrew's monotone chain algorithm implemented in
C++. The Schwarz-Christoffel mappings are provided by the fortran SCPACK by
Lloyd N. Trefethen.

## Methods

Useful methods in this package:

* `convex_hull`: given a set of (x, y) coordinates, return the convex hull.
* `d2p`: the conformal mapping from the unit disk to a given polygon.
* `p2d`: the (inverse) conformal mapping from a polygon to the unit disk.
* `p2p`: a composite mapping from one polygon to another polygon.

## Install
This package is currently *not* on CRAN.  You can install from the
developmental version via 
[`devtools`](https://github.com/hadley/devtools) package:

    if (!("devtools" %in% rownames(installed.packages()))) { 
      warning("installing devtools from https://cran.rstudio.com")
      install.packages("devtools", 
                       repo = "https://cran.rstudio.com")
    }

    devtools::install_github("dewittpe/sccm")

If you are working on a Windows machine you will need to download and install
[`Rtools`](http://cran.r-project.org/bin/windows/Rtools/) before `devtools` will
work for you.

