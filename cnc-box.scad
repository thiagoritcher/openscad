include <lib/func.scad>
include <lib/polymath.scad>
include <lib/arc.scad>

box= [300,400,100];
esp=15;
ecut=8;

rad = 1.6;
tabn=[5,7,1];
tw = 30;
ff = 5;

fg=.5;


module ccut(x=esp, y=tw, r=rad){
    rh = norm([r,r])/2;
    tr(x=x/2-rh, y = y/2-rh)
    circle(r=r, $fn=24); 
}
module ccuto(x=esp, y=tw, r=rad){
    rh = norm([r,r])/2;
    tr(x=x/2-rh, y = y/2+rh)
    circle(r=r, $fn=24); 
}
module scut(x=esp, y=tw, r=rad){
    square([x,y], center=true);
}

module tcut(x=esp, y=tw, r=rad){
    union(){
        scut();
        mir4()
        ccut();
    }
}

 module xcut( x=box.x, y=box.y, nx=tabn.x,  ee=esp){
   xn = ((nx- 1)/2);
   sx = x/2 - tw/2 - ff;
        
   dx = sx/xn;
   for(i = [0:(nx - 1)/2]){   
       tr(
       x = i*dx,
       y=y/2 - ee/2 - ff)
       
       rot(z=90)
       children();
   }
}

module ycut( x=box.x, y=box.y, ny=tabn.y,  ee=esp){
   yn = ((ny- 1)/2);
   sy = y/2 - tw/2 - ff;
        
   dy = sy/yn;
   
   for(i = [0:(ny - 1)/2 - 1]){   
       tr(
       x = x/2 - ee/2 - ff,
       y = i*dy)
       children();
   }
}

module base(
    x=box.x, y=box.y, nx=tabn.x, ny=tabn.y, ee=esp, ff=ff
    ){
   
 
   
   difference(){
       linear_extrude(ee)
       square([x,y], center=true);
       
       #tr(z=ee - ecut)
       linear_extrude(ecut)
       mir4()
       union(){
       xcut() tcut();
       ycut() tcut();
       }
       
   };
}

base();

module brd1(x=box.z, y=box.y, ny=tabn.y, ee=ecut){
    
    
    module yadd(){
    yn = ((ny- 1)/2);
    sy = y/2 - tw/2 - ff;
        
    dy = sy/yn;
    
    for(i = [0:(ny - 1)/2 - 1]){   
       tr(
       x = -x/2 - ee/2,
       y = i*dy)
        children();
    } 
   }
    
    linear_extrude(esp){
    miry2()
    yadd()
    difference(){
        #scut(x=ee, y=tw - fg*2);
        miry2()
        #ccuto(x=ee, y=tw - fg*2);
    }
    square([x,y], center=true);
    };
}

tr(x = box.x/2 + box.z/2 + 2*rad + ecut)
brd1();