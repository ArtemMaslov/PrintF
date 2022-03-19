global Start

extern ExitProcess   ; kernel32.dll

extern _PrintF		 ; PrintF.obj

extern _ItoaDec		 ; PrintF.obj

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------

section .text

Start:
		call ItoaDecUnitTests
		
		; exit (0);
        xor eax, eax
		push eax
        call ExitProcess

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------

section .data

STK_SIZE		equ 4 ; Размер 1 элемента стека в байтах

PrintFStr1		db "Hello printf!", 0Ah, 00h

PrintFStr2		db "C%car f%c%cmat symbol", 0Ah, 00h

PrintFStr3		db "Char %s %s%s", 0Ah, 00h

PrintFStr4		db "This is %d%% test. Hex = %%%x, oct = %o, bin = %b", 0Ah, 00h

PrintFStr5		db "%c %s %x %b%%%c %b", 0Ah, 00h

PrintFArgs2		db 'hor'

PrintFArgs3		db "super", 00h
				db "format", 00h
				db " string!", 00h

PrintFArgs4		dq -1
				dq -1
				dq 1CA8h ; 16 250
				dq 4CB3h ; 100 1100 1011 0011

PrintFArgs5		dd 'I'
				db "love", 00h
				dd 3802
				dd 4
				dd '!'
				dd 127

DecNumsLength	equ 7

DecNums			dd 1234567890
				dd 24681357
				dd -1
				dd 0
				dd 123
				dd 10000
				dd 10010

ItoaArray 		db 67 dup(0), 00h

NewLine			db 0Ah, 00h

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
; PrintF tests area
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------

section .text

;-------------------------------------------------------------------------
; Test ItoaDec Function
;-------------------------------------------------------------------------
ItoaDecUnitTests:
		
		mov esi, 0
		
.loop:
		mov edi, ItoaArray
		
		mov eax, dword [DecNums + esi]
		call _ItoaDec
		
		push esi
		push edi
		call _PrintF
		
		push NewLine
		call _PrintF
		
		add esp, STK_SIZE * 2
		pop esi
		
		; step		
		add esi, 4

		cmp esi, DecNumsLength * 4
		jb .loop
						
		ret

;--------------------------------------------------------------------
; Test printf function
;
; Entry: null
;
; Destr: eax, ebx, ecx, edx, esi, edi
;--------------------------------------------------------------------
PrintFTestPlainText:
		
		push PrintFStr1
		
		call _PrintF
		
		add esp, STK_SIZE
		
		ret

;--------------------------------------------------------------------
; Test printf function
;
; Entry: null
;
; Destr: eax, ebx, ecx, edx, esi, edi
;--------------------------------------------------------------------
PrintFTestChar:
		
		mov ebx, 3
		mov ecx, 0
.loop:
		mov cl, byte [PrintFArgs2 + ebx - 1]
		push ecx
		
		dec ebx
		cmp ebx, 0
		ja .loop
		
		push PrintFStr2
		
		call _PrintF
		
		add esp, STK_SIZE * 4
		
		ret

;--------------------------------------------------------------------
; Test printf function
;
; Entry: null
;
; Destr: eax, ebx, ecx, edx, esi, edi
;--------------------------------------------------------------------
PrintFTestString:
		
		push PrintFArgs3 + STK_SIZE * 2
		push PrintFArgs3 + STK_SIZE
		push PrintFArgs3
		push PrintFStr3
		
		call _PrintF
		
		add esp, STK_SIZE * 4
		
		ret

;--------------------------------------------------------------------
; Test printf function
;
; Entry: null
;
; Destr: eax, ebx, ecx, edx, esi, edi
;--------------------------------------------------------------------
PrintFTestItoa:
		
		push dword [PrintFArgs4 + STK_SIZE * 3]
		push dword [PrintFArgs4 + STK_SIZE * 2]
		push dword [PrintFArgs4 + STK_SIZE]
		push dword [PrintFArgs4]
		push PrintFStr4
		
		call _PrintF
		
		add esp, STK_SIZE * 5
		
		ret
		
PrintFTest:
		
		push dword [PrintFArgs5 + STK_SIZE * 5]
		push dword [PrintFArgs5 + STK_SIZE * 4]
		push dword [PrintFArgs5 + STK_SIZE * 3]
		push dword [PrintFArgs5 + STK_SIZE * 2]
		push PrintFArgs5 + STK_SIZE
		push dword [PrintFArgs5]
		push PrintFStr5
		
		call _PrintF
		
		add esp, STK_SIZE * 6
		
		ret

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
