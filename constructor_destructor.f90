module m_grid
    implicit none
    private
    public :: t_grid
    type :: t_grid
        integer :: nx
        integer :: ny
        real, allocatable :: x(:), y(:)
    contains
        procedure :: t_grid_contructor_fromsize
        procedure :: t_grid_contructor_fromfile
        generic :: initialize => t_grid_contructor_fromsize, t_grid_contructor_fromfile
        procedure :: finalize => t_grid_deconstructor
    end type t_grid

contains

    subroutine t_grid_contructor_fromsize(this, nx, ny)
        class(t_grid) :: this
        integer :: nx, ny

        this%nx = nx; this%ny = ny
        allocate(this%x(0:nx + 1), this%y(0:ny + 1))

    end subroutine t_grid_contructor_fromsize

    subroutine t_grid_contructor_fromfile(this, filename)
        class(t_grid) :: this
        character(len=*), intent(in) :: filename

        integer :: iunit
        open(newunit=iunit, file=filename)
        read(iunit, *) this%nx
        read(iunit, *) this%ny
        close(iunit)

        allocate(this%x(0:this%nx + 1), this%y(0:this%ny + 1))

    end subroutine t_grid_contructor_fromfile

    subroutine t_grid_deconstructor(this)
        class(t_grid) :: this

        print*, 't_grid_deconstructor'
        if (allocated(this%x)) deallocate(this%x)
        if (allocated(this%y)) deallocate(this%y)

    end subroutine t_grid_deconstructor

end module m_grid

program main
    use m_grid, only: t_grid
    implicit none
    integer :: nx, ny
    type(t_grid) :: grid

    nx = 16; ny = 16
    call grid%initialize(nx, ny)
    call grid%finalize()

    ! call grid%initialize('test.nml')
    ! call grid%finalize()

end program main
