#!/bin/bash

# prepare ROOT
source thisroot.sh

# link fortran libraries
ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/lib/libgfortran.so
ln -s /usr/lib/x86_64-linux-gnu/libquadmath.so.0 /usr/lib/libquadmath.so

# add model
export PYTHONPATH=$PYTHONPATH:/work/

# modify param card
cp /work/param_card_default.dat /work/param_card.dat

COUPLING_GQ=0.25
COUPLING_GX=1.00
MIXING_TH=0.01
MASS_MZp=1000.
MASS_MDM=200.
MASS_MHs=160.

sed -i -e "s/{__COUPLING_GQ__}/${COUPLING_GQ}/g" /work/param_card.dat
sed -i -e "s/{__COUPLING_GX__}/${COUPLING_GX}/g" /work/param_card.dat
sed -i -e "s/{__MIXING_TH__}/${MIXING_TH}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MZp__}/${MASS_MZp}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MDM__}/${MASS_MZp}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MHs__}/${MASS_MHs}/g" /work/param_card.dat

# run CheckMATE
/checkmate/bin/CheckMATE /work/example.in

# clean up
rm -f /work/param_card.dat
