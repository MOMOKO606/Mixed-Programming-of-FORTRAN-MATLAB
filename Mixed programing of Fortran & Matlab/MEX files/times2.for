!	������򲿷�
	subroutine times2(size,a,b)
	integer size
	real(8) a(*),b(*)
	do i=1,size
	  b(i)=2.0*a(i)
	enddo
	end subroutine
******д��1��ͨ��д��(Fortran 77)�Ľӿں���****************************************************
	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,x_pr,y_pr,size
	integer plhs(*),prhs(*)
	integer mxGetM,mxGetN,mxGetPr
	real(8) x(100),y(100)
!	������������������
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('one input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('one putput required.')
	endif
!	��ȡ���ݴ�С
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
!	�������mxArray����
	plhs(1)=mxCreateDoubleMatrix(m,n,0)
!	��������������ָ��
	y_pr=mxGetPr(plhs(1))
	x_pr=mxGetPr(prhs(1))
!	��Matlab�������ݴ���Fortran��
	call mxCopyPtrToReal8(x_pr,x,size)
!	���ü������
	call times2(size,x,y)
!	��������(Fortran����)����Matlab��
	call mxCopyReal8ToPtr(y,y_pr,size)
	end subroutine
******д��2��ʹ��%val(Fortran 90)�Ľӿں���****************************************************	  
	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,x_pr,y_pr,size
	integer plhs(*),prhs(*)
	integer mxGetM,mxGetN,mxGetPr
	real(8) x(100),y(100)	
!	������������������
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('one input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('one putput required.')
	endif
!	��ȡ���ݴ�С
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
!	�������mxArray����
	plhs(1)=mxCreateDoubleMatrix(m,n,0)
!	��������������ָ��
	y_pr=mxGetPr(plhs(1))
	x_pr=mxGetPr(prhs(1))
!	���ü������
	call times2(size,%val(x_pr),%val(y_pr))
	end subroutine