# sccm: Schwarz-Christoffel Conformal Mapping

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/dewittpe/sccm.svg?branch=master)](https://travis-ci.org/dewittpe/sccm)

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

* `convex_hull`: given a set of (x, y) coordinates, return the convex hull,
  vertices listed in an anti-clockwise order, and the exterior angles at each
  vertex.

* `polygon`: given a set of (x, y) coordinates return, return the coordinates
  and the exterior angles at each vertex.  

* `is_in`: given a point and polygon, determin if the point is within, on, or
  outside of the polygon.  

* `polar2cartesian` : quick translation from polar to cartesian coordinates.

* `cartesian2polar` : quick translation from cartesian to polar coordinates.  

* `d2p`: the conformal mapping from the unit disk to a given polygon.

* `p2d`: the (inverse) conformal mapping from a polygon to the unit disk.

* `p2p`: a composite mapping from one polygon to another polygon.

## Date Sets

Two MC Escher images used to illustrate the conformal mappings
* `CircleLimitI`
* `HexagonalFish`

## Vignettes
Within R run

    vignette("sccm-overview", package = "sccm")

to get a detailed overview of the package.

## Install

### Not on [CRAN](https://cran.rstudio.com)
This package is currently **not** on CRAN.  Some elements of Trefethen's FORTRAN
code is not compliant with the standards set by CRAN.  (writing to stdin/stdout,
and stops)  A long term goal is to edit the FORTRAN code to make it CRAN
compliant.

    * checking compiled code ... NOTE
    File ‘sccm/libs/sccm.so’:
      Found ‘_gfortran_st_write’, possibly from ‘write’ (Fortran), ‘print’
        (Fortran)
        Objects: ‘sclibdbl.o’, ‘scpdbl.o’
      Found ‘_gfortran_stop_string’, possibly from ‘stop’ (Fortran)
        Object: ‘scpdbl.o’
 
### Install form Github

If you clone this repository you should be able to install the package via GNU
make:

    make install

Or, you can install this package from github using the
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

