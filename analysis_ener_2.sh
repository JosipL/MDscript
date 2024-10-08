#!/bin/bash
rm energy.dat energy_oct* slurm-*
for s in {401..600} #| while read s; do
do

gmx_mpi energy -f ener_dist_$s.edr -o energy_text_$s.xvg<<EOF
42
43
46
47
50
51
EOF
sed -i '1,25d' energy_text_$s.xvg
#
cat energy_text_$s.xvg >> energy.dat
awk '{print $1"   "$2+$3}' energy.dat > energy_octacid_wat.xvg
awk '{print $1"   "$4+$5}' energy.dat > energy_octacid_octacid.xvg
awk '{print $1"   "$6+$7}' energy.dat > energy_octacid_octanol.xvg
#
#rm  energy.xvg ener_dist.tpr md.log mdout.mdp traj.trr ener.edr trr.xtc index_$s.ndx
#
done
#
##cp energy.dat energy.xvg
#awk '{print $1"   "$2+$3}' energy.dat > energy.xvg
#
gmx_mpi analyze -f energy_octacid_octacid.xvg -dist dist_octacid_octacid.xvg

gmx_mpi analyze -f energy_octacid_wat.xvg -dist dist_octacid_wat.xvg

gmx_mpi analyze -f energy_octacid_octanol.xvg -dist dist_octacid_octanol.xvg
rm \#*#