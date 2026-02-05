include <lib/func.scad>
include <lib/lin.scad>

/**
Project : Caixa diamante
Description: Caixa que usa textura piramidal em formato de diamante
Author: Thiago Ritcher
*/


/* [Dimensoes] */
//controle vertical
hn = 3;
//controle raio
rn = 6;
//controle central
wn = 5;


/* [Forma da piramide] */
//dimensao x
tx = 4;
//dimensao y
ty = 8;
//profundidade
tz = 1.5;


/* [Espessuras] */
//parede
w = 0.9;
//fundo
bh = 1.2;




vec = [[-tx, 0], [0, ty], [tx, 0], [0, -ty]];
module form(){
  linear_extrude(tz, scale = 0)
  polygon(vec); 
}

module base(){
tr(z=-w)
linear_extrude(w)
polygon(vec);
}

module single(){
difference(){ 
union() {
  form();
  base();
}

tr(z=-w - 0.01)
form();
}
}

module swall(n=wn){
 size = n*tx*2;
 linvs(n=n, width=tx*2, dir=[1,0,0])
  children();
}

module dwall(){
    swall(wn)
    single();
  
    tr(y=ty, x=tx)
    swall(wn)
    single();
}

module wall(n){
    linvs(n=n, width=ty*2, dir=[0,1,0])
    dwall();
}


function radius(n, w) = 
  sqrt((w ^2)/ (2* (1 - cos(90/n))));



radi = radius(rn, 2*tx);
module rswall(){
rotvs(dir=[0, 1, 0], n=rn, radius=radi)
rotate([0,90,0])
children();
}

module rdwall(){
translate([0,ty,0])
rotate([0,90/(2*rn),0])
rswall() single();
rswall()single();
}

module rwall(n){
 linvs(n=n, width=ty*2, dir=[0,1,0])
    rdwall();
}

module mir4(){
  module mir2(){
    children();
    mirror([0,0,1])
    children();
  }
  
  mir2()
  children();
  
  mirror([1,0,0])
  mir2()
  children();
}

module ww(){

mir4()
translate([wn * tx * 2 ,0,0])
rwall(hn);

mir4()
translate([-tx,0,radi])
wall(hn);
}



module cww(){
cube([radi*2 + (wn * tx * 2) *2 + 2 * tz,
  ty * 2
  ,2* radi + 2*tz], center=true);
}



translate([0,-ty,0])
difference(){ 
ww();
union(){
cww();

translate([0,ty * (hn * 2 +1) ,0])
  cww();
}
}




module sbase(rr){
  r = rr -w;
  translate([-tx*2,bh,0])
  rotate([90,0,0])
  linear_extrude(bh)
  
polygon(
  [
  [0,0],
  [0, r],
  [tx, r + tz], 
  [2*tx, r],
  [2*tx, 0]]
);
}

module srbase(rad){
  a = 90/(2*rn);
  r = rad +w ;
  rotate([90,90,0])
  linear_extrude(bh)
  polygon([
  [0,0],
  [r*cos(-a), r*sin(-a)],
  [r - tz, 0],
  [r*cos(a), r*sin(a)]]);
}

mir4(){
swall(wn+1)
sbase(radi);

translate([wn*tx*2,bh,0])
rotvs(dir=[0, 1, 0], n=rn, radius=0)
srbase(-radi);
}






