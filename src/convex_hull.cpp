#include <Rcpp.h>
#include "sccm.h"

// [[Rcpp::export]]
Rcpp::List convex_hull_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y) {
  std::vector<point> v;

  if (x.size() != y.size()) { 
    throw std::invalid_argument("length(x) != length(y)");
  }

  for (int i = 0; i < x.size(); ++i) {
    v.push_back(point(x(i), y(i), i));
  }

  convexhull ch(v);

  Rcpp::NumericMatrix h(ch.size(), 2);
  Rcpp::NumericVector eangle(ch.size());
  Rcpp::NumericVector iangle(ch.size());
  Rcpp::NumericVector idx(ch.size());

  for (size_t i = 0; i < ch.size(); ++i) { 
    h(i,0) = ch.hull[i].x;
    h(i,1) = ch.hull[i].y;
    eangle(i) = ch.beta[i];
    iangle(i) = ch.gamma[i]; 
    idx(i)   = ch.hull[i].id + 1;
  }

  Rcpp::NumericMatrix data(x.size(), 2);
  for (size_t i = 0; i < x.size(); ++i) { 
    data(i, 0) = x(i);
    data(i, 1) = y(i);
  } 

  Rcpp::colnames(h) = Rcpp::CharacterVector::create("x", "y");

  return Rcpp::List::create(
      Rcpp::Named("vertices") = h, 
      Rcpp::Named("data") = data, 
      Rcpp::Named("beta") = eangle, 
      Rcpp::Named("gamma") = iangle, 
      Rcpp::Named("indices") = idx
      );
} 
