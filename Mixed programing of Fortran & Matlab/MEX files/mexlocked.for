!	Demo file about mexlock & mex
	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	external closeup
	integer plhs(*),prhs(*)
	integer nlhs,nrhs
	integer mexIsLocked
	real*8 mxGetScalar
	real*8 lock
	integer status
!	代码行
	status=mexAtExit(closeup)
	if(status.ne.0)then
	  call mexErrMsgTxt('Register Exit subroutine error!')
	endif
!	参数检查
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('Input argument must be a real scalar double')
	elseif((mxIsDouble(prhs(1)).ne.1).or.
     &       (mxGetN(prhs(1))*mxGetM(prhs(1)).ne.1).or.
     &       (mxIsComplex(prhs(1)).eq.1))then
	  call mexErrMsgTxt('Input argument must be a real scalar double')
	endif
	lock=mxGetScalar(prhs(1))
!	参数检查
	if((lock.ne.0.0).and.(lock.ne.1.0).and.(lock.ne.-1.0))then
	  call mexErrMsgTxt('Input argument must be either 1 to lock or -1 
     &                     to unlock or 0 for lock status')
	endif
!	锁定操作
	if(mexIsLocked().eq.1) then
	  if(lock.gt.0.0) then
	    call mexWarnMsgTxt('MEX-file is already locked')
	  elseif(lock.lt.0.0) then
	    call mexUnlock()
	    call mexPrintf('MEX-file is unlocked') 
	  else
		call mexPrintf('MEX-file is locked') 
	  endif
	else
	  if(lock.lt.0.0) then
	    call mexWarnMsgTxt('MEX-file is already unlocked')
	  elseif(lock.gt.0.0) then
	    call mexLock()
		call mexPrintf('MEX-file is locked')
	  else 
		call mexPrintf('MEX-file is unlocked')
        endif    
	endif 
	end subroutine

	subroutine closeup()
	call mexPrintf('Exit the MEX file')
	end 
