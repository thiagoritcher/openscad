include <lib/arc.scad>

//suporte
se=2;
sl=15; 
sr = 100;


//gancho
gh=8; 
gr = 5;


sl2 = sl/2;
sl4 = sl/4;

$fn = 100;

module suporte(sr, sl, se) {
translate([0,-sr -se,0])
arc(sr,[90 -  sl, 90 + sl], se, fn=64);
}

module gancho(gr,se){
    ah = gr;
    bh = se/2;
    
    rotate([0,0,22])
    translate([1,0,0])
    translate([se,ah + bh +se -1,0]) {
        arc(gr - se,[-90, 160], se, fn=64);
        
        translate([0,-se- gr,0])        
        arc(se,[90, 200], se, fn=64);
    }
}
linear_extrude(se) {
gancho(gr,se);
suporte(sr, sl, se);
}
