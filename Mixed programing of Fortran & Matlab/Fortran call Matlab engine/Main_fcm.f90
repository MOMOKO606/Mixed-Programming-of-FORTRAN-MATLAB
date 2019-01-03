program Main_fcm
use for_c_mat
parameter n=10
real(8) x(n),y(n),z(n)
!x��y����ֵ
do i=1,n
  x(i)=3.1415926587*(i-1)/(n-1)
  y(i)=sin(x(i))
enddo
!��Matlab
call startMatlab
!��x��y����Matlab
call fdata2m(x,'x',1,n) 
call fdata2m(y,'y',1,n)
!��Matlab�л�ͼ
call executec("plot(x,y);title('y=sin(x)');xlabel('x');ylable('y');")
!��Matlab�м���
call executec('z=2*y;')
!�������Fortran
call mdata2f('z',z,1,n)
!��ʾ���
write(*,*) 'x=            ','y=             ','z=            ','2*y=          '
do i=1,n
  write(*,110) x(i),y(i),z(i),2*y(i)
enddo
110	format(g15.6,g15.6,g15.6,g15.6)
pause
call executec('close;')
call closematlab
end program