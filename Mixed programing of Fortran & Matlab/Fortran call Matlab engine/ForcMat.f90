module for_c_mat
integer ep,status
integer,external::engOpen,engClose,engEvalString,engPutVariable,engGetVariable
integer,external::mxCreateDoubleMatrix,mxGetPr
contains

!打开Matlab引擎
  subroutine startmatlab()
  ep=engOpen('matlab')
  write(*,*) '正在打开Matlab引擎，请稍候……'
  if(ep.eq.0)then
    write(*,*) 'Matlab引擎打开失败，程序结束'
	stop
  else
	write(*,*) 'Matlab引擎成功打开'
  endif
  end subroutine

!关闭Matlab引擎
  subroutine closematlab()
  status=engClose(ep)
  write(*,*) '正在关闭Matlab引擎，请稍候……'
  if(status.ne.0)then
	write(*,*) 'Matlab引擎关闭失败，程序结束'
	stop
  else
	write(*,*) 'Matlab引擎成功关闭'
  endif
  end subroutine

!在Matlab中执行命令	  
  subroutine executec(command)
  character*(*) command
  status=engEvalString(ep,command)
  write(*,*) '正在Matlab中执行语句',command
  if(status.ne.0)then
	write(*,*) command,'执行失败'
	stop
  endif
  end subroutine

!将Fortran中的矩阵送到Matlan中
  subroutine fdata2m(fdata,name,row,col)
  character*(*) name
  integer ptemp,row,col
  real(8) fdata(row,col)
  ptemp=mxCreateDoubleMatrix(row,col,0)
  if(ptemp.eq.0)then
	write(*,*) '不能创建mxArray矩阵'
	stop
  endif
  call mxCopyReal8ToPtr(fdata,mxGetPr(ptemp),row*col)
  status=engPutVariable(ep,name,ptemp)
  write(*,*) '正在将Fortran数组传入Matlab矩阵',name
  call mxDestroyArray(ptemp)
  if(status.ne.0)then
	write(*,*) 'engPutVariable failed'
	stop
  endif
  end subroutine

 !将Matlab中的矩阵输入到Fortran中
  subroutine mdata2f(name,mdata,row,col)
  integer ptemp,row,col
  character*(*) name
  real(8) mdata(row,col)
  ptemp=engGetVariable(ep,name)
  write(*,*) name,'传回Fortran数组中……'
  if(ptemp.eq.0)then
	write(*,*) 'engGetVariable failed'
  endif
  call mxCopyPtrToReal8(mxGetPr(ptemp),mdata,row*col)
  end subroutine
	
end module