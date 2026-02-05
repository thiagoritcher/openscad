include <lib/arc.scad>

caixa();
//tampa();

r = 58.91;
w=2.5;
h = 2.5;
n = 12;

//hs = 0.9;
hs = 1.4;

nd = w*n;

hh = 50;
bh = 1.2;

ts = 0;

module a(r, d = 0) {

ang = 90;
aa = (360*w*2)/(2*PI*r);
na = ang / aa;

for(i = [0:na]) {
  iaa = i * aa;
  ad = aa/2;
  rd = r - d;

polygon([[0,0],
[rd*cos(iaa - ad), rd*sin(iaa - ad)],
[(rd + h) *cos(i * aa), (rd + h)*sin(i * aa)],
[rd*cos(iaa + ad), rd*sin(iaa + ad)]]
);
}
}

module b(r, n){
  translate([w,0,0])
 for(i = [0:n]) {
   dx = i * w*2;
polygon([[dx-w,0],
[dx-w, r],
[dx, r + h],
[dx+w, r],
[dx + w*2,0]]
);
} 
}

module m4(){
    children();
    mirror([0,1,0])
    children();
    
    mirror([1,0,0]) {
      children();
      mirror([0,1,0])
      children();
    }
    
}


module wall(r, hs){
difference(){
m4(){
b(r, n);
translate([n*w*2,0,0])
a(r);
}

m4(){
b(r-hs, n);
translate([n*w*2,0,0])
a(r, hs);
}
}
}

module caixa() {

linear_extrude(hh)
wall(r, hs);
/*
translate([0,0,hh - 6])
#linear_extrude(2)
wall(r, 3);
*/

linear_extrude(bh)
m4(){
b(r, n);
translate([n*w*2,0,0])
a(r, hs);
}
}


module tampa(){


h = 10;
difference(){
union(){
translate([0,0,hh-bh*2])
linear_extrude(bh*2)
tp(ts);

translate([0,0,hh])
linear_extrude(bh)
tp(-4);
}

union(){
translate([0,0,hh-bh*2])
linear_extrude(3*bh -1)
tp(ts + 2);

translate([0,0,hh+bh])
cube([60,7,h], center=true);
}
}

}



module tp(ts){
m4(){
tb(r-ts, n);
translate([n*w*2 - ts/2,0,0])
ta(r-ts);
}
}

module ta(r){
    sector(r, [0,90], fn=48);
}

module tb(r, n){
    square([r + w, r]);
}

