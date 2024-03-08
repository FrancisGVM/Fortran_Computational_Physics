program tsunami
    use iso_fortran_env, only: stdout => output_unit
    implicit none

    integer :: i, n

    integer, parameter :: grid_size = 100, num_time_steps = 100
    real, parameter :: dt = 1., dx = 1., c = 1.  ! time step [s]; dx  grid spacing [m], c phase speed [m/s]
    real, dimension(grid_size) :: h, dh ! water height values, finite diffference
    integer, parameter :: icenter = 25
    real, parameter :: decay = 0.02

    if (grid_size <= 0) stop 'grid size must be > 0 '
    if (dt <= 0) stop 'time step must be > 0'
    if (dx <= 0) stop 'grid spacing must be > 0'
    if (c <= 0) stop 'background flow speed c must be > 0'

    ! do concurrent construct 
    initial_condition: do concurrent(i=1:grid_size)
        h(i) = exp(-decay * (i - icenter)**2)
    end do initial_condition

    write(stdout, '(i3, 2x, 100(e14.8, 2x))') 0, h

    time_loop: do n = 1, num_time_steps
        dh(1) = h(1) - h(grid_size)  ! periodic boundary conditions
        
        FD_loop: do concurrent (i = 2: grid_size)
            dh(i) = h(i) - h(i-1)
        end do FD_loop

        space_loop: do concurrent (i=1:grid_size)
            h(i) = h(i) - c * dh(i) / dx * dt
        end do space_loop

        write(stdout, '(i3, 2x, 100(e14.8, 2x))') n, h

    end do time_loop

end program tsunami
