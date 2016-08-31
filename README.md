# sct

Provide a conformal mapping of one 2D polygon to a rectangular region via the
Schwarz-Christoffel theorem.

Methods are provide to find a convex hull for an arbitrary set (x, y)
coordinates.  This hull, and the points within, are, via an (inverse)
Schwarz-Christoffel mapping, mapped to the unit disk.  A second
Schwarz-Christoffel mapping from the unit disk to an arbitrary rectangle is use
to finish the conformal mapping.

This package builds hulls via Andrew's monotone chain algorithm implemented in
C++. The Schwarz-Christoffel mappings are provided by the fortran SCPACK by
Lloyd N. Trefethen.

