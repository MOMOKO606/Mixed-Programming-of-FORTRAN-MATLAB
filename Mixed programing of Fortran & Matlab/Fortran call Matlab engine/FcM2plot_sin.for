*******************************************************************************
*  Fortran调用Matlab引擎示例程序
*  程序功能说明：
*  第一部分：在Fortran中计算y=sin(x)，再调用Matlab引擎画出sin曲线图；
*  第二部分：在Matlab引擎中计算每个y值对应的角度agl，结果传回Fortran并输出。
*******************************************************************************
	program FcM2plot_sin
	parameter pi=3.1415926535898
	integer ep,status,ptemp,t
	integer engOpen,engClose,engPutVariable,engGetVariable,
     &        engEvalString
	integer mxCreateDoubleMatrix,mxCopyReal8ToPtr,mxGetPr
     &        mxCopyPtrToReal8,mxDestroyArray
	dimension y(25),agl(25)
	double precision x,y,agl
!	计算y=sin(x)
	x=-pi/12.0
	do i=1,25
	  x=x+pi/12.0
	  y(i)=sin(x)
	enddo
******第一部分：调用Matlab引擎画正弦曲线图************************************
!	打开Matlab引擎	
	ep=engOpen('matlab')
	if(ep.eq.0)then
	  write(*,*) 'Matlab engine open failed'
	endif
!	创建mxArray矩阵
	ptemp=mxCreateDoubleMatrix(1,25,0)
	if(ptemp.eq.0)then
	  write(*,*) 'mxArray create failed'
	endif
!	将Fortran中的数组传入mxArray矩阵
	call mxCopyReal8ToPtr(y,mxGetPr(ptemp),25)
!	将变量传入Matlab引擎中
	status=engPutVariable(ep,'y',ptemp)
	if(status.ne.0)then
	  write(*,*) 'engPutVariable failed'
	endif
!	释放动态内存
	call mxDestroyArray(ptemp)
!	执行Matlab语句
	call engEvalString(ep,'plot(y);')
******第一部分结束**************************************************************
!	选择进行第二部分或终止程序
	write(*,*) 'Type 0 to <Exit>'
	write(*,*) 'Type 1 to <continue>'
	read(*,*) t
	if(t.eq.0)then
	  write(*,*) 'Exit'
	  goto 100
	endif
******第二部分：在Matlab中计算角度，结果返回Fortran******************************
!	在Matlab中计算角度
	call engEvalString(ep,'agl=57.2957795*asin(y);')
!	从Matlab引擎中获取变量
	ptemp=engGetVariable(ep,'agl')
!	将结果返回给Fortran数组
	call mxCopyPtrToReal8(mxGetPr(ptemp),agl,25)
!	输出结果
	do i=1,25
	  write(*,*) agl(i)
	enddo
******第二部分结束***************************************************************
!	关闭Matlab引擎
100	status=engClose(ep)
	if(status.ne.0)then
	  write(*,*) 'Matlab engine close failed'
	endif
	end program