org 00h
	jmp start

org 100h

start:	mov 	dptr, #array
	mov 	r0, #0bh
	mov 	r1, #0h

; Calculating average of array
avrl1:  mov 	a, r0
	movc 	a, @a+dptr

	add	a, r1
	mov	r1, a

	dec 	r0
	cjne 	r0, #01h, avrl1

	mov	a, r1
	mov	b, #0ah
	div	ab
	mov	r1, a ; R1 contains average of array[2..11]

	clr	p0.0
	clr	p0.1

; Checking if average is >= than Qmax
	mov	a, #0h
	movc	a, @a+dptr
	subb	a, r1
	jz	qmax
	jnc	tmin

qmax:	setb	p0.0
	setb	p0.1;
	jmp	quit

; Checking if average is > than Qmin
tmin:	mov	a, #01h
	movc	a, @a+dptr
	subb	a, r1
	jnc	quit
	setb	p0.1

quit:	jmp $

org 800h
	array: db 6,4,1,2,3,4,5,6,7,8,9,10 ; max, min, data array -> size 10
end