	.file	"main.cpp"
	.intel_syntax noprefix
	.text
	.section	.text$_Z6printfPKcz,"x"
	.linkonce discard
	.globl	__Z6printfPKcz
	.def	__Z6printfPKcz;	.scl	2;	.type	32;	.endef
__Z6printfPKcz:
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 36
	lea	eax, [ebp+12]
	mov	DWORD PTR [ebp-16], eax
	mov	ebx, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp], 1
	mov	eax, DWORD PTR __imp____acrt_iob_func
	call	eax
	mov	DWORD PTR [esp+8], ebx
	mov	edx, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	___mingw_vfprintf
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp-12]
	mov	ebx, DWORD PTR [ebp-4]
	leave
	ret
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "main\12\0"
LC1:
	.ascii "Hello printf!\12\0"
LC2:
	.ascii "C%car f%c%cmat symbol\12\0"
LC3:
	.ascii "string!\0"
LC4:
	.ascii "format \0"
LC5:
	.ascii "super\0"
LC6:
	.ascii "Char %s %s%s\12\0"
LC7:
	.ascii "love\0"
	.align 4
LC8:
	.ascii "This is %d%% test. Hex = %%%x, oct = %o, bin = %b\12%c %s %x %b%%%c%b\12\0"
LC9:
	.ascii "%c %s %x %b%%%c %b\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	sub	esp, 48
	call	___main
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	__Z6printfPKcz
	mov	DWORD PTR [esp], OFFSET FLAT:LC1
	call	_PrintF
	mov	DWORD PTR [esp+12], 114
	mov	DWORD PTR [esp+8], 111
	mov	DWORD PTR [esp+4], 104
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_PrintF
	mov	DWORD PTR [esp+12], OFFSET FLAT:LC3
	mov	DWORD PTR [esp+8], OFFSET FLAT:LC4
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC5
	mov	DWORD PTR [esp], OFFSET FLAT:LC6
	call	_PrintF
	mov	DWORD PTR [esp+40], 15
	mov	DWORD PTR [esp+36], 33
	mov	DWORD PTR [esp+32], 4
	mov	DWORD PTR [esp+28], 3802
	mov	DWORD PTR [esp+24], OFFSET FLAT:LC7
	mov	DWORD PTR [esp+20], 73
	mov	DWORD PTR [esp+16], 19635
	mov	DWORD PTR [esp+12], 7336
	mov	DWORD PTR [esp+8], -1
	mov	DWORD PTR [esp+4], -1
	mov	DWORD PTR [esp], OFFSET FLAT:LC8
	call	_PrintF
	mov	DWORD PTR [esp+24], 127
	mov	DWORD PTR [esp+20], 33
	mov	DWORD PTR [esp+16], 4
	mov	DWORD PTR [esp+12], 3802
	mov	DWORD PTR [esp+8], OFFSET FLAT:LC7
	mov	DWORD PTR [esp+4], 73
	mov	DWORD PTR [esp], OFFSET FLAT:LC9
	call	_PrintF
	mov	DWORD PTR [esp], 0
	mov	eax, DWORD PTR __imp____acrt_iob_func
	call	eax
	mov	DWORD PTR [esp], eax
	call	_getc
	mov	eax, 0
	leave
	ret
	.ident	"GCC: (GNU) 11.1.0"
	.def	___mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	_PrintF;	.scl	2;	.type	32;	.endef
	.def	_getc;	.scl	2;	.type	32;	.endef
