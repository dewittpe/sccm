#include <Rcpp.h>
#include "structures.h"

// 2D cross product.  Following the right-hand rule, an anti-clockwise turn from
// A to B will have a positive value, a clockwise turn will have a negative
// value, 0 for colinear points.
double crossproduct(const vertex& origin, const vertex& A, const vertex& B) { 
  return (A.x - origin.x) * (B.y - origin.y) - (A.y - origin.y) * (B.x - origin.x);
}

std::vector<vertex> convex_hull_andrew_monotone(std::vector<vertex>& v) {
  int n = v.size(), k = 0;

  Rcpp::Rcout << "n = " << n << std::endl;

  std::vector<vertex> hull(2 * n);

  sort(v.begin(), v.end());

  // Lower Hull
  for (int i = 0; i < n; ++i) { 
    while (k >= 2 && crossproduct(hull[k-2], hull[k-1], v[i]) <= 0) {
      --k;
    }
    hull[k++] = v[i];
  }

  // Upper Hull
  for (int i = n - 2, t = k+1; i >= 0; --i) {
    while (k >= t && crossproduct(hull[k - 2], hull[k - 1], v[i]) <= 0) {
      --k;
    }
    hull[k++] = v[i];
  }

  hull.resize(k-1);
  return hull; 
}

//' Convex Hull
//'
//' return the convex hull for a set of (x, y) points
//'
//' @param x a numeric vector of x coordinates
//' @param y a numeric vector of y coordinates
//' 
//' @return a matrix, the convex hull vertices listed in an anti-clockwise
//' order.
//'
//' @examples
//' x <- rnorm(200)
//' y <- rnorm(200)
//' 
//' hull <- convex_hull(x, y)
//' 
//' plot(x, y)
//' lines(hull[, 1], hull[, 2])
//'
//' @export
// [[Rcpp::export]]
Rcpp::NumericMatrix convex_hull(Rcpp::NumericVector x, Rcpp::NumericVector y) {
  std::vector<vertex> v;

  if (x.size() != y.size()) { 
    throw std::invalid_argument("length(x) != length(y)");
  }

  for (int i = 0; i < x.size(); ++i) {
    v.push_back(vertex(x(i), y(i)));
  }

  v = convex_hull_andrew_monotone(v);

  Rcpp::NumericMatrix rtn(v.size(), 2);

  for (size_t i = 0; i < v.size(); ++i) { 
    rtn(i,0) = v[i].x;
    rtn(i,1) = v[i].y;
  }

  return rtn;
}
