#!/bin/bash

FOLDERitpsSM30="/coarse/riccardo/Repos/small-molecules-3.0/models"
FOLDERsolute="/coarse/riccardo/Repos/small-molecules-3.0/models/gros"


#-------------------------------------------------------------------------------------------------------------------------------------------------------#
# USE: 
# ./submit_solvent_and_gas_v300.bash
#
# BEFORE:  
# Make sure the solute molecule is the folder ./solute; the filename has to be the [ moleculetype ] name (e.g., benzene's file is called "BENZ.gro").
# Also make sure the itps in the template folder (check ./template) contain your molecule's definition.
#
# COMMENTS:
# None.
#-------------------------------------------------------------------------------------------------------------------------------------------------------#


# EDITABLE SECTIONS ARE MARKED WITH #@#


# Load GROMACS 2019.5
source /usr/local/gromacs-2019.5/bin/GMXRC


while read mol; do
    mkdir -p data/${mol}
    cp -r template/* data/${mol}/.
    #
    cd data/${mol}
    cp ${FOLDERitpsSM30}/martini_v3.0_small_molecules.itp     .
    cp ${FOLDERitpsSM30}/martini_v3.0_small_molecules_MM.itp  .
    # Run the GAS phase:
    cd GAS
    cp ${FOLDERsolute}/${mol}.gro .
    ./setup_1mol_box_and_run.bash  ${mol}.gro  ${mol}
    cd .. 
    # Assemble the LIQ phase and run:
    cp ${FOLDERsolute}/${mol}.gro .
    ./setup_CG_system_and_run.bash ${mol}.gro ${mol}
    cd ../..
    #
done <list_molecules  #@# indicate the name of the solute(s) in the file "list_molecules" 

