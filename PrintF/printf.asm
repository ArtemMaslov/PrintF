
extern _WriteConsoleA@20 ; kernel32.dll

extern _GetStdHandle@4   ; kernel32.dll

extern _printf			 ; msvcrt.dll

global _PrintF

global _ItoaDec
section .text

;-------------------------------------------------------------------------
; Prints formated string to screen
; 
; Entry: cdecl
;		 1 arg - formated string address
;		 next args - formated string arguments 
; 
; Destr:
;		 esi, eax, ebx, ecx, edx, edi
;-------------------------------------------------------------------------
_PrintF:
		push ebp
		mov ebp, esp
		
		; save stdout handle
		push dword -11
        call _GetStdHandle@4
		mov dword [stdout], eax

		mov esi, [ebp + STK_SIZE * 2] ; string address
		add ebp, STK_SIZE * 3
		
		cmp byte [esi], 0 ; is null-terminator
		jne .printLoop
		
		jmp .exit
		
.printLoop:
		
		mov cl, byte [esi] ; current char
		cmp cl, '%'
		jne .printSymbol
		
.parsePercent:
		
		inc esi
		mov eax, 0
		mov al, byte [esi] ; current char
		
		cmp al, '%' ; is null-terminator
		je .printSymbol
		
		cmp al, 'b'
		jb .exit
		
		cmp al, 'x'
		ja .exit
		
		mov edx, STK_SIZE
		mul edx ; eax *= STK_SIZE
		
		mov eax, dword [eax - 'b' * STK_SIZE + .switch]
		jmp eax
		
.formatChar:
		
		; call putc();
		push 0               ; reserved
		push 0               ; pointer to number of chars written (null)
		push 1               ; number of chars to write
		push ebp             ; pointer to buffer
		push dword [stdout]  ; stdout handle
		call _WriteConsoleA@20
		
		add ebp, STK_SIZE
		
		jmp .step
		; ! format char
		
.formatString:

		mov edi, dword [ebp]
		add ebp, STK_SIZE
		
		call PrintString
		
		jmp .step
		; ! format string
		
.formatDecimal:

		mov edi, ItoaArray
		mov eax, dword [ebp]
		add ebp, STK_SIZE
		
		call _ItoaDec
		
		call PrintString
		
		jmp .step
		; ! format decimal
		
.formatHexadecimal:

		mov edi, ItoaArray
		mov eax, dword [ebp]
		add ebp, STK_SIZE
		
		call ItoaHex
		
		call PrintString
		
		jmp .step
		; ! format hexadecimal
		
.formatOctal:

		mov edi, ItoaArray
		mov eax, dword [ebp]
		add ebp, STK_SIZE
		
		call ItoaOct
		
		call PrintString
		
		jmp .step
		; ! format octal
		
.formatBinary:

		mov edi, ItoaArray
		mov eax, dword [ebp]
		add ebp, STK_SIZE
		
		call ItoaBin
		
		call PrintString
		
		jmp .step
		; ! format binary
				
.printSymbol:
		; putc();
		push 0               ; reserved
		push 0               ; pointer to number of chars written (null)
		push 1               ; number of chars to write
		push esi             ; pointer to buffer
		push dword [stdout]  ; stdout handle
		call _WriteConsoleA@20
		; ! print Symbol
		
.step:
		inc esi
		
		; condition
		cmp byte [esi], 0 ; is null-terminator
		jne .printLoop
		
.exit:
		pop ebp
		
		mov eax, 0
		; call stdlib printf.
		; jmp _printf
		ret
		
section .data

.switch:
		dd .formatBinary      ; case 'b'
		dd .formatChar        ; case 'c'
		dd .formatDecimal     ; case 'd'
		dd .exit              ; 'e'
		dd .exit              ; 'f'
		dd .exit              ; 'g'
		dd .exit              ; 'h'
		dd .exit              ; 'i'
		dd .exit              ; 'j'
		dd .exit              ; 'k'
		dd .exit              ; 'l'
		dd .exit              ; 'm'
		dd .exit              ; 'n'
		dd .formatOctal       ; case 'o'
		dd .exit              ; 'p'
		dd .exit              ; 'q'
		dd .exit              ; 'r'
		dd .formatString      ; case 's'
		dd .exit              ; 't'
		dd .exit              ; 'u'
		dd .exit              ; 'v'
		dd .exit              ; 'w'
		dd .formatHexadecimal ; case 'x'

section .text

;--------------------------------------------------------------------
; Prints string to screen
;
; Entry:
;		 edi - source string
;
; Destr: edx, edi
;--------------------------------------------------------------------
PrintString:
		
		xor edx, edx
		cmp byte [edi], 0
		je .exit
		
