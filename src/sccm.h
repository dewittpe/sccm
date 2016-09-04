#include <Rcpp.h>

#ifndef SCCM_H
#define SCCM_H

struct vertex { 
  vertex() : x(0), y(0), id(0){}
  vertex(double x, double y, int id) : x(x), y(y), id(id){} 

  double x, y;
  int id;

  bool operator <(const vertex &v) const {
    return x < v.x || (x == v.x && y < v.y);
  }
};

struct convexhull {
  std::vector<vertex> hull;  // vertices of the convex hull
  std::vector<double> beta;  // interior angles

  convexhull(std::vector<vertex>& _v); 

  int size() {return hull.size();}
};


// 2D cross product.  Following the right-hand rule, an anti-clockwise turn from
// A to B will have a positive value, a clockwise turn will have a negative
// value, 0 for colinear points.
double crossproduct(const vertex& origin, const vertex& A, const vertex& B);
double dotproduct(const vertex& origin, const vertex& A, const vertex& B);
double norm(const vertex& origin, const vertex& A);

#endif
