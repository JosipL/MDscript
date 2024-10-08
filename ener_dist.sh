 #!/bin/bash

key_name="water_oct20mMoctacid20mM_nvt"

#gmx_mpi trjconv -f ../$key_name.trr -o trr1.trr -b 2500 -e 3000

for s in {401..800} #| while read s; do
do
((i=3790 + $s))
gmx_mpi make_ndx -f ../$key_name.gro -o residue_$s.ndx <<EOF
ri $i
name 7 molecule
6 &! 7 
name 8 prop_rerun 
q
EOF
gmx_mpi grompp -f nvt_md.mdp -c ../water_oct20mMoctacid20mM_npt.gro -p ../octanol_GMX_OPLS.top -n residue_$s.ndx -o ener_dist_$s.tpr

done
#sbatch gromacs_water_octanol.sh 
rm \#*#
#gmx_mpi energy -f ener.edr > energy_average.dat << EOF
#47
#48
#EOF
