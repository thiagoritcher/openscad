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

module mirz(){
  mirror([0,0,1]) children();
}

module mir2(){
  mirror([1,0,0]) children();
  children();
}

module mir4(){
  mir2() children();
  mirror([0,1,0])
  mir2() children();
}

function vec(x=0,y=0,z=0) = [x, y, z];
function vecc(src=[0,0,0], x=false,y=false,z=false) = 
  [x ? x :src.x, y ? y : src.y, z ? z: src.z];

//base vectors
vecx = [1, 0, 0];
vecy = [0, 1, 0];
vecz = [0, 0, 1];