.getCharsCount:
		inc edx
		
		cmp byte [edx + edi], 0
		jne .getCharsCount
		
		push 0               ; reserved
		push 0               ; pointer to number of chars written (null)
		push edx             ; number of chars to write
		push edi             ; pointer to buffer
		push dword [stdout]  ; stdout handle
		call _WriteConsoleA@20
		
.exit:
		ret

;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
; Itoa functions area
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------

;--------------------------------------------------------------------
; Convert decimal number to alpha
;
; Entry:
;		 eax - source number
;		 edi - string destination
;
; Destr: eax, ebx, ecx, edx
;--------------------------------------------------------------------
_ItoaDec:
		mov ebx, 0
		mov ecx, 10
		
.conv_num:
		mov edx, 0
		div ecx
		
		add dl, '0'
		mov byte [edi + ebx], dl
		
		inc ebx
		
		cmp eax, 0
		ja .conv_num
		
		mov byte [edi + ebx], 0 ; null-terminator
		dec ebx
		mov ecx, 0
		
		cmp ecx, ebx
		jae .exit
		
.reverse_num:
		
		mov al, byte [edi + ecx]
		mov ah, byte [edi + ebx]
		
		mov byte [edi + ecx], ah
		mov byte [edi + ebx], al
		
		dec ebx
		inc ecx
		
		cmp ecx, ebx
		jb .reverse_num
		
.exit:		
		ret

;--------------------------------------------------------------------
; Convert hexidecimal number to alpha
;
; Entry:
;		 eax - source number
;		 edi - string destination
;
; Destr: eax, ebx, ecx
;--------------------------------------------------------------------
ItoaHex:
		push eax
		mov ebx, -1 + 2 ; "0x"
		
.num_len:
		inc ebx
		shr eax, 4 ; div 16
		
		cmp eax, 0
		ja .num_len
		
		pop eax
		mov byte [edi + ebx + 01], 0 ; null-terminator
		
.conv_num:
		mov ecx, eax
		and ecx, 000Fh ; bit mask = 0b1111
		
		mov cl, byte [HexConvert + ecx]
		mov byte [edi + ebx], cl
		
		; step
		dec ebx
		shr eax, 4 ; div 16
		
		cmp ebx, 1
		ja .conv_num
		
		mov word [edi + ebx - 1], '0x'
		
		ret

;--------------------------------------------------------------------
; Convert octal number to alpha
;
; Entry:
;		 eax - source number
;		 edi - string destination
;
; Destr: eax, ebx, edx
;--------------------------------------------------------------------
ItoaOct:
		push eax
		mov ebx, -1 + 2 ; "0q"
		
.num_len:
		inc ebx
		shr eax, 3 ; div 8
		
		cmp eax, 0
		ja .num_len
		
		pop eax
		mov byte [edi + ebx + 01], 0 ; null-terminator
		
.conv_num:
		mov dl, al
		and dl, 7 ; bit mask
		
		add dl, '0'
		
		mov byte [edi + ebx], dl
		
		; step
		dec ebx
		shr eax, 3 ; div 8
		
		cmp ebx, 1
		ja .conv_num
		
		mov word [edi + ebx - 1], '0q'
		
		ret

;--------------------------------------------------------------------
; Convert binary number to alpha
;
; Entry:
;		 eax - source number
;		 edi - string destination
;
; Destr: eax, ebx, edx
;--------------------------------------------------------------------
ItoaBin:
		push eax
		mov ebx, -1 + 2 ; "0b"
		
.num_len:
		inc ebx
		shr eax, 1 ; div 2
		
		cmp eax, 0
		ja .num_len
		
		pop eax
		mov byte [edi + ebx + 1], 0 ; null-terminator
		
.conv_num:
		mov dl, al
		and dl, 1 ; bit mask
		
		add dl, '0'
		
		mov byte [edi + ebx], dl
		
		; step
		dec ebx
		shr eax, 1 ; div 1
		
		cmp ebx, 1
		ja .conv_num
		
		mov word [edi + ebx - 1], '0b'
		
		ret

;-------------------------------------------------------------------------
;-------------------------------------------------------------------------
; Data area
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------

section .data

STD_OUTPUT_HANDLE equ -11

STK_SIZE		equ 4 ; Размер 1 элемента стека в байтах

stdout			dq 0

HexConvert		db '0123456789ABCDEF'

ItoaArray		db 67 dup (0) ; "0b" + 64 bits + '\0' = 2 + 64 + 1 = 67
