#include <Rcpp.h>
#include "sccm.h"

polygon::polygon(std::vector<vertex>& _v){
  v = _v;
  int n = v.size();

  // angles
  beta.resize(n); 
  beta[0]     = exterior_angle(v[n - 1], v[0], v[1]);
  beta[n - 1] = exterior_angle(v[n - 2], v[n - 1], v[0]); 

  for (int i = 1; i < n - 1; ++i) { 
    beta[i] = exterior_angle(v[i - 1], v[i], v[i + 1]);
  } 
}

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
  n = hull.size();

  // angles
  beta.resize(n); 
  beta[0]     = exterior_angle(hull[n - 1], hull[0], hull[1]);
  beta[n - 1] = exterior_angle(hull[n - 2], hull[n - 1], hull[0]); 

  for (int i = 1; i < n - 1; ++i) { 
    beta[i] = exterior_angle(hull[i - 1], hull[i], hull[i + 1]);
  } 
}


double crossproduct(const vertex& origin, const vertex& A, const vertex& B) { 
  return (A.x - origin.x) * (B.y - origin.y) - (A.y - origin.y) * (B.x - origin.x);
}

double crossproduct(const vertex& A, const vertex& B) { 
  return A.x * B.y - A.y * B.x;
}

double dotproduct(const vertex& A, const vertex& B) {
  return (A.x * B.x) + (A.y * B.y);
}

double exterior_angle(const vertex& origin, const vertex& A, const vertex& B) {
 return atan2(crossproduct(A - origin, B - A), dotproduct(A - origin, B - A));
}
