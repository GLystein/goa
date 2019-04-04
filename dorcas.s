/*
Iyemenvile Joel Itipo
*/

.global main
.func main

main: 
	/*First Input*/ 	
	BL _scanf
	MOV R1,R0 /* this is n can be change to R0 or R1*/
	MOV R8,R1 /* back up R1*/
	MOV R6,R1
	
	/* Sencond Input*/
	BL _scanf
	MOV R2,R0 /* this is m can be change to R0 or R2*/
	MOV R0,#0	
	MOV R9,R2 /*backup R2*/ 

	BL _count_Partitions

	/* Printing */ 
	MOV R1,R4 @can be R0
	MOV R2,R6 /* this send the value n into R2 to be print out*/
	MOV R3,R9 /* send the value R2 into R3 for printing*/
	BL _printf

	
	BL _exit
	@B main

_printf: 
	PUSH {LR}
	LDR R0,=printf_str
	BL printf
	POP {PC}

_count_Partitions: 
	PUSH {LR}
	MOV R1,R8

	/* I wil call that register R5 and MOV R5,#0*/
	/* this return R0=1 n==0 R1=0 */ 
	CMP R1,#0 @ compare input argument to 0
	MOVEQ R0,#1
	ADDEQ R4,R0
	/*@ADD R5,R4*/
	POPEQ {PC}

	/* this return R0=0 when n<0 R1<0 */
	MOVLT R0,#0
	ADDLT R4,R0
	/*@ADD R5,R4*/
	POPLT {PC}

	/* this return 0 when m=0*/
	CMP R2,#0
	MOVEQ R0,#1
	ADDEQ R4,R0
	/*MOV R4,R0
	@ADD R5,R4*/
	POPEQ {PC}
	/* I will need a register to keep all this adding up*/
	/* let try this*/

/*This my trying for the last part*/
	
	
	@PUSH {R1}
	@PUSH {R2}
	SUB R2,R2,#1
	@SUB R8,R2
	BL _count_Partitions
	
	@POP {R1}
	@POP {R8}
	@SUB R2,R2,#1
	SUB R8,R2 /* n-m I used the back up of R1*/
	@PUSH {R0}
	BL _count_Partitions
	@POP {R4}
	@ADD R5,R5
	@MOV R0,R5
	POP {PC}
	
_scanf: 
	PUSH {LR}
	SUB SP,SP, #4
	LDR R0,=format_str
	MOV R1,SP
	BL scanf
	LDR R0,[SP]/* back to R0=R3*/
	ADD SP,SP,#4
	POP {PC}
_exit: 
	MOV R7,#4
	MOV R0,#1
	MOV R2,#21
	LDR R1, =exit_str
	SWI 0
	MOV R7,#1
	SWI 0

.data
format_str:	.asciz	"%d"
printf_str:	.asciz	"There are %d partitions of %d using integers up to %d\n"
exit_str:	.asciz	"Terminating program.\n"


