#!/bin/bash


source /usr/local/gromacs-2019.5/bin/GMXRC

### Pre-processing 

echo 0 | gmx trjconv -f 3-run.xtc -o CG.xtc -s 3-run.tpr -pbc whole
cp 3-run.tpr CG.tpr



### Bonds and constraints 

DIR="bonds_mapped"
rm -rf $DIR/*
mkdir $DIR

NBONDS=$(grep "\[" bonds.ndx | wc -l)

IBOND=0
while [ $IBOND -lt $NBONDS ]; do
    echo $IBOND | gmx distance -f CG.xtc -n bonds.ndx -s CG.tpr -oall $DIR/bond_$IBOND.xvg -xvg none &> $DIR/temp_bonds.txt
    echo "---- bond"$IBOND" ----" >> $DIR/data_bonds.txt
    awk '/Average distance/ {print $3} /Standard deviation/ {print $3}' $DIR/temp_bonds.txt >> $DIR/data_bonds.txt
    gmx analyze -f $DIR/bond_$IBOND.xvg -dist $DIR/distr_bond_$IBOND.xvg -xvg none -bw 0.001 
    rm -rf \#*
    let IBOND=$IBOND+1
done

# Clean-up
rm $DIR/temp_bonds.txt $DIR/\#*





### Angles

DIR="angles_mapped"
rm -rf $DIR/*
mkdir $DIR

NANGLES=$(grep "\[" angles.ndx | wc -l)

IANG=0
while [ $IANG -lt $NANGLES ]; do
    echo $IANG | gmx angle -f CG.xtc -n angles.ndx -ov $DIR/ang_$IANG.xvg -od $DIR/temp.xvg &> $DIR/temp_angles.txt
    echo "---- ang"$IANG" ----" >> $DIR/data_angles.txt
    awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_angles.txt >> $DIR/data_angles.txt
    gmx analyze -f $DIR/ang_$IANG.xvg -dist $DIR/distr_ang_$IANG.xvg -xvg none -bw 1.0 
    rm -rf \#*
    let IANG=$IANG+1
done

# Clean-up
rm $DIR/temp_angles.txt $DIR/temp.xvg $DIR/\#*





### Dihedrals

DIR="dihedrals_mapped"
rm -rf $DIR/*
mkdir $DIR

NDIHEDRALS=$(grep "\[" dihedrals.ndx | wc -l)

IDIH=0
while [ $IDIH -lt $NDIHEDRALS ]; do
    echo $IDIH | gmx angle -type dihedral -f CG.xtc -n dihedrals.ndx -ov $DIR/dih_$IDIH.xvg -od $DIR/temp.xvg &> $DIR/temp_dihedrals.txt
    echo "---- dih"$IDIH" ----" >> $DIR/data_dihedrals.txt
    awk '/< angle >/ {print $5} /Std. Dev./ {print $4}' $DIR/temp_dihedrals.txt >> $DIR/data_dihedrals.txt
    gmx analyze -f $DIR/dih_$IDIH.xvg -dist $DIR/distr_dih_$IDIH.xvg -xvg none -bw 1.0 
    rm -rf \#*
    let IDIH=$IDIH+1
done

# Clean-up
rm $DIR/temp_dihedrals.txt $DIR/temp.xvg $DIR/\#*

