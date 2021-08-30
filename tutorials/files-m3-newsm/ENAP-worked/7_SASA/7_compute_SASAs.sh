#!/bin/bash

source /usr/local/gromacs-2019.5/bin/GMXRC

molecule="$1"
size_1=${#molecule}
if [ $size_1 -eq 0 ] ; then
   echo ""
   echo "Pass the label of the molecule to the script, please, i.e.:"
   echo "./7_compute_SASA.sh PCYM"
   exit
fi

# Atomistic
mkdir -p AA
cd       AA
cp ../vdwradii_AA.dat  vdwradii.dat
# Compute SASA
echo ${molecule} | gmx sasa -f ../../3_mapped/AA-traj.whole.xtc -s ../../3_mapped/AA-COG.tpr -ndots 4800 -probe 0.191  -o SASA-AA.xvg
gmx analyze -f SASA-AA.xvg -bw 0.01 -dist distr-SASA-AA.xvg &> temp_sasa.txt
awk '/SS1/ {print "average: " $2}/SS1 / {print "st.dev.: " $3}' temp_sasa.txt > data_sasa_AA.xvg
# Compute Connolly Surface
echo ${molecule} | gmx trjconv -f ../../1_AA-reference/1-min.gro -o ${molecule}-AA-min.gro -s ../../1_AA-reference/1-min.tpr -pbc whole
echo ${molecule} | gmx sasa -s ${molecule}-AA-min.gro -o temp.xvg -probe 0.191 -ndots 240 -q surf-AA.pdb
rm \#* temp_sasa.txt average.xvg errest.xvg temp.xvg
cd       ..

# Coarse-Grained
mkdir -p CG
cd       CG
cp ../vdwradii_CG.dat  vdwradii.dat
# Compute SASA
echo ${molecule} | gmx sasa -f ../../6_CG-takeCURRENT/CG.xtc -s ../../6_CG-takeCURRENT/CG.tpr -ndots 4800 -probe 0.191  -o SASA-CG.xvg
gmx analyze -f SASA-CG.xvg -bw 0.01 -dist distr-SASA-CG.xvg &> temp_sasa.txt
awk '/SS1/ {print "average: " $2}/SS1 / {print "st.dev.: " $3}' temp_sasa.txt > data_sasa_CG.xvg
# Compute Connolly Surface (first need to map the energy-minimized AA snapshot!)
no_of_beads=$(grep "\[" ../../3_mapped/mapping.ndx | wc -l)
no_of_beads_minus_1=$( python -c "print( $no_of_beads - 1)" )
seq 0 $no_of_beads_minus_1 | gmx traj -f ../AA/${molecule}-AA-min.gro -s ../../3_mapped/AA-COG.tpr \
                                      -n ../../3_mapped/mapping.ndx -oxt ${molecule}-MAPPED-min.gro -ng ${no_of_beads} -com 
echo ${molecule} | gmx trjconv -f ${molecule}-MAPPED-min.gro -o ${molecule}-MAPPED-min-CGatomnames.gro -s ../../6_CG-takeCURRENT/2-eq.tpr
echo ${molecule} | gmx sasa -s ${molecule}-MAPPED-min-CGatomnames.gro -o temp.xvg -probe 0.191 -ndots 240 -q surf-CG.pdb
rm \#* temp_sasa.txt average.xvg errest.xvg temp.xvg
cd       ..

