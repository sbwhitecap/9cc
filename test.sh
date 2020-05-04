#!/bin/sh

try() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -g -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

try 0 'return 0;'
try 42 'return 42;'
try 21 'return 5+20-4;'
try 41 'return  12 + 34 - 5 ;'
try 31 'return      10 + 10 + 10   +  10    - 9;'
try 47 'return 5+6*7;'
try 15 'return 5*(9-6);'
try 4 'return (3+5)/2;'
try 10 'return -10+20;'
try 89 'return 63-(-13*2);'
try 37 'return 63-(-13*-2);'
try 10 'return - -10;'
try 10 'return - - +10;'
try 1 'return 1==1;'
try 0 'return 1==2;'
try 0 'return 1!=1;'
try 1 'return 1!=0;'
try 1 'return 1<2;'
try 0 'return 1<1;'
try 0 'return 2<1;'
try 1 'return 2>1;'
try 0 'return 1>1;'
try 0 'return 1>2;'
try 1 'return 1<=1;'
try 1 'return 1<=2;'
try 0 'return 2<=1;'
try 1 'return 1>=1;'
try 1 'return 2>=1;'
try 0 'return 1>=2;'
try 1 'return (1>=2)<1;'
try 1 '3;2;return 1;'
try 3 '1;2;return 3;'
try 42 'z=42;return z;'
try 43 'z=42;return z+1;'
try 27 'z=3*3;return z*3;'
try 0 'p=3;q=4;return p==q;'
try 1 'p=3;q=p;return p==q;'
try 0 'akizuki=1;haruzuki=9;return akizuki==haruzuki;'
try 1 'akizuki=1;haruzuki=9;return akizuki==akizuki;'
try 1 'akizuki=1;haruzuki=9;yoizuki=10;return haruzuki<=yoizuki;'
try 1 'akizuki=1;haruzuki=9;yoizuki=10;return haruzuki<=yoizuki;'
try 1 'p=3;q=p;return p==q;return p!=q;'
try 42 'p=3;q=p;return 42;return p==q;return p!=q;'
try 27 'a1=27;a2=20;return a1;'
try 27 'a_a=27;a_b=20;return a_a;'
try 4 'A=4;b=2;c3=5;return A;'

echo OK

