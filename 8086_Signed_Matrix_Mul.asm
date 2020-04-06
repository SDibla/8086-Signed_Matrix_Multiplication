.MODEL small
.STACK

.DATA
N EQU 4
M EQU 7
P EQU 5

;------ matrix a ------
m1_r0 DB 3,14,-15,9,26,-53,5
m1_r1 DB 89,79,3,23,84,-6,26
m1_r2 DB 43,-3,83,27,-9,50,28
m1_r3 DB -88,41,97,-103,69,39,-9
;----------------------

;------ matrix b ------
m2_c0 DB 37,9,-23,0,9,82,70
m2_c1 DB -101,74,90,-62,86,5,-67
m2_c2 DB 0,94,-78,86,28,34,9
m2_c3 DB 58,-4,16,20,0,-21,82
m2_c4 DB -20,59,-4,89,-34,1,14
;----------------------

;--- result matrix ---
rm_r0 DW P DUP (?)
rm_r1 DW P DUP (?)
rm_r2 DW P DUP (?)
rm_r3 DW P DUP (?)
;---------------------

.CODE
.STARTUP

MOV SI,0 ;index for the rows of A matrix
MOV DI,0 ;index for the columns of B matrix
MOV BX,0 ;index of the result matrix

MOV CX,N*P ;number of total multiplications that has to be performed

matrixLoop:

MOV BX,N*P ;handler of the position in the result matrix 
SUB BX,CX ;(# of multiplication - actual multiplication)*2 (word dimension)
SHL BX,1 ;multiplication by 2                                             

PUSH CX
MOV CX,M

    mulLoop:
    
    MOV AH,0
    MOV AL,m1_r0[SI]
    
    MOV DL,m2_c0[DI]
    IMUL DL
    ADD rm_r0[BX],AX ;signed mul and addition
    
    JO ovfl ;check overflow
    JMP nextMul
        ovfl:
        SHL rm_r0[BX],1 ;check sign of the result
        JC positive
            MOV rm_r0[BX],-32768
            JMP nextMul
            
            positive: MOV rm_r0[BX],32767
         
    nextMul:
    INC SI
    INC DI 
    
    LOOP mulLoop

CMP DI,M*P ;checks if DI is at the end of the B matrix
JE rst
    SUB SI,M
    JMP next    
    
    rst: MOV DI,0
    
next:    
POP CX

LOOP matrixLoop

.EXIT
END