program main
    implicit none
    real, allocatable, target :: work(:)
    real, pointer :: a(:)
    real, allocatable, target :: work_2d(:, :, :)
    real, pointer :: dudt(:, :), dudt_old(:, :)
    integer :: nx, ny, i

    allocate(work(-1:10))

    print *, lbound(work)
    print *, ubound(work)

    a => work
    print *, lbound(a)
    print *, ubound(a)

    deallocate(work)

    nx = 16; ny = 16
    allocate(work_2d(0:nx + 1, 0:ny + 1, 5))
    do i = 1, 5
        work_2d(:, :, i) = real(i)
    end do

    ! to lower bound must be given if the target shape is not standard, i.e., start from 1
    dudt(0:, 0:) => work_2d(:, :, 1)
    print *, 'shape of dudt'
    print *, lbound(dudt)
    print *, ubound(dudt)
    print *, 'shape of dudt_old'
    dudt_old(0:, 0:) => work_2d(:, :, 2)
    print *, lbound(dudt_old)
    print *, ubound(dudt_old)

    print *, 'Before swap'
    print *, 'Sum of dudt ', sum(dudt), ' (ref ', sum(work_2d(:, :, 1)), ')'
    print *, 'Sum of dudt ', sum(dudt_old), ' (ref ', sum(work_2d(:, :, 2)), ')'

    call swap(dudt, dudt_old)

    print *, 'After swap'
    print *, 'Sum of dudt ', sum(dudt), ' (ref ', sum(work_2d(:, :, 2)), ')'
    print *, 'Sum of dudt ', sum(dudt_old), ' (ref ', sum(work_2d(:, :, 1)), ')'

    deallocate(work_2d)

contains
    subroutine swap(ptr_a, ptr_b)
        ! this will keep the shape of ptr_a and ptr_b
        real, pointer, intent(inout) :: ptr_a(:, :), ptr_b(:, :)
        real, pointer :: tmp(:, :)

        print *, 'In subroutine swap'
        print *, 'shape of ptr a'
        print *, lbound(ptr_a)
        print *, ubound(ptr_a)

        print *, 'shape of ptr b'
        print *, lbound(ptr_b)
        print *, ubound(ptr_b)

        tmp => ptr_a
        ptr_a => ptr_b
        ptr_b => tmp

    end subroutine swap

end program main
