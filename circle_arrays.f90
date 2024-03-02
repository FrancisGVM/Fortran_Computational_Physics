program circle_areas
    implicit none
    integer, parameter :: N = 10
    integer :: i
    real :: area, perimeter
    real, dimension(N) :: R
    real, parameter :: PI = 3.141593

    do i= 1, N
        print *, 'Enter radius circle: '
        read *, R(i)
        print *, 'i = ', i, 'R(i)', R(i)
    enddo

    open(UNIT=13,FILE='area.dat')

    do i=1,N
        perimeter = 2*PI*R(i)
        area = PI*R(i)**2
        write(13,*) i,') R= ', R(i),'area = ',area,&
        'perimeter = ', perimeter
    enddo
    
    close(13)

end program circle_areas