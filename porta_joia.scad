include <lib/round.scad>

build();

//base
bx = 200;
by = 30;
bh = 4;

//suporte
sh = 20;
sr0= 6;
sh0 = 5;
sr1 = 4;
sr2 = 3;

sn = 11;

//furos
fr = 2;
fm = 10;

//heart
hs = .3;
hh = 2;

$fn=32;


function heart_height(hs) = norm([hs*20, hs*20]);

module heart(s,h){
    module flat_heart(s) {
      square(s*20);

      translate([s*10, s*20, 0])
      circle(s*10);

      translate([s*20, s*10, 0])
      circle(s*10);
    }
    
    translate([0,-s*18,0])
    rotate([0,0,45])
    linear_extrude(height = h) 
    flat_heart(s);
    
}

module suporte(){
    cylinder(sh0, sr0, sr1 *.8);
    cylinder(sh, sr1, sr2);
    translate([0,0,sh])
    heart(hs, hh);
    reforco(2);
}

module reforco(s){
    rotate([90,0,-90])
    linear_extrude(sr0*.4, center=true)
    polygon([
        [0,0],
        [0,sh],
        [sr2*1.5,sh],
        [by/2 - s, 0]
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

module build() {
    v = [bx, by, bh];
    translate([0,4,0])
    suportes();
    difference(){
    round4corner(v, 8, bh + 1)
    cube(v, true);
    furo();
    }
}

