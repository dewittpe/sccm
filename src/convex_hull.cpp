#include <Rcpp.h>
#include "sccm.h"

// [[Rcpp::export]]
Rcpp::NumericMatrix convex_hull_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y) {
  std::vector<vertex> v;

  if (x.size() != y.size()) { 
    throw std::invalid_argument("length(x) != length(y)");
  }

  for (int i = 0; i < x.size(); ++i) {
    v.push_back(vertex(x(i), y(i), i));
  }

  convexhull ch(v);

  Rcpp::NumericMatrix rtn(ch.n, 2);
  Rcpp::NumericVector idx(ch.n);

  for (size_t i = 0; i < ch.n; ++i) { 
    rtn(i,0) = ch.hull[i].x;
    rtn(i,1) = ch.hull[i].y;
    idx(i)   = ch.hull[i].id + 1;
  }

  Rcpp::colnames(rtn) = Rcpp::CharacterVector::create("x", "y");
  rtn.attr("indices") = idx;
  rtn.attr("class")   = "sccm_ch";

  return rtn;
} 
