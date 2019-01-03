!	计算程序部分
	subroutine times2(size,a,b)
	integer size
	real(8) a(*),b(*)
	do i=1,size
	  b(i)=2.0*a(i)
	enddo
	end subroutine
******写法1：通用写法(Fortran 77)的接口函数****************************************************
	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,x_pr,y_pr,size
	integer plhs(*),prhs(*)
	integer mxGetM,mxGetN,mxGetPr
	real(8) x(100),y(100)
!	检查输入输出参数个数
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('one input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('one putput required.')
	endif
!	获取数据大小
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
!	创建输出mxArray矩阵
	plhs(1)=mxCreateDoubleMatrix(m,n,0)
!	获得输入输出数据指针
	y_pr=mxGetPr(plhs(1))
	x_pr=mxGetPr(prhs(1))
!	将Matlab输入数据传入Fortran中
	call mxCopyPtrToReal8(x_pr,x,size)
!	调用计算程序
	call times2(size,x,y)
!	将计算结果(Fortran数组)传入Matlab中
	call mxCopyReal8ToPtr(y,y_pr,size)
	end subroutine
******写法2：使用%val(Fortran 90)的接口函数****************************************************	  
	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
	integer nlhs,nrhs,x_pr,y_pr,size
	integer plhs(*),prhs(*)
	integer mxGetM,mxGetN,mxGetPr
	real(8) x(100),y(100)	
!	检查输入输出参数个数
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('one input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('one putput required.')
	endif
!	获取数据大小
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
!	创建输出mxArray矩阵
	plhs(1)=mxCreateDoubleMatrix(m,n,0)
!	获得输入输出数据指针
	y_pr=mxGetPr(plhs(1))
	x_pr=mxGetPr(prhs(1))
!	调用计算程序
	call times2(size,%val(x_pr),%val(y_pr))
	end subroutine