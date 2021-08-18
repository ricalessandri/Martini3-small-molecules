#!/bin/bash

# Get the number of beads (and the number of beads - 1) from the mapping.ndx file
no_of_beads=$(grep "\[" ../3_mapped/mapping.ndx | wc -l)
no_of_beads_minus_1=$( python -c "print( $no_of_beads - 1)" )

seq 0 $no_of_beads_minus_1 | gmx traj -f ../3_mapped/AA-traj.whole.xtc -s ../3_mapped/AA-COG.tpr \
                                      -n ../3_mapped/mapping.ndx -oxt molecule.gro -ng ${no_of_beads} -com -e 0

# Generate the CG tpr
gmx grompp -f martini_v2.x_new_run.mdp -c molecule.gro -p system_CG.top -o CG.tpr -maxwarn 1

