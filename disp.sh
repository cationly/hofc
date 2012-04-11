#!/bin/sh
############################################################################# 

OUTDIR=""  
PSEUDO_DIR=""
OUTPUT=""
PWPATH=""
if [ ! -d $OUTDIR ]; then 
mkdir $OUTDIR 
fi
 
if [ ! -d $PSEUDO_DIR ]; then 
mkdir $PSEUDO_DIR 
fi 

i="0"
while [ $i -le 20 ] 
do

rm -f $OUTPUT/ar.scf.$i.in
cat > $OUTPUT/ar.scf.$i.in << EOF
  &control
    calculation = 'scf'
    restart_mode='from_scratch',
    prefix='ar',
    tstress = .true.
    tprnfor = .true.
    pseudo_dir = '$PSEUDO_DIR'
    outdir='$OUTDIR' 
 /
 &system
    ibrav=1,
    celldm(1)=20.0922181,
    nat= 32, 
    ntyp=1,
    ecutwfc=40.0,
/
&electrons
 /
ATOMIC_SPECIES
 Ar  39.948  Ar.pz-rrkj.UPF
ATOMIC_POSITIONS {angstrom}
Ar	 0.0000 0.0000 0.0000
Ar	 2.6581 2.6581 0.0000
Ar	 2.6581 0.0000 2.6581
Ar	 0.0000 2.6581 2.6581
Ar	 0.0000 0.0000 5.3162
Ar	 2.6581 2.6581 5.3162
Ar	 2.6581 0.0000 7.9744
Ar	 0.0000 2.6581 7.9744
Ar	 0.0000 5.3162 0.0000
Ar	 2.6581 7.9744 0.0000
Ar	 2.6581 5.3162 2.6581
Ar	 0.0000 7.9744 2.6581
Ar	 0.0000 5.3162 5.3162
Ar	 2.6581 7.9744 5.3162
Ar	 2.6581+0.01*$i 5.3162 7.9744
Ar	 0.0000 7.9744 7.9744
Ar	 5.3162 0.0000 0.0000
Ar	 7.9744 2.6581 0.0000
Ar	 7.9744 0.0000 2.6581
Ar	 5.3162 2.6581 2.6581
Ar	 5.3162 0.0000 5.3162
Ar	 7.9744 2.6581 5.3162
Ar	 7.9744 0.0000 7.9744
Ar	 5.3162 2.6581 7.9744
Ar	 5.3162 5.3162 0.0000
Ar	 7.9744 7.9744 0.0000
Ar	 7.9744 5.3162 2.6581
Ar	 5.3162 7.9744 2.6581
Ar	 5.3162 5.3162 5.3162
Ar	 7.9744 7.9744 5.3162
Ar	 7.9744 5.3162 7.9744
Ar	 5.3162 7.9744 7.9744
K_POINTS {automatic}
4 4 4  0 0 0
EOF
$PWPATH/pw.x < $OUTPUT/ar.scf.$i.in >  $OUTPUT/ar.scf.$i.out
i=$(( $i + 1 ))
done

