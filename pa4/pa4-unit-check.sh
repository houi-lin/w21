#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/houi-lin/w21/master/pa4

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi


cp *.cpp *.h Makefile REAMDE* backup   # copy all files of importance into backup

curl $SRCDIR/ModelListTest.cpp > ModelListTest.cpp

echo ""
echo ""

echo "Press Enter To Continue with List Unit Test"
read verbose

echo ""
echo ""

g++ -std=c++11 -Wall -c ModelListTest.cpp List.cpp
g++ -std=c++11 -Wall -o ModelListTest ModelListTest.o List.o

timeout 5 valgrind --leak-check=full -v ./ModelListTest -v > ListTest-out.txt 2> ListTest-mem.txt

cat ListTest-out.txt
cat ListTest-mem.txt | grep --after-context=8 -E 'SUMMARY|freed'

rm -f *.o ModelListTest* ListTest-out.txt ListTest-mem.txt

