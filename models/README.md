
# Martini 3 small-molecule database - Models

The file [`martini_v3.0_small_molecules.itp`](https://github.com/ricalessandri/small-molecules-3.0/blob/main/models/martini_v3.0_small_molecules.itp) 
contains the up-to-date collection of Martini 3 small molecule models.

One way to look for a particular molecule is to search that file for the molecule common name in *capital* letters, e.g., BENZENE, TOLUENE, etc.
Alternatively, the folder [`SMILES/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/SMILES) contains the
SMILES string of the molecules for which a Martini 3 model exists. 
You can also see the list of unique identifies (uIDs), names, and SMILES strings in [`table-sm3-SI.tex`](https://github.com/ricalessandri/small-molecules-3.0/blob/main/models/table-sm3-SI.tex).


### Description of available files

For a given molecule with unique string ID `MOL`, 8 files are available:

1. `MOL.smiles`: the SMILES string represting the molecule 
   (folder [`SMILES/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/SMILES));

2. `MOL.itp`: the Martini 3 topology file in GROMACS format
   (folder [`itps/opt-????/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/itps)); 

2. `MOL.gro`: the Martini 3 coordinate file in GROMACS format
   (folder [`gros/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/gros)); 

4. `MOL_LigParGen.pdb`: atomistic structure as obtained from the [LigParGen server](http://zarbi.chem.yale.edu/ligpargen/)
   by entering the corresponding SMILES string; 
   (folder [`AA/oplsaa-LigParGen/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/AA/oplsaa-LigParGen));

5. `MOL_LigParGen.itp`: OPLS-AA/1.14\*CM1A-LBCC topology file (in GROMACS format) as obtained from the 
   [LigParGen server](http://zarbi.chem.yale.edu/ligpargen/) by entering the corresponding SMILES string;
   (folder [`AA/oplsaa-LigParGen/`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/AA/oplsaa-LigParGen));

6. `MOL_oplsaaTOcg_\*.ndx`: the AA-to-CG index file (folder 
   [`mapping-cgbuilder/oplsaa-LigParGen/MOL`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/mapping-cgbuilder/oplsaa-LigParGen)); 

7. `MOL_cgTOoplsaa_\*.map`: the CG-to-AA mapping file (folder 
   [`mapping-cgbuilder/oplsaa-LigParGen/MOL`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/mapping-cgbuilder/oplsaa-LigParGen)); 

8. `MOL_LigParGen_cgbuilder.png`: a screenshot to visualize the beads and underlying atomistic structure (folder 
   [`mapping-cgbuilder/oplsaa-LigParGen/MOL`](https://github.com/ricalessandri/small-molecules-3.0/blob/master/models/mapping-cgbuilder/oplsaa-LigParGen)); 

