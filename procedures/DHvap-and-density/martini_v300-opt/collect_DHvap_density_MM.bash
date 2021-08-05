#!/bin/bash


# Generate up-to-date 'list of molecules'
repoSM30="/coarse/riccardo/Repos/Martini3-small-molecules"
${repoSM30}/utils/GET_UP-TO-DATE_list_molecules.bash  ${repoSM30}/models/martini_v3.0.0_small_molecules_v1.itp > list_molecules_results 

# For the printf, in order to switch to North American float separation style simply set LC_NUMERIC to its American value.
export LC_NUMERIC="en_US.UTF-8"

# Define output file 
DHvap_and_density_outfile='results_DHvap_and_density_opt'
 
# Remove previous output files
rm ${DHvap_and_density_outfile}.txt ${DHvap_and_density_outfile}.csv # we'll overwrite

R=0.00831446 # kJ/mol
T=298.15     # K 

count=1 # just for counting!

# header
headerTXT="#  | LABEL | DH_vap  | density |"
headerCSV="LABEL,DH_vap_CG,density_CG"
separator="------------------------------"
echo ${headerCSV}      >> ${DHvap_and_density_outfile}.csv
echo ${headerTXT}      >> ${DHvap_and_density_outfile}.txt
printf '%s' $separator >> ${DHvap_and_density_outfile}.txt

while read mol; do
     
    # Get the number of molecules in the LIQ phase simulation
    N_mol=$(grep ${mol} data/${mol}/topol.top | awk '{print $2}')

    # Get U_{liq}
    Uliq=$(echo Total-Energy | gmx energy  -f data/${mol}/4-runNVT.edr -o data/${mol}/Uliq.xvg  | grep "Total Energy" | awk '{ print $3}')
    # Get U_{gas}
    Ugas=$(echo Total-Energy | gmx energy  -f data/${mol}/GAS/runNVT.edr -o data/${mol}/GAS/Uliq.xvg  | grep "Total Energy" | awk '{ print $3}')
    DH_vap_CG=$(python3 -c "print(${Ugas} - ${Uliq}/${N_mol} + ${R} * ${T} )")

    # Compute the density (in g/cm^3) using the itp containing the actual molar mass (MM) of the ${mol}
    # i.e., first -rerun with TPR with actual MM
    gmx mdrun -rerun data/${mol}/3-runNPT.xtc -s data/${mol}/3-runNPT_MM.tpr -e data/${mol}/3-runNPT_MM.edr -g data/${mol}/3-runNPT_MM_rerun.log 
    density=$(echo Density | gmx energy  -f data/${mol}/3-runNPT_MM.edr -o data/${mol}/dens.xvg  | grep "Density" | awk '{ print $2}')
    density=$(python3 -c "print( ${density} / 1000)") # convert to g/cm3
    
    # Printing
    printf '\n%3d  %5s  %7.2f  %8.3f' $count ${mol} $DH_vap_CG $density  >> ${DHvap_and_density_outfile}.txt
    echo "${mol},$DH_vap_CG,$density"  >> ${DHvap_and_density_outfile}.csv
 
    count=$(( $count + 1 ))

    # Clean up
    rm data/${mol}/\#*  data/${mol}/GAS/\#*

done <list_molecules_results  #@# indicate the name of the solute(s) in the file "list_molecules_results" 

cp ${DHvap_and_density_outfile}.txt ../../../properties/CG/. 
cp ${DHvap_and_density_outfile}.csv ../../../properties/CG/. 

