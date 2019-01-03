subroutine add(x,y,z)
!DEC$ ATTRIBUTES C,DLLEXPORT::add
!DEC$ ATTRIBUTES REFERENCE::z
implicit none
integer::x,y
integer::z 
z=x+y
end subroutine