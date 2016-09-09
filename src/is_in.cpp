#include <Rcpp.h>
#include "sccm.h"

// left_of tests if a point v is left, on, or right of the line defined by the
// poinsts a and b.
//
// input  three vertices v, a, and b.
//
// return > 0 if v is left of the line defined by points a and b
//        = 0 if v is on the line defined by points a and b
//        < 0 if v is right of the line defined by points a and b
int left_of(const point& v, const point& a, const point& b) {
  return ( (b.x - a.x) * (v.y - a.y) - (v.x -  a.x) * (b.y - a.y) ); 
} 

// winding_number: 
//
// input:  a point and a vector of vertices defining the polygon
//
// return: the winding number.  >
//
//


// // wn_PnPoly(): winding number test for a point in a polygon
// //      Input:   P = a point,
// //               V[] = vertex points of a polygon V[n+1] with V[n]=V[0]
// //      Return:  wn = the winding number (=0 only when P is outside)
// int
// wn_PnPoly( Point P, Point* V, int n )
// {
//     int    wn = 0;    // the  winding number counter
// 
//     // loop through all edges of the polygon
//     for (int i=0; i<n; i++) {   // edge from V[i] to  V[i+1]
//         if (V[i].y <= P.y) {          // start y <= P.y
//             if (V[i+1].y  > P.y)      // an upward crossing
//                  if (isLeft( V[i], V[i+1], P) > 0)  // P left of  edge
//                      ++wn;            // have  a valid up intersect
//         }
//         else {                        // start y > P.y (no test needed)
//             if (V[i+1].y  <= P.y)     // a downward crossing
//                  if (isLeft( V[i], V[i+1], P) < 0)  // P right of  edge
//                      --wn;            // have  a valid down intersect
//         }
//     }
//     return wn;
// }
