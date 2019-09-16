/******************************************************************************
* file: minmax_cs18m532.s                                                     *
* Assembly code for min and max values in a non-zero unsigned number set      *
******************************************************************************/

@ BSS section
.bss


@ DATA SECTION
.data
in_val: .word 10, 4, 28, 100, 8, 0	@ 0 is used to terminate the data
max_val: .word
min_val: .word
set_cnt: .word

@ TEXT section
.text

.global _main

_main:
    LDR   r0, =in_val       @ load address of in_val in r1
	MOV	  r1, #0			@ Register r1 to represent the count of the numbers
	LDR	  r2, [r0]			@ Initialise r2(Max) with the first value of the set
	LDR   r3, [r0]			@ Initialise r3(Min) with the first value of the set

read_loop:
	LDR	  r4, [r0], #4		@ Load the next content on to r4
	ADD	  r1, r1, #1		@ Increment the set count
	CMP	  r4, #0			@ Compare for 0, for end of list
	BEQ	  out				@ branch to out
	
	CMP	  r4, r2			@ Compare r4 with r2(Max)
	MOVGE r2, r4			@ Move r4 to r2 if its greater or same than r2
	BGE	  read_loop			@ Jump to read next entry on the set
	
	CMP   r4, r3			@ Compare r4 with r3(Min)
	MOVLE r3, r4			@ Move r4 to r3 if its lesser or same than r3
	
	B	  read_loop			@ Jump to read next entry on the set

out:	
	LDR   r8, =max_val		@ Get address of max_val
	STR	  r2, [r8]          @ Store result r2 (Max)
	LDR	  r8, =min_val		@ Get address of min_val
	STR	  r3, [r8]			@ Store result of r3 (Min)
	LDR   r8, =set_cnt		@ Get address of set_cnt
	STR   r1, [r8]			@ Store result r1 (Count)
	SWI   0x11
	