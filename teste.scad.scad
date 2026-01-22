include <lib/func.scad>
include <lib/lin.scad>
include <lib/polymath.scad>
include <lib/polyround.scad>

/**
Project 
Description
Author
*/

build();

/* [Principal] */
//parte
size = [10,10,10];



module build(){
  parte();
}

//parte:
module parte(){
  //a:
  module a(){
    polygon(poly_arc(5, [0, 60]));
    polygon(poly_arc(5, [180, 360]));
  }
  
  //b:
  module b(){
    p = poly_rect(10, 20);
    b = poly_rect(1, 2);
     c = poly_join(p, 4, poly_trans(b, [0,-20 +2]), 3,-1);
    polygon(c);
  }
  
  //c:
  module c(){
    p = poly_rect(10, 20);
    b = poly_rect(10, 10);
    c = poly_join(p, 3, poly_trans(b, [20,0]), 1, 1);

    d = poly_add_radius(c, 
      [[2, 5], 
      [3, 2], 
      [6, 2],
      [7, 5]
      ]) ;
    echo(d);
    polygon(polyRound(d, 12), true);
  }
 
  tr(y=200)
  a();
  tr(y=100)
  b();
  c();
}
