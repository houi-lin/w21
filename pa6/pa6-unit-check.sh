#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/houi-lin/w21/master/pa6

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi


cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelDictionaryTest.c > ModelDictionaryTest.c

echo ""
echo ""

echo "Press Enter To Continue with Dictionary Unit Test"
read verbose

echo ""
echo ""

gcc -c -std=c11 -Wall -g ModelDictionaryTest.c Dictionary.c
gcc -o ModelDictionaryTest ModelDictionaryTest.o Dictionary.o

timeout 6 valgrind --leak-check=full -v ./ModelDictionaryTest -v > ModelDictionaryTest-out.txt 2> ModelDictionaryTest-mem.txt

cat ModelDictionaryTest-out.txt
cat ModelDictionaryTest-mem.txt | grep --after-context=8 -E 'SUMMARY|freed'

rm -f *.o ModelDictionaryTest*

