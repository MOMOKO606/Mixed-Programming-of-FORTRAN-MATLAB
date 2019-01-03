*******************************************************************************
*  Fortran����Matlab����ʾ������
*  ������˵����
*  ��һ���֣���Fortran�м���y=sin(x)���ٵ���Matlab���滭��sin����ͼ��
*  �ڶ����֣���Matlab�����м���ÿ��yֵ��Ӧ�ĽǶ�agl���������Fortran�������
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
!	����y=sin(x)
	x=-pi/12.0
	do i=1,25
	  x=x+pi/12.0
	  y(i)=sin(x)
	enddo
******��һ���֣�����Matlab���滭��������ͼ************************************
!	��Matlab����	
	ep=engOpen('matlab')
	if(ep.eq.0)then
	  write(*,*) 'Matlab engine open failed'
	endif
!	����mxArray����
	ptemp=mxCreateDoubleMatrix(1,25,0)
	if(ptemp.eq.0)then
	  write(*,*) 'mxArray create failed'
	endif
!	��Fortran�е����鴫��mxArray����
	call mxCopyReal8ToPtr(y,mxGetPr(ptemp),25)
!	����������Matlab������
	status=engPutVariable(ep,'y',ptemp)
	if(status.ne.0)then
	  write(*,*) 'engPutVariable failed'
	endif
!	�ͷŶ�̬�ڴ�
	call mxDestroyArray(ptemp)
!	ִ��Matlab���
	call engEvalString(ep,'plot(y);')
******��һ���ֽ���**************************************************************
!	ѡ����еڶ����ֻ���ֹ����
	write(*,*) 'Type 0 to <Exit>'
	write(*,*) 'Type 1 to <continue>'
	read(*,*) t
	if(t.eq.0)then
	  write(*,*) 'Exit'
	  goto 100
	endif
******�ڶ����֣���Matlab�м���Ƕȣ��������Fortran******************************
!	��Matlab�м���Ƕ�
	call engEvalString(ep,'agl=57.2957795*asin(y);')
!	��Matlab�����л�ȡ����
	ptemp=engGetVariable(ep,'agl')
!	��������ظ�Fortran����
	call mxCopyPtrToReal8(mxGetPr(ptemp),agl,25)
!	������
	do i=1,25
	  write(*,*) agl(i)
	enddo
******�ڶ����ֽ���***************************************************************
!	�ر�Matlab����
100	status=engClose(ep)
	if(status.ne.0)then
	  write(*,*) 'Matlab engine close failed'
	endif
	end program