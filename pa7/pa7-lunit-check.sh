#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/houi-lin/w21/master/pa7
TIME=8

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi


cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelListTest.c > ModelListTest.c

echo ""
echo ""

echo "Press Enter To Continue with ListTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c11 -Wall -g ModelListTest.c List.c
gcc -o ModelListTest ModelListTest.o List.o

timeout $TIME valgrind --leak-check=full -v ./ModelListTest -v > ListTest-out.txt 2> ListMemoryCheck.txt

cat ListTest-out.txt
cat ListMemoryCheck.txt | grep --after-context=8 -E 'SUMMARY|freed'


rm -f *.o ModelListTest* garbage ListMemoryCheck.txt ListTest-out.txt
