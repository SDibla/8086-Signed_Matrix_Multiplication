# 8086-Signed-Matrix-Multiplication
Program in 8086 assembly for multiplying two matrices whose elements are signed numbers expressed with one byte. 
The possibility of overflow is also considered.

First matrix has N rows and M columns while second matrix has M rows and P columns.
The result is a matrix with N rows and P columns. The matrix contains sign numbers expressed with one word.

The analysis of Overflow is made in this way:

If the result after the overflow is positive, it must be replaced with the minimum negative number representable in one word (-32768) and if the result after the overflow is negative, it must be replaced with the maximum positive number representable in one word (32767).

The example in the code is:

A = (4 -3 5 1; 3 -5 0 11; -5 12 4 5) and B = (-2 3; 5 -1; 4 3; 9 -7)

where the result is C = (6 23; 68 -63; 41 20) 
