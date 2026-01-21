//flat(4);
//center_pattern(1, 4);

center(4);

//build();

//box
bx=110;
by=150;
bh=60;

be=2.5; //espessura
bm=4; //margem
bb=bm+be; //margem

ce=2; //espessura centro


//number of doves
nx=5;
ny=5;
nh=3;

//Afastamento lateral
bmarg = 20; //xy
bmargh = 16; //z

//dove
db=5; //base
dt=6.5; //topo
dh=be; //height
dsup=4;

//lock
lh=be; //height
lp=1.2; //profundidade
ls=.4; //slack
la=.2; //topo


//dovebase
dbb=20; //base
dbt=20; //topo
dbh=dh; //height
dbd=3.6;



//variaveis
bx2 = bx/2;
by2 = by/2;
bh2 = bh/2;
ang = atan2(dh, (dt-db)/2);
lss = sqrt(pow(dh,2) + pow((dt-db)/2, 2));



AA=.01;

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
    /*
    mirrorh()
    translate([bx2,0,0])
    rotate([0,0,90])
    dovebase();
    */
    
    
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
    /*
    mirrorx()
    translate([0,-by2,0])
    dovebase();
    
    mirrory()
    translate([bx2,0,0])
    rotate([0,0,90])
    dovebase();
    */
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
    bx = 2*bb;
    
    translate([0,0,v[2]*1/2])
    cube(v + [-b, -bx, +AA], center=true);
}


module dovesup(){
    difference(){
        translate([0,lh,0])
        rotate([90,0,0])
        dove(0);
    
        translate([0,lh/2,-db/2])
        cube([db*2, lh, db], center=true);
    }
    
    
    /*
    translate([0,0,0])
    rotate([90,0,-90])
    linear_extrude(db, center=true)
    polygon([[0,0], [0, dh], [dsup, 0]]);
    */
}



module dove(ff){
    
            dovef();
            lockf(ff);
            mirror([1,0,0]) lockf(ff);
        
        
    
    
}



module dovebase(){
    b = dbb/2;
    c = dbt/2;
    dh = dbh;
    difference(){
        
        translate([0,dbd,0])
        rotate([90,0,0])
        linear_extrude(dbd)
        polygon([[-b,0], [-c, dh], [c, dh], [b, 0]]);
        
        dove(ls);
    }
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
    translate([0, -by2-bh2 - ma,be]) 
    rotate([0,180,0])
    children();
}
module flat_s2(ma){
    translate([bx2 + bh2 + ma, 0,be])
    rotate([0,180,90])
    children();
}

module flat(ma=10) {
    
    base();
    flat_s1(ma) 
      side1();
    flat_s2(ma) 
      side2();
    
}



module build() {
    base();
    
    translate([0, -by/2,bh2+dh])
    rotate([-90,0,0])
    side1();
    
    translate([bx2, 0,bh2+dh])
    rotate([-90,0,90])
    side2();
}

module center(ma) {
    center_form([bx, by, ce], bb, bb);
    flat_s1(ma) center_form([bx, bh, ce], bb, bm);
    flat_s2(ma) center_form([by-2*dh, bh, ce], bm, bm);
}

module center_pattern(file, ma) {
    pos = [0,-100,-50];
  
    texture(file,pos, 100) 
      center_form([bx, by, ce], bb, bb);
  
    flat_s1(ma)
      texture(file,pos, 100) 
      center_form([bx, bh, ce], bb, bm);
  
    texture(file,pos, 100) 
      flat_s2(ma) 
      center_form([by-2*dh, bh, ce], bm, bm);
}

module texture(t, pos, e){
  difference(){
    children();
    translate(pos)
      
    linear_extrude(e)
      import(file = str("lib/patterns/", t, ".dxf"));
  }
}




;

