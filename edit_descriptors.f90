program format_strings
    ! exponential formal: small numbers (< 0.01) or very large numbers (> 1000)  e.g., e10.3
    ! floating-point format otherwise 
    ! e.g., f10.3 (character + width(number of characters) + point + fractional part)
    ! i and f are edit descriptors 

    ! character variables

    ! g type variable: we can use this for any type of variable

    use iso_fortran_env, only: stdout => output_unit
    implicit none
    real :: lat = 59.329444, lon = 18.068611, alt = 11678.3
    integer :: eng(4) = [96, 6, 10, 94]
    logical :: airbone = .true.

    character(len = :), allocatable :: dashfmt  ! character variable

    dashfmt = '(2(f9.5, 2x), f7.1, 2x, 4(i3.3, 2x), l)'
    write(stdout, dashfmt) lat, lon, alt, eng, airbone

end program format_strings