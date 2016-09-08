#include <Rcpp.h>
#include "sccm.h"

// [[Rcpp::export]]
Rcpp::NumericMatrix polar2cartesian_cpp(Rcpp::NumericVector r, Rcpp::NumericVector theta)
{

  if (r.size() != theta.size()) { 
    throw std::invalid_argument("length(r) != length(theta)");
  }

  Rcpp::NumericMatrix out(r.size(), 2);

  for (int i = 0; i < r.size(); ++i) {
    out(i, 0) = r(i) * cos(theta(i));
    out(i, 1) = r(i) * sin(theta(i));
  }

  return out;
}

// [[Rcpp::export]]
Rcpp::NumericMatrix cartesian2polar_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y)
{

  if (x.size() != y.size()) { 
    throw std::invalid_argument("length(x) != length(y)");
  }

  Rcpp::NumericMatrix out(x.size(), 2);

  for (int i = 0; i < x.size(); ++i) {
    out(i, 0) = sqrt(pow(x(i), 2) + pow(y(i), 2));
    out(i, 1) = atan2(y(i), x(i));
  }

  return out;
}
