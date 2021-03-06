#include <Rcpp.h>
#include "sccm.h"

// [[Rcpp::export]]
Rcpp::List polygon_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y) {
  std::vector<point> v;

  if (x.size() != y.size()) { 
    throw std::invalid_argument("length(x) != length(y)");
  }

  for (int i = 0; i < x.size(); ++i) {
    v.push_back(point(x(i), y(i), i));
  }

  polygon pg(v);

  Rcpp::NumericMatrix vertices(pg.size(), 2);
  Rcpp::NumericVector angle(pg.size());
  Rcpp::NumericVector idx(pg.size());

  for (size_t i = 0; i < pg.size(); ++i) { 
    vertices(i,0) = pg.v[i].x;
    vertices(i,1) = pg.v[i].y;
    angle(i) = pg.beta[i];
    idx(i)   = pg.v[i].id + 1;
  }

  Rcpp::colnames(vertices) = Rcpp::CharacterVector::create("x", "y");

  return Rcpp::List::create(
      Rcpp::Named("vertices") = vertices, 
      Rcpp::Named("beta") = angle
      );
} 
