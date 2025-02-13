module m_tokenize
    integer, parameter :: MAXSTRLEN = 500

    contains
    !> @brief reads the next valid word from a file, skipping comments
    !> @details a valid word is a token not after a comment indicator !
    !>          if EOF, the str will be empty and return an error code
    subroutine read_next(iunit, str, ierror)
        ! interface
        !> file unit number
        integer, intent(in) :: iunit
        !> Next valid word read from the file (empty if none)
        character(len=*), intent(out) :: str
        !> error code: 0 (success), otherwise /= 0
        integer, intent(out) :: ierror


        ! Local variables
        character(len=MAXSTRLEN), save :: buffer = ''  ! line buffer
        integer, save :: pos = 1  ! position in the buffer
        integer :: ios  ! I/O status

        ! work
        do
            ! Read a new line if all words are processed
            if (pos > len_trim(buffer)) then
                read(iunit, '(A)', iostat=ios) buffer
                if (is_iostat_end(ios)) then
                    str = ''
                    ierror = ios
                    return
                end if
                buffer = adjustl(buffer)
                pos = 1
            end if

            ! Skip lines that start with '!'
            if (len_trim(buffer) > 0 .and. buffer(1:1) == '!') then
                pos = len_trim(buffer) + 1
                cycle
            end if

            ! Extract next word
            read(buffer(pos:), *, iostat=ios) str
            if (ios == 0) then
                if (str(1:1) == '!') then
                    pos = len_trim(buffer) + 1
                    cycle
                else
                    ! this will make the pos at one character after the str
                    pos = pos + index(buffer(pos:), trim(str)) + len_trim(str)
                    ierror = 0
                    return
                end if
            else
                pos = len_trim(buffer) + 1
            end if

        end do

    end subroutine read_next

end module m_tokenize

program main
    use m_tokenize, only: MAXSTRLEN, read_next
    implicit none
    integer :: ierror, iunit, ntokens
    character(len=MAXSTRLEN) :: str

    open(newunit=iunit, file='taylorGreen.input')
    ierror = 0
    ntokens = 0
    do while (ierror == 0)
        call read_next(iunit, str, ierror)
        if (ierror == 0) then
            ntokens = ntokens + 1
            print '(A, i4, x, A)', 'Token ', ntokens, trim(str)
        end if
    end do
    print '(i4, A)', ntokens, ' tokens in total'

    close(iunit)

end program main
