file = "coelho2.dxf";
//file = "coelho1.dxf";

//tamanhos
base=20;
nome=.9;


translate([0,0,0])
color("White")
linear_extrude(base)
import(file, center = false, dpi = 96, layer="Camada 1");
