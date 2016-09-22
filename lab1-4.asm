org 00h
	jmp start

org 100h

start:	mov 	r0, #0bh ; memory offset
	mov 	r1, #0h  ; average sum
	mov	r2, #0h  ; remainder sum

avrl:	movx	a, @r0

	; Diving each element of sum as it's easier then diving big numbers
	mov	b, #0ah
	div	ab

	add	a, r1
	mov	r1, a

	; Accumulutaing remainders in r2
	mov	a, r2
	add	a, b
	mov 	r2, a

	dec	r0
	cjne	r0, #01h, avrl

	; Correcting our sum with final remainder
	mov	a, r2
	mov	b, #0ah
	div	ab
	add	a, r1
	mov	r1, a

	; R2 - will be used for output
	mov 	r2, #0fch

	; Checking if average is >= than Qmax
	mov	r0, #0h
	movx	a, @r0
	subb	a, r1
	jz	qmax
	jnc	tmin

qmax:	mov	a, r2
	orl	a, #0ffh
	jmp	quit

	; Checking if average is > than Qmin
tmin:	mov	r0, #01h
	movx	a, @r0
	subb 	a, r1
	jnc 	quit

	mov	a, r2
	orl	a, #0feh

quit:	mov	p0, a
	jmp	$
end