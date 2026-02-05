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
    
    d = [6.5, 10, .9];
    c = 4.2;
    
    cube(d, center=true);
    cube(10, center=true);
    
    
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
