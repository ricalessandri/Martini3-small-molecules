#!/bin/bash

#-------------------------------------------------------------------------------------------------------------------------------------------------------#
# USE: 
# ./setup_1mol_box_and_run.sh BENZ.gro BENZ
#
# BEFORE:  
# Nothing.
#
# COMMENTS:
# None.
#-------------------------------------------------------------------------------------------------------------------------------------------------------#


# EDITABLE SECTIONS ARE MARKED WITH #@#


# Load GROMACS 2019.5
source /usr/local/gromacs-2019.5/bin/GMXRC


# Check input
molecule=$1
name=$2
size_1=${#molecule}
size_2=${#name}
if [ $size_1 -eq 0 -o $size_2 -eq 0 ] ; then
   echo ""
   echo "Missing molecule geometry file and/or molecule NAME. Please provide that"
   exit
fi


# 1. Create solvent box
 gmx editconf -f ${molecule} -bt cubic -d 7 -o centred.gro  >> grompp.log 2>&1

# 2. Prepare TOP file 
 cp topol_EMPTY.top topol.top
 echo ${name}  "   1 " >> topol.top

# 3. Squeeze, relax and run 
 gmx grompp -f runNVT.mdp  -p topol.top -c centred.gro   -o runNVT.tpr  -po runNVT.mdp  -maxwarn 10  >> grompp.log 2>&1 
 gmx mdrun -nt 2 -rdd 1.4 -v -deffnm runNVT     -dlb yes  >> mdrun.log 2>&1

# 4. Clean up
rm -rf \#*

