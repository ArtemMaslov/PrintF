# PrintF
`PrintF` - это реализация стандартного `printf` из `C`.

### Какие символы форматирования поддерживаются:
1. Целочисленные модификаторы:
    1. `%d` - вывод числа в десятичном виде.
    1. `%x` - вывод числа в шестнадцатеричной системе счисления.
    1. `%o` - вывод числа в восьмеричной системе счисления.
    1. `%b` - вывод числа в двоичной системе счисления.
1. Вывод символов и строк:
    1. `%c` - вывод одного сивола.
    1. `%s` - вывод строки символов, которая должна оканчиваться `\0` - нулевым байтом.
1. Специальные символы:
    1. `%%` - вывод знака процента `%`.

### Что не поддерживается:
1. Вывод чисел с плавающей точкой.
2. Спецификаторы ширины и точности.
3. Эскейп-последовательности (`'\n', '\r', '\t', ...`)