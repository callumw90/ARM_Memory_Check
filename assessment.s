@Callum Wilson - ARM Assembley Assessment

.data

.balign 4
a: .skip 0x00100000   @skip bytes for array

.balign 4
var1: .word 0x00000000  @value of 0


.text

.balign 4
.global main

main:

	LDR r1, =0x00000000  @start counter
	LDR r2, addr_of_a  @loads address of array
	LDR r3, addr_of_var1  @loads address of value 0
	LDR r8, =0x00040000  @loop for 1/4 of MB
	LDR r3, [r3] @loads value in r3 - 0
	SUB r4, r3, #1  @sub 1 from hex 0

loopLoad1:

	CMP r1, r8  @compare r8 to r1
	BEQ done1  @if equal move to done1
	ADD r9, r2, r1, LSL #2  @move to next section of memory
	STR r4, [r9]  @store value in r4 to memory location r9
	ADD r1, r1, #1  @increment counter
	B loopLoad1  @loops

done1:

	LDR r1, =0x00000000  @reset counter

loopRead1:

	CMP r1, r8  @compares r8 to r1
	BEQ done2  @if equal move to done2
	ADD r9, r2, r1, LSL #2  @move to next section of memory
	LDR r6, [r9]  @load value in r9(1) to r6
	CMP r6, r4  @compare values
	BNE error  @if not equal move to error
	ADD r1, r1, #1  @increment counter
	B loopRead1 @loop

done2:

	LDR r1, =0x00000000 @reset counter


loopLoad2:

	CMP r1, r8  @compare r1 to r8
	BEQ done3  @if equal move to done3
	ADD r9, r2, r1, LSL #2  @move to next section of memory
	STR r3, [r9]  @store value of r3 in r9
	ADD r1, r1, #1  @increment
	B loopLoad2  @loop

done3:

	LDR r1, =0x000000000


loopRead2:

	CMP r1, r8  @compare r1 to r8
	BEQ end  @if equal move to end
	ADD r9, r2, r1, LSL #2  @move to next section of memory
	LDR r6, [r9]  @load to r6 value in r9
	CMP r6, r3 @compare
	BNE error  @if not equal move to error
	ADD r1, r1, #1  @increment
	B loopRead2  @loop

error:
	MOV r0, #1 @if error return 1
	bx lr @exit

end:
	MOV r0, #0 @if good return 0
	bx lr @exit


addr_of_a: .word a
addr_of_var1: .word var1
