include <lib/round.scad>

build();

// [Base]
//base
bx = 240;
//bx =80;
by = 12; 
bh = 2.4;

// [Suporte]
//number
sn = 15;

//suporte
sh = 12;
sr0= 6;
sh0 = 5;
sr1 = 3;
sr2 = 2;



//furos
fr = 2;
fm = 6;

//heart
hs = .25;
hh = 2;
ht = 17;

$fn=32;

//reforco1
re = 1.5;


function heart_height(hs) = norm([hs*20, hs*20]);

function heart_width(hs) = hs*18;

module heart(s,h){
    module flat_heart(s) {
      square(s*20);

      translate([s*10, s*20, 0])
      circle(s*10);

      translate([s*20, s*10, 0])
      circle(s*10);
    }
    
    translate([0,-s*ht,0])
    rotate([0,0,45])
    linear_extrude(height = h) 
    flat_heart(s);
    
}

module suporte(){
    cylinder(sh0, sr0, sr1 *.8);
    cylinder(sh, sr1, sr2);
    translate([0,0,sh])
    heart(hs, hh);
    //reforco(re);
    reforco2();
}

module reforco(s){
    h = sh*.8;
    rotate([90,0,-90])
    linear_extrude(s, center=true)
    
    polygon([
        [0,0],
        [0,h],
        [sr2,h],
        [by/2 - s, 0]
    ]);
    
}


module reforco2(){
    d = heart_width(hs);
    #translate([0,0,sh])
    rotate_extrude()
    polygon([
        [0,-d *.7],
        [d *.7,0],
        [0,0]
    ]);
    
}

module furo(){
    pos = [bx/2 -fm, 0,0];
    module f(){
        translate(pos) 
        cylinder(r = fr,  h=bh+1, center=true);
        
        translate(pos + [0,0,bh * .2]) 
        cylinder(r1 = fr, r2= fr * 2,  h = bh * .3);
    }
    mirror([1,0,0])
    f();
    f();
}


module suportes(){
    nx = (sn/2 -1)+1;
    dx = ((bx - 2*fm) - fm) /sn;
    echo(dx);
    
    module a(){
        for(i = [0:nx]){
            translate([i*dx,0,0])
            suporte();
        }
    }
    a();
     mirror([1,0,0])
    a();
}

module corte(){
    nx = 3;
    dx = bx / (2*nx  +1);
    
    module c(){
      for(i = [0:nx]){
            translate([i*dx,0,-bh/2])
              cube([1,by,1], center=true);
      }
    }
    difference(){
      children();
      
      c();
      mirror([1,0,0]) c();
      
      
    } 
      
  
}

module build() {
    v = [bx, by, bh];
    
    suportes();
    corte()
    difference(){
    round4corner(v, 6, bh + 1)
    cube(v, true);
    furo();
    }
}

