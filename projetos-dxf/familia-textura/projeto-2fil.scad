include <lib/func.scad>

pai = "pai.dxf";
mae= "mae.dxf";
//filp= "filho-p.dxf";
film= "filho-m.dxf";
filg= "filho-g.dxf";


//tamanhos
base=6;
nome=.9;

module w(file, n=4, t, r=[20,20]){
render()
union(){
rotate(t)
square([n+1.2, r.y]);
  
rotate(t)
square([r.x, n+1.2]);
  
translate([-1,0,0])
offset(-n)
import(file, center = false);
}
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

module corpo(file,n, wn, t, r){
union(){
aa = 360/n; 
wr(n, aa, aa) a(file);
rotate([0,0,aa-1])
rotate_extrude() w(file, wn, t, r);
}
}

module corpoc(file){

rotate_extrude() 
  a(file);    
}


module base_corpo(r){
  cylinder(r=r, h=1);
}

trmae = [10, 33, 0];
npai = 72;
nmae = 64;
nfilg = 40;
nfilm = 32;


//trfilp= [40, 32, 0];
trfilm= [33, 25, 0];
trfilg= [25, 13, 0];
//trv(tr1)
//corpoc(file2);


//w(pai,[0,180,0], [11, 140]);
//w(mae,[0,0,0], [14.5, 130]);
//w(film,3.5,vec(y=180), [5, 70]);
//w(filg,3.5, vec(y=180), [6.5, 85]);

module pai(){
  tr(z=140) sphere(r=10);
base_corpo(13);
difference(){
  corpo(pai, npai,4, vec(y=180),[11, 140]);
  trv(trmae) corpoc(mae);
  trv(trfilg) corpoc(filg);
  
}
}

module mae(){
  trv(trmae) tr(z=130) sphere(r=10);
  trv(trmae)base_corpo(18);
difference(){
trv(trmae)corpo(mae,nmae, 4, vec(y=0),[14.5, 130]);
trv(trfilg) corpoc(filg);
trv(trfilm) corpoc(film);
}
}

module filg(){
  trv(trfilg) tr(z=84.2) sphere(r=6);
trv(trfilg) base_corpo(8);
  difference(){
trv(trfilg) corpo(filg, nfilg,3,  vec(y=180), [6.5, 85]);
trv(trfilm) corpoc(film);  
  }
}


module film(){
  trv(trfilm) tr(z=71) sphere(r=5);
  trv(trfilm) base_corpo(6);
  trv(trfilm) corpo(film, nfilm, 3, vec(y=180), [5, 70]);  
}
//trv(trfilp) corpo(filp, nfil);

pai();
//mae();
//filg();
//film();


