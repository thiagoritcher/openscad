include <lib/func.scad>
pr = 5;
ph= 20;

lh=3;
lw = 2;
lf = .3;

cr=2;
ch=1.5;

$fn=64;

module lock(){
    translate([5,0,lh])
    rotate([0,90,0])
    cylinder(h = 2, r1 = 2, r2 = 0, center = false);
}

module part(){
     cylinder(h = ph, r1 = pr, r2=pr, center = true);
}
/*
module join(){
    cd = pr*2;
    
    module a(){
     translate([pr - lh/2,0, ph/2])
     rotate([0,90,0])
     cylinder(h = lh, r1 = pr, r2=pr, center = true);
    }
    
    a();
}
*/
module join(lh=lh, lf=0){
    cd = pr*2;
    h = lh + lf;
    
    
    module a(){
     rotate([0,90,0])
     cylinder(h = h, r1 = pr, r2=pr, center = true);
     
     tr(z=pr/2)   
     cube([h,pr*2,pr], center=true);
    }
    
    module l(){
        tr(x=h/2 + ch/2)
        rotate([0,90,0])
          cylinder(h = ch + lf, r1 = cr, r2=cr * .8, center = true);
    }
        module sidecut(){
        difference(){
            children();
        difference(){
        cube([pr*2,pr*2,pr*2], center=true);
        cylinder(h = pr*2, r1 = pr, r2=pr, center = true);
        }
        
    }
    }
    
    sidecut()
    a();
    l();
    mirx() l();
     joinc();
    

    
   
    
}

module joinc(h=2*pr){
     module a(){
         difference(){
         tr(z=pr/2)   
     //cube([h,pr*2,pr], center=true);
             
    cylinder(h = pr, r1 = pr, r2=pr, center = true);
         
     rotate([0,90,0])
     cylinder(h = h, r1 = pr, r2=pr, center = true);
         }
     
     
    }
    trv([0,0,ph/2 - pr-h/2])
    a();
}


//#joinm();

function nodedz() =
    ph + lf;

module node(){

difference(){
    part();


    tr(z=ph/2-pr)
    join(lh, lf);

}

tr(z=-ph/2-pr)
join(lh, 0);
}

node();

tr(z=nodedz())
node();










//lock();