#include <stdio.h>

extern "C" void PrintF(const char* format, ...);

int main(int argc, char* argv[])
{
	printf("main\n");

	PrintF("Hello printf!\n");

	PrintF("C%car f%c%cmat symbol\n", 'h', 'o', 'r');

	PrintF("Char %s %s%s\n", "super", "format ", "string!");

	PrintF("This is %d%% test. Hex = %%%x, oct = %o, bin = %b\n%c %s %x %b%%%c%b\n", -1, -1, 0x1CA8, 0x4CB3,  'I', "love", 3802, 4, '!', 15);

	PrintF("%c %s %x %b%%%c %b\n", 'I', "love", 3802, 4, '!', 127);

	getc(stdin);
}