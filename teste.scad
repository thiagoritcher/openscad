include <lib/polyround.scad>

module basicPolyRoundExample(){
  // polyLine is a dev helper. Aim is to show the points of the polygon and their order before
  // you're ready to move on to polyRound and a polygon
  d = [40,50];
  c = [20,25];

  r = 5;
  radiiPoints=[[0,0,0],[0, d.y, 0],[c.x, d.y, r],[c.x, d.y-c.y, r], [d.x, d.y - c.y, r], [d.x, 0, 0]];
  polygon(polyRound(radiiPoints,1));

  //%translate([0,0,0.3])polygon(getpoints(radiiPoints));//transparent copy of the polgon without rounding
}


basicPolyRoundExample();

