#include <Rcpp.h>
#include "sccm.h"

convexhull::convexhull(std::vector<vertex>& _v) {

  int k = 0, n = _v.size();

  hull.resize(2*n);

  sort(_v.begin(), _v.end());

  // Lower Hull
  for (int i = 0; i < n; ++i) { 
    while (k >= 2 && crossproduct(hull[k-2], hull[k-1], _v[i]) <= 0) {
      --k;
    }
    hull[k++] = _v[i];

  }

  // Upper Hull
  for (int i = n - 2, t = k+1; i >= 0; --i) {
    while (k >= t && crossproduct(hull[k - 2], hull[k - 1], _v[i]) <= 0) {
      --k;
    }
    hull[k++] = _v[i];
  }

  hull.resize(k-1); 
}


double crossproduct(const vertex& origin, const vertex& A, const vertex& B) { 
  return (A.x - origin.x) * (B.y - origin.y) - (A.y - origin.y) * (B.x - origin.x);
}

double dotproduct(const vertex& origin, const vertex& A, const vertex& B) {
  return (A.x - origin.x) * (B.x - origin.x) + (A.y - origin.y) * (B.y - origin.y);
}

double norm(const vertex& origin, const vertex& A) {
  return sqrt(pow((A.x - origin.x),2) + pow((A.y - origin.y), 2));
}
