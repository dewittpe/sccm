#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void d2p_(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void p2d_(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void scmap_(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);

/* .Call calls */
extern SEXP _sccm_cartesian2polar(void *, void *);
extern SEXP _sccm_convex_hull_cpp(void *, void *);
extern SEXP _sccm_is_in_cpp(void *, void *, void *);
extern SEXP _sccm_polar2cartesian(void *, void *);
extern SEXP _sccm_polygon_cpp(void *, void *);

static const R_CMethodDef CEntries[] = {
    {"d2p_",   (DL_FUNC) &d2p_,   11},
    {"p2d_",   (DL_FUNC) &p2d_,   11},
    {"scmap_", (DL_FUNC) &scmap_, 10},
    {NULL, NULL, 0}
};

static const R_CallMethodDef CallEntries[] = {
    {"_sccm_cartesian2polar", (DL_FUNC) &_sccm_cartesian2polar, 2},
    {"_sccm_convex_hull_cpp", (DL_FUNC) &_sccm_convex_hull_cpp, 2},
    {"_sccm_is_in_cpp",       (DL_FUNC) &_sccm_is_in_cpp,       3},
    {"_sccm_polar2cartesian", (DL_FUNC) &_sccm_polar2cartesian, 2},
    {"_sccm_polygon_cpp",     (DL_FUNC) &_sccm_polygon_cpp,     2},
    {NULL, NULL, 0}
};

void R_init_sccm(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
