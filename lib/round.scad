/*
Example: 

v = [120, 100, 5];
vb = [10, 10, -1];
vz = [0, 0, -1];

round4corner(v, 10, 5)
round4inner(v-vb+vz, 8, 5)
difference() {
    cube(v, true);
    cube(v - vb, true);
}
*/

module roundblock(r, h, t, m=[0,0,0]){
    mirror(m)
    translate(t - [r, r, h/2])
    linear_extrude(h, center=true)
    difference(){
        square(r+.001, false);
        circle(r);
    }
}

/**
rounds a single corner
r = radius
h = height;
t = translate vector
m = mirror vector
*/
module roundcorner(r, h, t, m=[0,0,0]){
    difference(){
        children();
        roundblock(r, h, t, m);
    }
}

/**
rounds a single inner corner
r = radius
h = height;
t = translate vector
m = mirror vector
*/
module roundinner(r, h, t, m=[0,0,0]){
     union(){
        children();
        roundblock(r, h, t, m);
    }
}

/**
rounds 4 corners
r = radius
h = height;
t = translate vector
m = mirror vector
*/
module round4corner(vsize, radius, height){
    v = vsize/2;
    roundcorner(radius, height, v) 
    roundcorner(radius, height, v, [1,0,0]) 
    roundcorner(radius, height, v, [0,1,0]) 
    mirror([0,1,0]) roundcorner(radius, height+1, v, [1,0,0]) 
    children();
}

/**
rounds 4 inner corners
r = radius
h = height;
t = translate vector
m = mirror vector
*/
module round4inner(vsize, radius, height){
      v = vsize/2;
    roundinner(radius, height, v) 
    roundinner(radius, height, v, [1,0,0]) 
    roundinner(radius, height, v, [0,1,0]) 
    mirror([0,1,0]) roundinner(radius, height, v, [1,0,0]) 
    children();
}



