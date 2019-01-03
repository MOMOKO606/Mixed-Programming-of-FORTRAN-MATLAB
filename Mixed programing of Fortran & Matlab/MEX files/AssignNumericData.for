	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer plhs(*),prhs(*)
	integer nlhs,nrhs,pr
	integer mxGetPr,mxCreateDoubleMatrix
	if(nlhs.ne.1)then
	  call mexErrMsgTxt('one output required')
	endif
	plhs(1)=mxCreateDoubleMatrix(2,3,0)
	pr=mxGetPr(plhs(1))
	call AssignNumericData(pr)
	end subroutine
	
	subroutine AssignNumericData(pr)
	integer pr
	real(8) fdata(6)
	data fdata/1.,2.,3.,4.,5.,6./
	call mxCopyReal8Toptr(fdata,pr,6)
	end subroutine
