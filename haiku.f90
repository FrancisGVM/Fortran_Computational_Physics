program haiku
    use iso_fortran_env, only: stdin => input_unit, &
                               stdout => output_unit
    implicit none
    integer :: fileunit
    character(len = 9999) :: filename, text
    character(len = 9) :: pos
    logical :: file_exists

    if (command_argument_count() < 1) stop 'Usage: qn <filename>'
    call get_command_argument(1, filename)  ! subroutine, maybe?

    inquire(file = trim(filename), exist = file_exists)
    pos = 'rewind'  ! assumes writing from scratch

    if (file_exists) then
        write(stdout, '(a)') 'File ' // trim(filename) // ' already exists!'

        do
          write(*, '(a)', advance = 'no') '[O]verwrite,  [A]ppend,  [Q]uit: '
          read(stdin, '(a)') text
          if (any(trim(text) == ['O', 'o'])) then
            write(stdout, '(a)') 'Overwriting ' // trim(filename)
            exit
          else if (any(trim(text) == ['A', 'a'])) then
            pos = 'append'
            write(stdout, '(a)') 'Appending to ' // trim(filename)
            exit
          else if (any(trim(text) == ['Q', 'q'])) then
            stop
          end if           
        end do
    end if

    open(newunit=fileunit, file=trim(filename), position = pos,action='write')   ! legacy Fortran: open(unit = 2213, file=trim(filename))
    do
        read(stdin, '(a)') text
        write(fileunit, '(a)') trim(text)
        flush(fileunit)
    end do

end program haiku