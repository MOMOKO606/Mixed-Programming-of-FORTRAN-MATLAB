module for_c_mat
integer ep,status
integer,external::engOpen,engClose,engEvalString,engPutVariable,engGetVariable
integer,external::mxCreateDoubleMatrix,mxGetPr
contains

!��Matlab����
  subroutine startmatlab()
  ep=engOpen('matlab')
  write(*,*) '���ڴ�Matlab���棬���Ժ򡭡�'
  if(ep.eq.0)then
    write(*,*) 'Matlab�����ʧ�ܣ��������'
	stop
  else
	write(*,*) 'Matlab����ɹ���'
  endif
  end subroutine

!�ر�Matlab����
  subroutine closematlab()
  status=engClose(ep)
  write(*,*) '���ڹر�Matlab���棬���Ժ򡭡�'
  if(status.ne.0)then
	write(*,*) 'Matlab����ر�ʧ�ܣ��������'
	stop
  else
	write(*,*) 'Matlab����ɹ��ر�'
  endif
  end subroutine

!��Matlab��ִ������	  
  subroutine executec(command)
  character*(*) command
  status=engEvalString(ep,command)
  write(*,*) '����Matlab��ִ�����',command
  if(status.ne.0)then
	write(*,*) command,'ִ��ʧ��'
	stop
  endif
  end subroutine

!��Fortran�еľ����͵�Matlan��
  subroutine fdata2m(fdata,name,row,col)
  character*(*) name
  integer ptemp,row,col
  real(8) fdata(row,col)
  ptemp=mxCreateDoubleMatrix(row,col,0)
  if(ptemp.eq.0)then
	write(*,*) '���ܴ���mxArray����'
	stop
  endif
  call mxCopyReal8ToPtr(fdata,mxGetPr(ptemp),row*col)
  status=engPutVariable(ep,name,ptemp)
  write(*,*) '���ڽ�Fortran���鴫��Matlab����',name
  call mxDestroyArray(ptemp)
  if(status.ne.0)then
	write(*,*) 'engPutVariable failed'
	stop
  endif
  end subroutine

 !��Matlab�еľ������뵽Fortran��
  subroutine mdata2f(name,mdata,row,col)
  integer ptemp,row,col
  character*(*) name
  real(8) mdata(row,col)
  ptemp=engGetVariable(ep,name)
  write(*,*) name,'����Fortran�����С���'
  if(ptemp.eq.0)then
	write(*,*) 'engGetVariable failed'
  endif
  call mxCopyPtrToReal8(mxGetPr(ptemp),mdata,row*col)
  end subroutine
	
end module