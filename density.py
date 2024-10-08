#Python script, using MDAnalysis packages to make 3D density plots, usefull to use instead of snapshots since it gives information over given time window.
import MDAnalysis
from MDAnalysis.analysis.density import density_from_Universe
u = MDAnalysis.Universe('../annealing.tpr','../annealing.trr')
#D = density_from_Universe(u, delta=1.0, update_selection=True, atomselection="name OH and z>5.8")
D = density_from_Universe(u, delta=1.0, atomselection='name C*', start=7000, stop= 7100, padding=10)
O = density_from_Universe(u, delta=1.0, atomselection='name O1', start=7000, stop= 7100, padding=10)
#D.convert_density('TIP4P')
D.export("C.dx", type="double")
O.export("O.dx", type="double")
