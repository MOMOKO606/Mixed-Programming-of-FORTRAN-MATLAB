	program plot_sinx
	integer ep,ptemp,status
	integer engOpen,engClose,engPutVariable,engEvalString
	integer mxCreateDoubleMatrix,mxCopyReal8ToPtr,mxGetPr
	dimension x(63),y(63)
	double precision x,y
	do i=1,63
	  x(i)=(i-1)*0.1
	  y(i)=sin(x(i))
	enddo
	ep=engOpen('matlab')
	if(ep.eq.0)then
	  write(*,*) 'can not start Matlab engine'
	endif
	ptemp=mxCreateDoubleMatrix(1,63,0)
	if(ptemp.eq.0)then
	  write(*,*) 'can not create mxArray'
	endif
	call mxCopyReal8ToPtr(y,mxGetPr(ptemp),63)
	status=engPutVariable(ep,'y',ptemp)
	if(status.eq.1)then
	  write(*,*) '不能将数据输入mxArray中'
	endif
	call mxDestroyArray(ptemp)
	status=engEvalString(ep,'plot(y);')
	if(status.ne.0)then
	  write(*,*) 'engEvalString failed'
	endif
	stop
	status=engClose(ep)
	if(status.ne.0)then
	  write(*,*) 'can not close Matlab engine'
	endif
	end program