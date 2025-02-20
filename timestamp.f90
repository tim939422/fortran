program main
    use iso_fortran_env, only: rp => real64
    implicit none
    ! <casename>_n0000006_t6.000e-06.res
    character(len=512) :: casename
    character(len=512) :: filename
    character(len=512) :: fmt
    integer :: it_now
    real(rp) :: t_now

    casename = 'casename'
    it_now = 6
    t_now = 6.0e-6_rp


    write(filename, '(A,"_n",I7.7,"_t",ES9.3,".res")') trim(casename), it_now, t_now
    print '(A)', trim(filename)

end program main