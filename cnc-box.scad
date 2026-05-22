include <lib/func.scad>
include <lib/polymath.scad>
include <lib/arc.scad>


//montar();
plano();

s = 2*15+2*5;

box= [75+s, 55+s, 190];
esp=15;
ecut=9;

rad = 1.6;
tabn=[3,3,5];
tw = 15;
ff = 5;

fg=.5;

//#cube([75, 55, 55], center=true);



module plano(){
mir2()
tr(y = box.y/2 + box.z/2 + 2*rad + ecut + 1,
   x = -box.x/2 - 2*rad/2 -1)
brd2();

mir2()
tr(x = box.x/2 + box.z/2 + 2*rad + ecut * 1 + 1)
brd1();

base();
}

//plano();

module montar(){
base();

#mir2()
tr(x=box.x/2 -ff ,
    z = box.z/2 + esp + fg)
rot(y = -90)
brd1();
    
#miry2()
tr(y=box.y/2 -ff ,
    z = box.z/2 + esp + fg)
rot(x = 90)
brd2();
}


module brd1(x=box.z, y=box.y, z=box.z,
    ny=tabn.y, nz=tabn.z, ee=ecut){
    
    linear_extrude(esp){
        miry2()
        //mir4()
        yadd()
        fing();
    };
    
    linear_extrude(esp){
        mir4()
        zadd(y=y - 2*(ff + esp +fg))
        fing();
    };
    
    linear_extrude(esp){
        square([x,y- 2*(ff + esp +fg)], center=true);
    }
}


module ccut(x=esp+ 2*fg, y=tw, r=rad){
    rh = norm([r,r])/2;
    tr(x=x/2-rh, y = y/2-rh)
    circle(r=r, $fn=24); 
}
module ccuto(x=esp+ 2*fg, y=tw, r=rad){
    rh = norm([r,r])/2;
    tr(x=x/2-rh, y = y/2+rh)
    circle(r=r, $fn=24); 
}
module scut(x=esp + 2*fg, y=tw, r=rad){
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

module zcut( x=box.x, y=box.y, z = box.z, 
    ny=tabn.y, nz =tabn.z,  ee=esp){
        
   zn = ((nz- 1)/2);
   sz = z/2 - tw/2 - ff;
        
   dz = sz/zn;
   v = [x/2 - ee/2 - ff, 0];
   if(nz == 1) {
       trv(v) 
         children();
   }
   else {
       for(i = [0:(nz - 1)/2]){   
           trv(v + [0, i*dz])
           children();
       }
   }
}

module base(
    x=box.x, y=box.y, nx=tabn.x, ny=tabn.y, ee=esp, ff=ff
    ){
   
 
   
   difference(){
       linear_extrude(ee)
       square([x,y], center=true);
       
       tr(z=ee - ecut)
       linear_extrude(ecut)
       mir4()
       union(){
       xcut() tcut();
       ycut() tcut();
       }
       
   };
}

module yadd(x=box.z, y=box.y, z=box.z,
    ny=tabn.y, nz=tabn.z, ee=ecut){
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

module zadd(x=box.z, y=box.y, z=box.z,
    ny=tabn.y, nz=tabn.z, ee=ecut){
    zn = ((nz- 1)/2);
    sz = z/2 - tw/2 - ff;
    
    dz = sz/zn;
    
    if(nz == 1){
        tr(y=y/2 + ee/2, x = 0)
        rot(z=270)
        children();
    }
    else {
        for(i = [0:(nz - 1)/2]){   
           tr(y=y/2+ee/2, x = i * dz)
           rot(z=270)
           children();
        };  
    }
}

module xadd(x=box.x, y=box.y, z=box.z,
    nx = tabn.x, ny=tabn.y, nz=tabn.z, ee=ecut){
        
    xn = ((nx - 1)/2);
    sx = x/2 - tw/2 - ff;
        
    dx = sx/xn;
    
    for(i = [0:(nx - 1)/2]){   
       tr(
       y = -z/2 - ee/2,
       x = i*dx)
        rot(z=90)
        children();
    } 
}


 module fing(ee=ecut){
    difference(){
        scut(x=ee, y=tw - fg*2);
        miry2()
        ccuto(x=ee, y=tw - fg*2);
    }
}



module brd2(x=box.x, y=box.z,
    ny=tabn.y, nz=tabn.z, ee=ecut){
        
    linear_extrude(esp){
        mir2()
        //mir4()
        xadd()
        fing();
    }
    
     difference(){
       linear_extrude(esp)
        square([x,y ], center=true);
    
        tr(z=esp - ee)
        linear_extrude(ee)
           mir4()
           zcut() tcut();
       
    }
}

