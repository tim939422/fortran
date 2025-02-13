This is a collection of demo programs in modern Fortran. Each demo is standalone
and will demonstrate a small feature of this powerful language.

## Use Valgrind to detect memory errors
We can use valgrind to deteck memory leaks. As the first step, you must compile
your executable with debug flag. Then, you can use Valgrind as
```console
valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --log-file=<filename> <regular command to run you executable>
```
