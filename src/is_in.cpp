#include <Rcpp.h>
#include "sccm.h"

// left_of tests if a point v is left, on, or right of the line defined by the
// poinsts a and b.
//
// input  three vertices v, a, and b.
//
// return > 0 if v is left of the line defined by points a and b
//        = 0 if v is on the line defined by points a and b
//        < 0 if v is right of the line defined by points a and b
int left_of(const point& v, const point& a, const point& b) {
  double lf = (b.x - a.x) * (v.y - a.y) - (v.x -  a.x) * (b.y - a.y); 

  if (lf < 0) { 
    return -1;
  } else if (lf > 0) { 
    return 1;
  } else {
    return 0;
  }
} 

// winding_number: 
//
// input:  a point and a vector of vertices defining the polygon
//
// return: the winding number.  >
//
int winding_number(const point& p, std::vector<point>& v) {
  int wn = 0;
  int lf;

  for (int i = 0; i < v.size(); ++i) {
    lf = left_of(p, v[i], v[i+1]);
    if (lf == 0) { 
      wn = -1;
      i = v.size();
    } else if (v[i].y <= p.y && v[i+1].y > p.y) {
      if (lf > 0) {
        ++ wn;
      }
    } else {
      if (v[i+1].y <= p.y) { 
        if (lf < 0) { 
          -- wn;
        }
      }
    }
  } 
  return wn;
}


// return 1 if (x, y) is on the interior of the polygon
// return 0 if (x, y) is on the exterior of the polygon
// return -1 if (x, y) is on an edge of the polygon.
//
// [[Rcpp::export]]
int is_in_cpp(double x, double y, Rcpp::NumericMatrix v) {
  point p(x, y);

  std::vector<point> vertex(v.nrow());

  for (int i = 0; i < v.nrow(); ++i) {
    vertex[i] = point(v(i, 0), v(i, 1));
  }

  return winding_number(p, vertex); 
}
