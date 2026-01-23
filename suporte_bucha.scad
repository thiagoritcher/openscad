include <lib/func.scad>
include <lib/arc.scad>
include <lib/polyround.scad>
include <lib/round.scad>


/**
Project 
Description
Author
*/

build();

//parte
size = [80,25,2.4];
r1 = 5;

//suporte
sr = 5;
sd = 15;
sy= 5;

bdx = 25;

sdr = 15;
sa = 45; //ang





module build(){
  parte();
}

//parte:z
module parte(){
  //a:
  module a(){
    linear_extrude(size.z, center=true)
    polygon(polyRound([[0,0,0], [0, size.y,0], [size.x/2, size.y,r1], [size.x/2,0,0]]), 12);
  }
  
  //b:
  module b(){
    
    dx = bdx + cos(sa) * sdr;
    dy = sin(sa) * sdr;
    
    
    function beamPoints()=[
        [0,  sy, 0],
        [0,  0,  sr],
        [bdx,  0,  sr],
        [dx, dy, 0],
    ];
    
    radiiPoints=beamPoints();
    
    
    function square_coords(x, y, r) = [
      [-x, -y, r[0]],
      [-x, y, r[1]],
      [x, y, r[2]],
      [x, -y, r[3]]];
    
    
    tr(y=-sy, x=size.x/2 - sd/2)
    rot(y=-90) {
      tr(x=dx , y=dy)
      rot(z=sa - 90, y=90)
      tr(z=-size.z/2)
      linear_extrude(size.z)
      polygon(polyRound(square_coords(sd/2, sd/2, [0,5,5,0])));
      
     linear_extrude(sd, center=true)
      polygon(polyRound(beamChain(radiiPoints,offset1=size.z/2, offset2=-size.z/2),20));
    }
  }
  
  //c:
  module c(){

  }
  
  a();  mirror(vecx) a();
  b(); mirror(vecx) b();
  c();
}
