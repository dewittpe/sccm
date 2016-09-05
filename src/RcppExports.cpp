// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// convex_hull_cpp
Rcpp::List convex_hull_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y);
RcppExport SEXP sccm_convex_hull_cpp(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type y(ySEXP);
    __result = Rcpp::wrap(convex_hull_cpp(x, y));
    return __result;
END_RCPP
}
// polygon_cpp
Rcpp::List polygon_cpp(Rcpp::NumericVector x, Rcpp::NumericVector y);
RcppExport SEXP sccm_polygon_cpp(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type y(ySEXP);
    __result = Rcpp::wrap(polygon_cpp(x, y));
    return __result;
END_RCPP
}
