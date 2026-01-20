//functions modules
//short names to functions

module tr(x= 0, y = 0, z = 0){
  translate([x, y, z]) children();
}

module trv(v){
  translate(v) children();
}

module rot(x = 0, y = 0, z = 0){
  rotate([x, y, z]) children();
}

module rotv(v){
  translate(v) children();
}

module mir(x = 0, y = 0, z = 0){
  mirror([x, y, z]) children();
}

module mirv(v){
  mirror(v) children();
}

module mirx(){
  mirror([1,0,0]) children();
}

module miry(){
  mirror([0,1,0]) children();
}

function vec(x=0,y=0,z=0) = [x, y, z];

vecx = [1, 0, 0];
vecy = [0, 1, 0];
vecz = [0, 0, 1];
