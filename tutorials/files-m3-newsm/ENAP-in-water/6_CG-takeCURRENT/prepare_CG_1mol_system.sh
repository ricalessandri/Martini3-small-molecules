#!/bin/bash

source /usr/local/gromacs-2019.5/bin/GMXRC

#### TO DO BEFORE:
# check:
# 1. system.top
# 2. martini_em.mdp, martini_eq.mdp, martini_run.mdp

#  Needs 1 x SOLUTE MOLECULE file and a SOLVENT BOX file
#  e.g.
#$ ./prepare_CG_1mol_system.sh MOL.pdb box.gro W 1

#  Check if the files have been passed to the script
solute="$1"
solvent_box="$2"
solvent_name="$3"
solvent_atoms="$4"
size_1=${#solute}
size_2=${#solvent_box}
size_3=${#solvent_name}
size_4=${#solvent_atoms}
if [ $size_1 = 0 ] || [$size_2 = 0 ] ; then
      echo ""
      echo "Missing file of solute or solvent box. Check that"
      echo " ./prepare_CG_1mol_system.sh  ENAP.gro  box_CG_water_eq.gro  W  1"
      exit
elif [ $size_3 = 0 ] || [ $size_4 = 0 ] ; then
      echo ""
      echo "Missing >solvent name< or >number of solvent atoms<. Check that. E.g.:"
      echo " ./prepare_CG_1mol_system.sh  ENAP.gro  box_CG_water_eq.gro  W  1"
      exit
fi


gmx solvate -cp ${solute} -cs ${solvent_box} -o initial.gro -box 4.5 4.5 4.5 # NEW!

cp system_EMPTY.top system.top
solvent_lines=$(grep $solvent_name initial.gro | wc -l)
solvent_molecules=$(expr $solvent_lines / $solvent_atoms )
echo "$solvent_name               $solvent_molecules" >> system.top

gmx grompp -p system.top -c initial.gro -f martini_em.mdp  -o 1-min.tpr -po 1-min.mdp  -maxwarn 1
gmx mdrun -v -deffnm 1-min >> mdrun.log 2>&1

gmx grompp -p system.top -c 1-min.gro   -f martini_eq.mdp  -o 2-eq.tpr  -po 2-eq.mdp 
gmx mdrun -v -deffnm 2-eq  >> mdrun.log 2>&1

gmx grompp -p system.top -c 2-eq.gro    -f martini_run.mdp -o 3-run.tpr -po 3-run.mdp 
gmx mdrun -v -deffnm 3-run >> mdrun.log 2>&1

