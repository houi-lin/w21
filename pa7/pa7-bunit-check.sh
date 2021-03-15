#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/houi-lin/w21/master/pa7
TIME=10

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi


cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelBigIntegerTest.c > ModelBigIntegerTest.c

echo ""
echo ""

echo "Press Enter To Continue with ModelBigIntegerTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c11 -Wall -g ModelBigIntegerTest.c BigInteger.c List.c -lm
gcc -o ModelBigIntegerTest ModelBigIntegerTest.o BigInteger.o List.o -lm

timeout $TIME valgrind --leak-check=full -v ./ModelBigIntegerTest -v > BigIntegerTest-out.txt 2> BigIntegerMemoryCheck.txt

cat BigIntegerTest-out.txt
cat BigIntegerMemoryCheck.txt | grep --after-context=8 -E 'SUMMARY|freed'

rm -f *.o ModelBigIntegerTest* BigIntegerTest-out.txt BigIntegerMemoryCheck.txt
