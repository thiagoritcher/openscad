//[base, top, height]
/*
bth = [8,10,3]; 
dovelock(bth, 3, 1, 1.3, 0);

*/

module dove(bth, size, ff=0 ){
    b = bth[0]/2;
    t = bth[1]/2;
    h = bth[2];
    
    linear_extrude(size, center= true)
    polygon([[-b-ff, 0], [-t-ff, h], [t+ff, h], [b +ff, 0]]);
}

module lock(bth, top, height, ff=0){
    dovebase = bth[0];
    dovetop = bth[1];
    doveheight = bth[2];
    
    ang = atan2(doveheight, (dovetop - dovebase)/2 );
    size = norm([(dovetop - dovebase)/2, doveheight]);
    
    bthl = [doveheight, top, height];
    translate([dovebase/2,0,0])
    difference(){
        rotate([0,-90, 180+ang])
        translate([0,0,size/2])
        dove(bthl, size, ff);
        
        translate([0,-3*bthl[1]/2,0])
        cube(bthl * 3, center=true);
    }
}

module dovelock(bth, size, top, height, ff){
    dove(bth, size, ff);
    lock(bth,top,height, ff);
    mirror([1,0,0])
    lock(bth,top,height, ff);
}




