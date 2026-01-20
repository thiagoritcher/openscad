include <lib/func.scad>
include <lib/arcd.scad>
include <lib/lin.scad>
/**
Project 
Description
Author
*/

build();

//parte
size = [10,10,10];

ph = .3;


module build(){
  parte();
}

//parte:
module parte(){
  //a:
  module a(){
    r = 2; //radius
    ra = 2; //second radius
    w = 1; //width
    fn=6;//number of points

    s = darc_size(r, ra, w, fn);
    n = 6;
    tr(x=r + w)
    linv(vecx, n, n*s, s)
      tr(x = -s/2)
      darc(r, ra, w, fn);

    //darc(r, ra, w, fn);
    square([n*s,1]);
  }
  
  //b:
  module b(){
  }
  
  //c:
  module c(){
  }
  
  a();
  b();
  c();
}
