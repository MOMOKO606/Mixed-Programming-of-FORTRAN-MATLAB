	subroutine mexFunction(nlhs,plhs,nrhs,prhs)
!	参数声明
	integer plhs(*),prhs(*),pr
	integer nlhs,nrhs,m,n,size,status
	integer mxGetString,mxCreateString,mxIsChar,mxGetM,mxGetN
	character*32 input_buf,output_buf
!	输入和输出参数个数检查
	if(nrhs.ne.1)then
	  call mexErrMsgTxt('One input required.')
	elseif(nlhs.ne.1)then
	  call mexErrMsgTxt('One output required')
	elseif(mxGetM(prhs(1)).ne.1)then 
	  call mexErrMsgTxt('Input must be a row vector.')
	elseif(mxIsChar(prhs(1)).ne.1)then
	  call mexErrMsgTxt('Input must be a string.')
	endif
!	判断输入的参数尺寸
	m=mxGetM(prhs(1))
	n=mxGetN(prhs(1))
	size=m*n
	if(size.gt.30)then
	  call mexErrMsgTxt('Too long of the input string!')
	endif
!	获取字符串
	status=mxGetString(prhs(1),input_buf,size)
	if (status .ne. 0) then 
         call mexErrMsgTxt('Input string failed.')
      endif
!	output_buf=''
!	调用算法函数
	call revord(input_buf,size,output_buf)
!	结果返回输出指针
	plhs(1)=mxCreateString(output_buf)
	end
	
	subroutine revord(input_buf,strlen,output_buf)
	character input_buf(*),output_buf(*)
	integer strlen
	do i=1,strlen
	  output_buf(i)=input_buf(strlen-i+1)
	enddo
	end subroutine