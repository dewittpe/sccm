      subroutine fit(n,w,wc,betam,nptsq,tol,errest,c,z,qwork)
      implicit complex*16(c,w,z), real*8(a-b,d-h,o-v,x-y)
      dimension z(1),w(1),betam(1),qwork(1)
c
c compute nodes and weights for parameter problem:
      call qinit(n,betam,nptsq,qwork)
c
c solve parameter problem:
      iprint = 0
      iguess = 0
      tol = 10.**(-nptsq-1)
      call scsolv(iprint,iguess,tol,errest,n,c,z,
     &  wc,w,betam,nptsq,qwork)

      return
      end
