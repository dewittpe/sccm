#include <Rcpp.h>
#include "sccm.h"

// winding_number: 
//
// input:  a point and a vector of vertices defining the polygon
//
// return: the winding number.
//
// code adapted from an answer on stackoverflow
// http://stackoverflow.com/a/2922778/1104685
//
int winding_number(const point& p, std::vector<point>& v) {
  int i, j, wn = 0;

  for (i = 0, j = v.size() - 1; i < v.size(); j = i++) {
    if ( ((v[i].y > p.y) != (v[j].y > p.y)) &&
        (p.x < (v[j].x - v[i].x) * (p.y - v[i].y) / (v[j].y - v[i].y) + v[i].x) )
      wn = !wn;
  }

  return wn;
}


// return 1 if (x, y) is on the interior of the polygon
// return 0 if (x, y) is on the exterior of the polygon
//
// [[Rcpp::export]]
Rcpp::IntegerVector is_in_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y, Rcpp::NumericMatrix v) {
  std::vector<point> p(x.size());
  std::vector<point> vertex(v.nrow() + 1);
  Rcpp::IntegerVector out(x.size());

  int i;

  for (i = 0; i < x.size(); ++i) {
    p[i] = point(x(i), y(i));
  }

  for (i = 0; i < v.nrow(); ++i) {
    vertex[i] = point(v(i, 0), v(i, 1));
  } 
  vertex[i] = point(v(0, 0), v(0, 1));

  for (i = 0; i < x.size(); ++i) {
    out(i) = winding_number(p[i], vertex); 
  }

  return out;
}

