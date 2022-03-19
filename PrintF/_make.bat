nasm -f win32 printf.asm -o printf.obj -l printf.lst -Lp

nasm -f win32 tests.asm -o tests.obj -l tests.lst -Lp

golink /console /fo printf.exe printf.obj tests.obj kernel32.dll msvcrt.dll
