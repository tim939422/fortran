module m_utils

contains
    ! the shape of phi will be passed
    subroutine write_visu2d(filename, phi)
        character(len=*), intent(in) :: filename
        real, intent(in) :: phi(:, :)

        ! local
        integer :: ni, nj

        ! work
        print '(A)', 'Writing to file '//trim(filename)
        ni = size(phi, 1); nj = size(phi, 2)

        print *, ni, nj

    end subroutine write_visu2d

end module m_utils

program main
    use m_utils, only: write_visu2d
    implicit none
    integer, parameter :: nx = 16, ny = 32
    real, dimension(0:nx + 1, 0:ny + 1) :: u ! one ghost cell layer
    real, dimension(-1:nx + 2, -1:ny + 2) :: c ! two ghost cell layers
    integer :: i, j

    do j = 0, ny + 1
        do i = 0, nx + 1
            u(i, j) = real(i + j)
        end do
    end do

    call write_visu2d('u.bin', u(0:nx, 0:ny))

    do j = -1, ny + 2
        do i = -1, nx + 2
            c(i, j) = real(i + j)
        end do
    end do

end program main