program main
    implicit none
    integer, parameter :: MAXSTRLEN = 512
    integer :: iunit, ierror
    character(len=MAXSTRLEN) :: str, filename

    str = 'grid   '
    if (str == 'grid') then
        print '(A)', 'The string equality does not consider trailing blank characters'
    end if

    str = 'test '//' grid'

    filename = 'test.nml '
    ! file may be case sensitive or not (OS dependent)
    ! iostat = 0 (success), > 0 (fail)
    open(newunit=iunit, file=filename, iostat=ierror)
    if (ierror == 0) then
        print '(A)', 'The file specifier in open statement does not consider trailing blank characters'
    else
        close(iunit)
        stop 'The file specifier in open statement does consider trailing blank characters'
    end if
    close(iunit)

    ! the memory and actual string length
    ! no trailing blank characters are considered in the assignment
    str = 'grid     '
    print '(A, i5)', 'The memory string length is ', len(str)
    print '(A, i5)', 'The actual string length is ', len_trim(str)

end program main