file = "desenho2.dxf";

//tamanhos
base=6;
nome=.9;

module w(){
render()
import(file, center = false, dpi = 96, layer="Camada 3");
}

module a(){
render()
import(file, center = false, dpi = 96, layer="Camada 2");
}

module wr(n, ang, angr){
    for(i = [0:1:n]){
    color("White")
    rotate([0,0,i * ang*2])
    rotate_extrude(angle=angr)
    children();
    }
}

n = 100;
a = 360/n;

union(){
wr(n, a, a) a();
rotate([0,0,a-1])
rotate_extrude() w();
}

