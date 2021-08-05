#!/bin/bash

#-------------------------------------------------------------------------------------------------------------------------------------------------------#
# USE: 
# ./setup_CG_system_and_run.sh BENZ.gro BENZ
#
# BEFORE:  
# You may want to change the number of molecules in the box: do that by changing n_mol_x, n_mol_y, and n_mol_z.
#
# COMMENTS:
# None.
#-------------------------------------------------------------------------------------------------------------------------------------------------------#


# EDITABLE SECTIONS ARE MARKED WITH #@#


# Load GROMACS 2016.5
source /usr/local/gromacs-2016.5/bin/GMXRC


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

# number to be fed to gmx genconf (number of moleculs per axis)
n_mol_x=10   #@#
n_mol_y=10   #@#
n_mol_z=10   #@#


# 1. Create solvent box
 gmx editconf -f ${molecule} -bt cubic -d 0.4 -o centred.gro  >> grompp.log 2>&1
 gmx genconf  -f centred.gro -nbox $n_mol_x $n_mol_y $n_mol_z -rot -o 0-start.gro  >> grompp.log 2>&1

# 2. Prepare TOP file 
 cp topol_EMPTY.top    topol.top
 cp topol_MM_EMPTY.top topol_MM.top
 n_molecules=$(python -c "print( $n_mol_x * $n_mol_y * $n_mol_z )")
 echo ${name}  "   $n_molecules " >> topol.top
 echo ${name}  "   $n_molecules " >> topol_MM.top

# 3. Squeeze, relax and run 
 gmx grompp -f squeeze.mdp -p topol.top -c 0-start.gro   -o 1-squeeze.tpr -po 1-squeeze.mdp -maxwarn 10  >> grompp.log 2>&1
 gmx mdrun -nt 4 -rdd 1.4 -v -deffnm 1-squeeze -dlb yes  >> mdrun.log 2>&1

 gmx grompp -f relax.mdp   -p topol.top -c 1-squeeze.gro -o 2-relax.tpr   -po 2-relax.mdp   -maxwarn 10  >> grompp.log 2>&1 
 gmx mdrun -nt 4 -rdd 1.4 -v -deffnm 2-relax   -dlb yes  >> mdrun.log 2>&1
 
 gmx grompp -f runNPT.mdp  -p topol.top    -c 2-relax.gro -o 3-runNPT.tpr    -po 3-runNPT.mdp    -maxwarn 10  >> grompp.log 2>&1
 gmx grompp -f runNPT.mdp  -p topol_MM.top -c 2-relax.gro -o 3-runNPT_MM.tpr -po 3-runNPT_MM.mdp -maxwarn 10  >> grompp.log 2>&1
 gmx mdrun -nt 4 -rdd 1.4 -v -deffnm 3-runNPT  -dlb yes  >> mdrun.log 2>&1

 gmx grompp -f runNVT.mdp  -p topol.top -c 3-runNPT.gro  -o 4-runNVT.tpr  -po 4-runNVT.mdp  -maxwarn 10  >> grompp.log 2>&1
 gmx mdrun -nt 4 -rdd 1.4 -v -deffnm 4-runNVT  -dlb yes  >> mdrun.log 2>&1

# 4. Clean up
rm -rf \#*

