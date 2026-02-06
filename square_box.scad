include <lib/func.scad>
include <lib/lin.scad>

caixa();
tampa();

/* [Dimensoes] */

//altura parede
hh = 60;

//blocos raio
nr = 20;
//blocos x
nw = 10;
//blocos y
nv = 10;


/* [Tampa] */
aba = 1;

//Lock altura
lh = 3;
//Lock espessura
le = 2;
//Lock folga
//folga
lf = 0;

/* [Espessuras] */
//parede
e = .9;
//base
bh = .9;

/* [Geometria do padrao] */
w1 = .7;
w2 = .7;
h = 1.2;

//ajusta fechamento no raio
angfix = .20;


spacing = 2*(w1 + w2 + e) - angfix;


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

module tform(r){
    polygon(
    [
    [0,r+y[2]],
    [x[2],r+y[2]],
    [x[2],0],
    [0,0]
    ]);
}

module trform(r){
     polygon(
    [
    [0,r+y[2]],
    [x[2],r+y[2]],
    [0,0]
    ]);
}

module lform(f, ee){
     polygon(
    [
    [0,-f],
    [x[2],-f],
    [x[2],-f-ee],
    [0,-f-ee]
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




ra = nw_radius(n = nr, w = spacing, ang=90);
echo (ra);




module wall_tr(f=0, hh=hh){
tr(y=ra+spacing*(nv-1)+f)
linvs(spacing=spacing, n = nw)
single(hh)    
children();
}

module wall(nw){
wall_tr() form();

linvs(spacing=spacing, n = nw)
single(bh)
bform(ra+spacing*(nv-1));
}

module tamp(nw){
linvs(spacing=spacing, n = nw)
single(bh)
tform(ra+spacing*(nv-1)+aba);
}

module wallv_tr(f=0, hh=hh){
tr(x=ra+spacing*(nw-1)+f)
rotate([0,0,-90])
linvs(spacing=spacing, n = nv)
single(hh)
children();    
}

module wallv(nv){
wallv_tr()
 form();
    

linvs(spacing=spacing, n = nv, dir=[0,1,0])
rotate([0,0,90])
single(bh)
bform(ra+spacing*(nw-1));
}

module tampv(nv){
linvs(spacing=spacing, n = nv, dir=[0,1,0])
rotate([0,0,90])
single(bh)
tform(ra+spacing*(nw-1)+aba);
}


module curve_tr(f=0, hh=hh){
tr(x=spacing*(nw-1)+f, y=spacing*(nv-1)+f)
linrot(radius = ra, n=nr)
rotate([0,0,-90])
single(hh) 
children();    
}

module curve(){
curve_tr()
form();

mirx()
tr(x=-spacing*(nw-1), y=spacing*(nv-1))
linrot(radius = 0, n=nr)
single(bh)
rform(ra);
}

module tampc(){
mirx()
tr(x=-spacing*(nw-1), y=spacing*(nv-1))
linrot(radius = 0, n=nr + 1)
single(bh)
trform(ra + aba);    
}

module caixa(){
    mir4()
    wall(nw);

    mir4()
    wallv(nv);

    mir4()
    curve();


    echo("Tamanho da caixa:", x=2*spacing*(nw-1), y=2*spacing*(nv-1), z=hh);
}



module tampa(){
module base(){        
    mir4()
    tamp(nw);
        
    mir4()
    tampv(nv);
            
    mir4()
    tampc();
}


module lock(lf=lf, le=le, lh=lh){
    mir4()
    tr(z=-lh)
    wall_tr(hh=lh)
    lform(lf, le);
            
    mir4()
    tr(z=-lh)
    wallv_tr(hh=lh)
    lform(lf, le);

    mir4()
    tr(z=-lh)
    curve_tr(hh=lh)
    lform(lf, le);
}


    tr(z=hh+.1)
    union() {
        base();
        lock();
        lock(lf=-aba-le,le=1, lh=1);
        
    }
}


