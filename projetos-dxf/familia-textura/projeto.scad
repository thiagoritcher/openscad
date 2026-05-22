include <lib/func.scad>

pai = "pai.dxf";
mae= "mae.dxf";
filp= "filho-p.dxf";
film= "filho-m.dxf";
filg= "filho-g.dxf";


//tamanhos
base=6;
nome=.9;

module w(file){
render()
translate([-1,0,0])
offset(-4)
import(file, center = false);
}

module a(file){
render()
import(file, center = false, $fn=128);
}

module wr(n, ang, angr){
    for(i = [0:1:n]){
    color("White")
    rotate([0,0,i * ang*2])
    rotate_extrude(angle=angr)
    children();
    }
}

n = 54;
a = 360/n;

module corpo(file,n){
union(){
aa = 360/n; 
wr(n, aa, aa) a(file);
rotate([0,0,aa-1])
rotate_extrude() w(file);
}
}

module corpoc(file){

rotate_extrude() 
  a(file);    
}


module base_corpo(){
  cylinder(r=13, h=1);
}

trmae = [10, 33, 0];
npai = 54;
nmae = 54;
nfil = 40;


trfilp= [40, 32, 0];
trfilm= [33, 20, 0];
trfilg= [25, 8, 0];
//trv(tr1)
//corpoc(file2);


difference(){
  corpo(pai, npai);
  trv(trmae) corpoc(mae);
  trv(trmae) corpoc(mae);
}

trv(trmae)corpo(mae, nmae);
trv(trfilp) corpo(filp, nfil);
trv(trfilm) corpo(film, nfil);
trv(trfilg) corpo(filg, nfil);

#base_corpo();
