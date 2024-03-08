program matrix_print
    use iso_fortran_env, only: stdout => output_unit
    implicit none

    integer :: i, j
    integer, parameter :: n = 2
    real, dimension(n,n) :: A

    A(1,1) = 1212.32
    A(2,1) = 232.3
    A(1,2) = 123.
    A(2,2) = -4.

    do i = 1, n
        write(stdout, '(a)') ' ---------------------------'
        write(stdout, '(a)', advance='no') ' | '
        write(stdout, '(2(f10.3, a))') ( A(i,j), ' | ', j=1, n)
    end do
    write(stdout, '(a)') ' ---------------------------'
end program matrix_print
