      subroutine predict(n,c,z,wc,w,betam,nptsq,qwork,zz,npred,ww)
      implicit complex*16(c,w,z), real*8(a-b,d-h,o-v,x-y)
      dimension z(1),w(1),betam(1),qwork(1),zz(1),ww(1)
c
c     compute predicted values
      do 10 i = 1,npred
        call nearz(zz(i),zn,wn,kn,n,z,wc,w,betam) 
        ww(i) = wsc(zz(i),0,zn,wn,kn,n,c,z,betam,nptsq,qwork)
   10   continue
c
      return
      end


      subroutine predictr(n,c,z,wc,w,betam,nptsq,qwork,ww,npred,zz)
      implicit complex*16(c,w,z), real*8(a-b,d-h,o-v,x-y)
      dimension z(1),w(1),betam(1),qwork(1),zz(1),ww(1)
c
c     compute predicted values
      ier = 0
      eps = 1e-6
      do 10 i = 1,npred
        iguess = 1
        if (i.eq.1) iguess = 0
        call nearw(ww(i),zn,wn,kn,n,z,wc,w,betam) 
        zz(i) = zsc(ww(i),iguess,zz(i-iguess),zn,wn,kn,eps,ier,
     &              n,c,z,wc,w,betam,nptsq,qwork)
   10   continue
c
      return
      end
