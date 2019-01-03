	subroutine mexFunction(nlhs, plhs, nrhs, prhs)
      integer plhs(*), prhs(*)
	integer nlhs, nrhs
	call mexPrintf('Hello MATLAB World!')
	end 
