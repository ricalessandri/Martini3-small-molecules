#!/bin/bash

source /usr/local/gromacs-2019.5/bin/GMXRC


echo 0 | gmx trjconv -f ../1_AA-reference/3-run.xtc -o AA-traj.whole.xtc -s ../1_AA-reference/3-run.tpr -pbc whole

gmx grompp -p system_COG.top -f ../1_AA-reference/run.mdp -c ../1_AA-reference/2-eq.gro -o AA-COG.tpr
rm mdout.mdp # clean-up

no_of_beads=$(grep "\[" mapping.ndx | wc -l)
no_of_beads_minus_1=$( python -c "print( $no_of_beads - 1)" )

seq 0 $no_of_beads_minus_1 | gmx traj -f AA-traj.whole.xtc -s AA-COG.tpr -oxt mapped.xtc  -n mapping.ndx  -ng ${no_of_beads} -com


rm \#*
