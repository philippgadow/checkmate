#!/bin/bash

# prepare ROOT
source thisroot.sh

# link fortran libraries
ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/lib/libgfortran.so
ln -s /usr/lib/x86_64-linux-gnu/libquadmath.so.0 /usr/lib/libquadmath.so

# add model
export PYTHONPATH=$PYTHONPATH:/work/models

# check for environment variables (set them to default value, if empty)
if [ -z $MASS_MZp ]; then
    MASS_MZp=2500.
fi

if [ -z $MASS_MDM ]; then
    MASS_MDM=200.
fi

if [ -z $MASS_MHs ]; then
    MASS_MHs=160.
fi

# modify param card
cp /work/param_card_default.dat /work/param_card.dat

COUPLING_GQ=0.25
COUPLING_GX=1.00
MIXING_TH=0.01

echo "MASS_MZp=${MASS_MZp}"
echo "MASS_MDM=${MASS_MDM}"
echo "MASS_MHs=${MASS_MHs}"
echo "COUPLING_GQ=${COUPLING_GQ}"
echo "COUPLING_GX=${COUPLING_GX}"
echo "MIXING_TH=${MIXING_TH}"

sed -i -e "s/{__COUPLING_GQ__}/${COUPLING_GQ}/g" /work/param_card.dat
sed -i -e "s/{__COUPLING_GX__}/${COUPLING_GX}/g" /work/param_card.dat
sed -i -e "s/{__MIXING_TH__}/${MIXING_TH}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MZp__}/${MASS_MZp}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MDM__}/${MASS_MDM}/g" /work/param_card.dat
sed -i -e "s/{__MASS_MHs__}/${MASS_MHs}/g" /work/param_card.dat

# run CheckMATE
/checkmate/bin/CheckMATE /work/config.in

# clean up
rm -f /work/param_card.dat
