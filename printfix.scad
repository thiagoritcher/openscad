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

$fn=24;

module build(){
  parte();
}

//parte:
module parte(){
  //a:
  module a(s=.9){
    
    d = [6.5, 10, s];
    c = vecc(d, x=4.2, y=8);
    
    tr(z=s/2)
    difference(){      
      cube(d, center=true);
      tr(y=-1)
      cube(c, center=true);
    }
  }
  
  //b:
  module b(){
    dr = 4.2/2;
    er = dr +.6;
    
    linear_extrude(2.5)
    difference(){
      circle(er);
      circle(dr);
    }
    
  }
  
  //c:
  module c(){
  
  }
  linv(dir=[1,0,0], n=2, size=20, width=0, first=0, last=0) {
  /*
  
  {
  tr(x=10){
    a(.9);
    tr(y=20)
    a(1.2);
    tr(y=40)
    a(1.5);
  }
  */
    
  b();
  }
  
  
  
  
  c();
}
