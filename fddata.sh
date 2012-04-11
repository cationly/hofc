#!/bin/sh

nat="33"
i="0"
while [ $i -le 2 ] 
do

grep -A $nat "Forces acting on atoms (Ry/au):" ar.scf.$i.out > test.txt
sed -e 's/atom.*=//g' -e 's/Forces.*//g' -e 's/^[ \t]*//' -e '/^$/d' test.txt >> force.txt
rm test.txt

grep -A $nat " site n.     atom                  positions (alat units)" ar.scf.$i.out > test.txt
sed -e 's/^.*(//g' -e 's/)//g' -e 's/[a-z]*//g' -e 's/^[ \t]*//' -e '/^$/d' test.txt >> disp.txt
rm test.txt

i=$(( $i + 1 ))
done


