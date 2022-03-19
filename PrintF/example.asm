extern __Z6printfPKcz

extern _getchar

section .text
main:
		
		push printfStr
		
		call __Z6printfPKcz
		
		call _getchar
		
		ret
		
section .data

printfStr		db "Hello printf!", 0Ah, 00h