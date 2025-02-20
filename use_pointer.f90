program main
    implicit none
    integer, parameter :: NVARS = 5
    real, pointer, contiguous :: work(:, :, :)
    real, pointer, contiguous :: dudt(:, :), dudt_old(:, :)
    integer :: nx, ny, ivar

    nx = 16; ny = 16
    allocate(work(0:nx + 1, 0:ny + 1, NVARS))

    do ivar = 1, NVARS
        work(:, :, ivar) = real(ivar)
    end do

    print '(A)', 'lower bound of work'
    print '(2i7)', lbound(work)
    print '(A)', 'upper bound of work'
    print '(2i7)', ubound(work)


    dudt(0:, 0:) => work(:, :, 1)
    print '(A)', 'lower bound of dudt'
    print '(2i7)', lbound(dudt)
    print '(A)', 'upper bound of dudt'
    print '(2i7)', ubound(dudt)

    dudt_old(0:, 0:) => work(:, :, 2)
    print '(A)', 'lower bound of dudt_old'
    print '(2i7)', lbound(dudt_old)
    print '(A)', 'upper bound of dudt_old'
    print '(2i7)', ubound(dudt_old)


    print *, 'Before swap'
    print *, 'Sum of dudt ', sum(dudt), ' (ref ', sum(work(:, :, 1)), ')'
    print *, 'Sum of dudt ', sum(dudt_old), ' (ref ', sum(work(:, :, 2)), ')'

    call swap(dudt, dudt_old)

    print *, 'After swap'
    print *, 'Sum of dudt ', sum(dudt), ' (ref ', sum(work(:, :, 2)), ')'
    print *, 'Sum of dudt ', sum(dudt_old), ' (ref ', sum(work(:, :, 1)), ')'

    deallocate(work)

contains
    subroutine swap(ptr_a, ptr_b)
        real, pointer, contiguous, intent(inout) :: ptr_a(:, :), ptr_b(:, :)
        real, pointer, contiguous :: tmp(:, :)

        tmp => ptr_a
        ptr_a => ptr_b
        ptr_b => tmp

    end subroutine swap
end program main