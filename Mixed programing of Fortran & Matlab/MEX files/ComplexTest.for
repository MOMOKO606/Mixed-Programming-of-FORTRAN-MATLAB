	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,m,n,size,x_pr,x_pi,y_pr,y_pi
	integer plhs(*),prhs(*)
	integer mxGetM,mxGetN,mxGetPr,mxGetPi,mxCreateDoubleMatrix,
     &        mxIsComplex
	complex*16 x(100),y(100)
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('One input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('One output required.')
	endif	
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
	if(mxIsComplex(prhs(1)).eq.0)then
	  call mexErrMsgTxt('Input must be a complex.')
	endif
	x_pr=mxGetPr(prhs(1))
	x_pi=mxGetPi(prhs(1))
	call mxCopyPtrToComplex16(x_pr,x_pi,x,size)
	call times2(x,size,y)
	plhs(1)=mxCreateDoubleMatrix(m,n,1)
	y_pr=mxGetPr(plhs(1))
	y_pi=mxGetPi(plhs(1))
	call mxCopyComplex16ToPtr(y,y_pr,y_pi,size)
	end subroutine
	
	subroutine times2(x,size,y)
	integer size
	complex*16 x(*),y(*)
	do i=1,size
	  y(i)=2.0*x(i)
	enddo
	end subroutine