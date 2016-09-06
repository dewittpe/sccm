#include <Rcpp.h>

#ifndef SCCM_H
#define SCCM_H

struct vertex { 
  vertex() : x(0), y(0), id(0){}
  vertex(double x, double y, int id) : x(x), y(y), id(id){} 

  double x, y;
  int id;

  double norm() {return sqrt(pow(x, 2) + pow(y, 2));}

  vertex operator -(const vertex& v) const {
    return vertex(x - v.x, y - v.y, -1);
  }

  bool operator <(const vertex &v) const {
    return x < v.x || (x == v.x && y < v.y);
  }
};

struct convexhull {
  std::vector<vertex> hull;  // vertices of the convex hull
  std::vector<double> beta;  // exterior angles

  convexhull(std::vector<vertex>& _v); 

  int size() {return hull.size();}
};

struct polygon {
  std::vector<vertex> v;  // vertices of the convex hull
  std::vector<double> beta;    // exterior angles

  polygon(std::vector<vertex>& _v); 

  int size() {return v.size();}
};


// 2D cross product.  Following the right-hand rule, an anti-clockwise turn from
// A to B will have a positive value, a clockwise turn will have a negative
// value, 0 for colinear points.
double crossproduct(const vertex& origin, const vertex& A, const vertex& B);
double dotproduct(const vertex& origin, const vertex& A, const vertex& B);
double norm(const vertex& origin, const vertex& A);
double exterior_angle(const vertex& origin, const vertex& A, const vertex& B);

#endif
