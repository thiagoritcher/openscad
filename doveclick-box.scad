/**
Project 
Description
Author
*/

// what to show in 3d view
Show = "flat"; // [flat, center, build, flat&center]

/* [Flat option] */
spacing = 4; // [4:30]



  

/* [Box Size] */
//box
b = [110, 150, 40];
//espessura
be=2.5; 

/* [Centro] */
//espessura centro
ce=1.8; 
//borda centro
cb=0.0; 



/* [Margem] */

//margem
bm=4; 
//margem vertical
bb=bm+be; 


/* [Doves] */
//x doves
nx=5;
//y doves
ny=5;
//z doves
nh=3;

//afastamento lateral xy
bmarg = 20; //xy

//afastamento lateral z
bmargh = 16; //z

/* [Geometria Dove] */
db=5; //base
dt=6.5; //topo
dh=be; //height

/* [Geometria Lock] */

//height
lh=be; 
//profundidade
lp=1.2;
//folga
ls=.4; 
//topo
la=.2;


/* [Hidden] */ 
bx=b.x;
by=b.y;
bh=b.z;

bx2 = bx/2;
by2 = by/2;
bh2 = bh/2;
ang = atan2(dh, (dt-db)/2);
lss = sqrt(pow(dh,2) + pow((dt-db)/2, 2));





AA=.01;


if(Show == "flat") flat(spacing);
if(Show == "center") center(spacing);
if(Show == "build") build();
if(Show == "flat&center") 
{
  flat(spacing); center(spacing);
}

module side2(){
    base_form([by-2*dh, bh, be], bm, bm);
    
    mirrorh()
    translate([-by2+dh,0,0])
    rotate([0,0,90])
    dovesup();
    
    t = (by - bmarg) / (ny -1);
    n = (ny -1)/2;
    
    mirrorx_line(t, n, [1,0,0], [1,0,0]) 
    translate([0,bh2,0])
    rotate([0,0,0])
    dovesup();
   
}

module side1(){
    difference(){
        base_form([bx, bh, be], bb, bm);
        
        mirrorh()
        translate([bx2,0,0])
        rotate([0,0,90])
        dove(ls);
    }
    
    
    t = (bx - bmarg) / (nx -1);
    n = (nx -1)/2;
    mirrorx_line(t, n, [1,0,0], [1,0,0]) 
    translate([0,bh2,0])
    dovesup();
}

module base(){
    difference(){
        base_form([bx, by, be], bb, bb);
        
        mirrorx()
        translate([0,-by2,0])
        rotate([0,0,0])
        dove(ls);
        
        mirrory()
        translate([bx2,0,0])
        rotate([0,0,90])
        dove(ls);
    }
}

module mirrory(){
    t = (by - bmarg) / (ny -1);
    n = (ny -1)/2;
    
    mirrorx_line(t, n, [1,0,0],  [0,1,0]) children();
    mirror([0,1,0])
    mirrorx_line(t, n, [1,0,0],  [0,1,0]) children();
}

module mirrorh(){
    t = (bh - bmargh) / (nh -1);
    n = (nh -1)/2;
    
    mirrorx_line(t, n, [1,0,0],  [0,1,0]) children();
    mirror([0,1,0])
    mirrorx_line(t, n, [1,0,0],  [0,1,0]) children();
}

module mirrorx(){
    t = (bx - bmarg) / (nx -1);
    n = (nx -1)/2;
    
    mirrorx_line(t, n, [0,1,0], [1,0,0]) children();
    mirror([1,0,0])
    mirrorx_line(t, n, [0,1,0], [1,0,0]) children();
}

module mirrorx_line(t, n, v, tv){
    for(i = [0: n]){
        translate(i*t * tv)
        children();
        
        
        mirror(v)
        translate(i*t*tv)
        children();
    } 
}

module base_form(v, bm, bb){
    difference(){
        translate([0,0,v[2]*1/2])
        cube(v, center=true);
        
        center_form(v, bm, bb);
    }
}

module center_form(v, bm, bb){
    b = 2*bm;
    cbx = 2*bb;
    
    translate([0,0,v[2]*1/2])
    cube(v + [-b+cb, -cbx+cb, +AA], center=true);
}


module dovesup(){
    difference(){
        translate([0,lh,0])
        rotate([90,0,0])
        dove(0);
    
        translate([0,lh/2,-db/2])
        cube([db*2, lh, db], center=true);
    }
}



module dove(ff){
    
            dovef();
            lockf(ff);
            mirror([1,0,0]) lockf(ff);
        
        
    
    
}



module lockf(ff){
    b = lh/2;
    c = la/2;
    dh=lp;
    
    translate([db/2,0,b])
    rotate([0,-90,ang+180])
    linear_extrude(lss)
    polygon([[-b-ff,0], [-c-ff, dh+ff], [c+ff, dh+ff], [b+ff, 0]]);
}

module dovef(){
    b = db/2;
    c = dt/2;
    linear_extrude(lh)
    polygon([[-b,0], [-c, dh], [c, dh], [b, 0]]);
}


module flat_s1(ma){
    translate([0, -by2-bh2 - ma,0]) 
    children();
}
module flat_s2(ma){
    translate([bx2 + bh2 + ma, 0,0])
    rotate([0,0,90])
    children();
}

module flat(ma=10) {
    
    base();
    
    module s1(){
      flat_s1(ma) side1();
    }
    
    s1(); mirror([0,1,0]) s1();
    
    module s2(){
      flat_s2(ma) side2();
    }
    s2(); mirror([1,0,0]) s2();
    
}



module build() {
    base();
    center_form([bx, by, ce], bb, bb);
    
    module bs1(){
      translate([0, -by/2,bh2+dh])
      rotate([-90,0,0])
      {
        side1();
        center_s1(0);
      }
    }
    
    module bs2(){
      translate([bx2, 0,bh2+dh])
      rotate([-90,0,90])
      {
        side2();
        center_s2(0);
      }
    }
    
    bs1(); mirror([0,1,0]) bs1();
    bs2(); mirror([1,0,0]) bs2();
}

module center_s1(ma){
   center_form([bx, bh, ce], bb, bm);
}

module center_s2(ma){
   center_form([by-2*dh, bh, ce], bm, bm);
}

module center(ma) {
    center_form([bx, by, ce], bb, bb);
    
    
   flat_s1(ma) center_s1(ma);
    mirror([0,1,0]) flat_s1(ma) center_s1(ma);
    
  
    flat_s2(ma) center_s2(ma);
    mirror([1,0,0]) flat_s2(ma) center_s2(ma);
}

