	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,status
	integer plhs(*),prhs(*),x(1)
	integer mxIsChar,mexCallMATLAB
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('One input required.')
	elseif(nlhs.ne.0)then
	  call mexErrMsgTxt('No output required.')
	endif
	if(mxIsChar(prhs(1)).ne.1)then
	  call mexErrMsgTxt('Input must be a string.')
	endif
	status=mexCallMATLAB(1,x,1,prhs,'imread')
	if(status.ne.0)then
	  call mexErrMsgTxt('Something is wrong.')
	endif
	status=mexCallMATLAB(0,null,1,x,'imshow')
	if(status.ne.0)then
	  call mexErrMsgTxt('Something is wrong.')
	endif
	call mxDestroyArray(x(1))
	end subroutine