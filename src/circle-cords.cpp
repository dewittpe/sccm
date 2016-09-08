// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
#include <Rcpp.h>
#include "sccm.h"


//' Translate between Polar and Cartesian Coordinates.
//'
//' Given (x,y) return (r, theta), or visa-versa.
//'
//' @param r a numeric vector of radii
//' @param theta a numeric vector of angles (in radians)
//' @export
//' @rdname polar2cartesian
// [[Rcpp::export]]
Rcpp::NumericMatrix polar2cartesian(arma::vec r, arma::vec theta)
{

  if (r.size() != theta.size()) { 
    if (r.size() == 1) { 
      r.resize(theta.size());
      r.fill(r(0));
    } else if (theta.size() == 1) {
      theta.resize(r.size());
      theta.fill(theta(0));
    } else { 
      throw std::invalid_argument("length(r) == length(theta), or length(r) == 1, or length(theta) == 1 required.");
    }
  }

  Rcpp::NumericMatrix out(r.size(), 2);

  for (int i = 0; i < r.size(); ++i) {
    out(i, 0) = r(i) * cos(theta(i));
    out(i, 1) = r(i) * sin(theta(i));
  }

  return out;
}

//' @param x a numeric vector of x coordinates
//' @param y a numeric vector of y coordinates
//' 
//' @return A numeric matrix
//' 
//' @export
//' @rdname polar2cartesian
// [[Rcpp::export]]
Rcpp::NumericMatrix cartesian2polar(arma::vec x, arma::vec y)
{

  if (x.size() != y.size()) { 
    if (x.size() == 1) { 
      x.resize(y.size());
      x.fill(x(0));
    } else if (y.size() == 1) {
      y.resize(x.size());
      y.fill(y(0));
    } else { 
      throw std::invalid_argument("length(r) == length(y), or length(r) == 1, or length(y) == 1 required.");
    }
  }

  Rcpp::NumericMatrix out(x.size(), 2);

  for (int i = 0; i < x.size(); ++i) {
    out(i, 0) = sqrt(pow(x(i), 2) + pow(y(i), 2));
    out(i, 1) = atan2(y(i), x(i));
  }

  return out;
}
