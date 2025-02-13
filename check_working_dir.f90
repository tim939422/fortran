program main
    implicit none
    character(len=256) :: pwd
    ! this is portable in Linux only
    call get_environment_variable('PWD', pwd)
    print '(A)', 'The working directory is: '//trim(pwd)
end program main
