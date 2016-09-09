#include <Rcpp.h>

#ifndef SCCM_H
#define SCCM_H

struct point { 
  point() : x(0), y(0), id(0){}
  point(double x, double y, int id) : x(x), y(y), id(id){} 

  double x, y;
  int id;

  double norm() {return sqrt(pow(x, 2) + pow(y, 2));}

  point operator -(const point& v) const {
    return point(x - v.x, y - v.y, -1);
  }

  bool operator <(const point &v) const {
    return x < v.x || (x == v.x && y < v.y);
  }
};

struct convexhull {
  std::vector<point> hull;  // vertices of the convex hull
  std::vector<double> beta;  // exterior angles

  convexhull(std::vector<point>& _v); 

  int size() {return hull.size();}
};

struct polygon {
  std::vector<point> v;  // vertices of the convex hull
  std::vector<double> beta;    // exterior angles

  polygon(std::vector<point>& _v); 

  int size() {return v.size();}
};


// 2D cross product.  Following the right-hand rule, an anti-clockwise turn from
// A to B will have a positive value, a clockwise turn will have a negative
// value, 0 for colinear points.
double crossproduct(const point& origin, const point& A, const point& B);
double dotproduct(const point& origin, const point& A, const point& B);
double norm(const point& origin, const point& A);
double exterior_angle(const point& origin, const point& A, const point& B);

#endif
