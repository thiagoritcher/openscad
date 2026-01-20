include <lib/func.scad>
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
    linvs(vecx, n=5, spacing=10, width=10, first=5)
      cube(size, center=true);
    
    
  }
  
  //b:
  module b(){
    
    tr(y=-1/2)
    cube([100, 1, 1]);
  }
  
  //c:
  module c(){
    #cylinder(h=10, r=5, center=true);
    
    translate(vec(x=linsv_size(n=5, spacing=10, width=10, first=5)))
    #cylinder(h=10, r=5, center=true);
  }
  
  a();
  b();
  c();
}
