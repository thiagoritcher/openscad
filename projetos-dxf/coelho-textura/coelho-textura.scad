include <lib/func.scad>

file = "desenho.dxf";
orelha = "orelha.stl";


//tamanhos
base=6;
nome=.9;

module w(){
render()
translate([-1,0,0])
offset(-1)
import(file, center = false);
}

module a(){
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

n = 60;
a = 360/n;
module corpo(){
union(){
wr(n, a, a) a();
rotate([0,0,a-1])
rotate_extrude() w();
}
}

module orelha(){
  mir2()
  import(orelha);
}


module cabeca_suporte(){
translate([0,0,66])
sphere(r=13);
}

module base_corpo(){
  cylinder(r=16, h=1);
}


orelha();
corpo();
base_corpo();
cabeca_suporte();