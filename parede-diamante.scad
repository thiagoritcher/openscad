w2 = 2.5;
h = 2;
in = 0;

module a(){
linear_extrude(100)
for(i = [0:20]){
  translate([i * (w2 * 2 - in) ,0,0])
  polygon([[-w2,0],[0,h],[w2,0]]);
}
}


module b(){

difference(){
a();
translate([40*w2, h  ,40*w2])
rotate([0,90,180])
a();
}
}

difference(){
union(){
b();
translate([0,-.6,0])
cube([40*w2, .6  ,40*w2]);
}

translate([0,-.6,0])
b();

}


