include <lib/func.scad>
include <lib/lin.scad>

e = .3;
w1 = .5;
w2 = .5;

h = 1.2;

hh = 60;
bh = 1.2;
 

y2 = e;
y1 = y2 + e;

spacing = 2*(w1 + w2 + e) - .07;


x = [w1, w1 + e, w1 + w2 + e];
y = [e, h, e+h];

module form(){
    polygon(
    [
    [0,y[1]],
    [x[0],y[1]],
    [x[0],0],
    [x[2],0],
    [x[2],y[0]],
    [x[1],y[0]],
    [x[1],y[2]],
    [0,y[2]]]);
}

module rform(r){
    polygon(
    [
    [0,r+y[1]],
    [x[0],r+y[1]],
    [x[0],r+0],
    [x[2],r+0],
    [0,0]
    ]);
}

module bform(r){
    polygon(
    [
    [0,r+y[1]],
    [x[0],r+y[1]],
    [x[0],r+0],
    [x[2],r+0],
    [x[2],0],
    [0,0]
    ]);
}

module single(hh = hh){
    render()
        linear_extrude(hh)
        union(){
        mir(x=1)
        children();
        children();
    }
}



nr = 10;

ra = nw_radius(n = nr, w = spacing, ang=90);



nw = 15;


module wall(){
tr(y=ra)
linvs(spacing=spacing, n = nw)
single(hh) form();

linvs(spacing=spacing, n = nw)
single(bh)
bform(ra);
}


module curve(){
linrot(radius = ra, n=nr)
rotate([0,0,-90])
single() 
form();

mirx()
linrot(radius = 0, n=nr)
single(bh)
rform(ra);
}

mir4()
curve();


