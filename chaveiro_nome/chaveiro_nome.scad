file = "julia.dxf";

//tamanhos
base=2;
nome=.9;


translate([0,0,base])
color("Pink")
linear_extrude(nome)
import(file, center = false, dpi = 96, layer="Layer 1");

color("White")
linear_extrude(base) {
    
import(file, center = false, dpi = 96, layer="Camada 2");
import(file, center = false, dpi = 96, layer="Layer 2");
}