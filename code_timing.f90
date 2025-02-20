module posix
    use, intrinsic :: iso_c_binding
    implicit none
    private

    public :: c_usleep

    interface
        ! int usleep(useconds_t useconds)
        function c_usleep(useconds) bind(c, name='usleep')
            import :: c_int, c_int32_t
            implicit none
            integer(kind=c_int32_t), value :: useconds
            integer(kind=c_int)            :: c_usleep
        end function c_usleep
    end interface
end module posix

program main
    use posix, only: c_usleep
    implicit none

    integer :: i, rc, t
    integer :: start, finish, clock_rate
    real :: elapsed_time

    t = 500 * 1000 ! 500 milliseconds

    call system_clock(count_rate=clock_rate)

    do i = 1, 10
        print '("zzz ...")'
        call system_clock(start)
        rc = c_usleep(t)
        call system_clock(finish)
        elapsed_time = real(finish - start)/real(clock_rate)
        print '(A, F8.6, A)', 'Elapsed: ', elapsed_time, ' seconds'
    end do

    ! gfortran ~ 25 days for default integeer

end program main
