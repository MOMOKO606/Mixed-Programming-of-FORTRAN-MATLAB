program Main_fcm
use for_c_mat
parameter n=10
real(8) x(n),y(n),z(n)
!x和y赋初值
do i=1,n
  x(i)=3.1415926587*(i-1)/(n-1)
  y(i)=sin(x(i))
enddo
!打开Matlab
call startMatlab
!将x和y传入Matlab
call fdata2m(x,'x',1,n) 
call fdata2m(y,'y',1,n)
!在Matlab中画图
call executec("plot(x,y);title('y=sin(x)');xlabel('x');ylable('y');")
!在Matlab中计算
call executec('z=2*y;')
!结果返回Fortran
call mdata2f('z',z,1,n)
!显示结果
write(*,*) 'x=            ','y=             ','z=            ','2*y=          '
do i=1,n
  write(*,110) x(i),y(i),z(i),2*y(i)
enddo
110	format(g15.6,g15.6,g15.6,g15.6)
pause
call executec('close;')
call closematlab
end program