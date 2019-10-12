wipe 
model BasicBuilder -ndm 2 -ndf 2
set x {720 720 360 360 0 0}; set y {360 0 360 0 360 0}
for {set i 0} {$i<6} {incr i} {
    node [expr $i+1] [lindex $x $i] [lindex $y $i]
}
uniaxialMaterial Elastic 1 3000.0
set conn {{5 3} {3 1} {6 4} {4 2} {3 4} 
     {1 2} {5 4} {6 3}  {3 2} {4 1}};
for {set i 0} {$i < 10} {incr i} {
    set n1 [lindex $conn $i 0]; set n2 [lindex $conn $i 1]
    set A [lindex $As $i]
    element truss [expr $i+1] $n1 $n2 $A 1
}
fix 5 1 1;fix 6 1 1;
pattern Plain 1 "Linear" {
    load 2 0 -100; load 4 0 -100
}
system BandSPD;constraints Plain;integrator LoadControl 1.0;
algorithm Linear;numberer RCM;analysis Static
analyze 1