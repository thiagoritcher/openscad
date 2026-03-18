include <lib/func.scad>
include <lib/polyround.scad>
include <lib/textura_diamante.scad>

bw=26;

sw = 14;
see=2.8;


module base(h=20, w=bw, r=5, ee=2){
    mir2()
    linear_extrude(ee, center=true)
    polygon([[0,0],[0,h],[w-r, h], [w, h-r], [w, 0]]);
}

module suporte(w=sw, h=20, r=5, r1=5, ee=see){
    //radiiPoints = [[0,0,0], [h-r, 0 ,0], [h, r,0]];
    radiiPoints=[
        [0,  r,  0],
        [r,  0,  2],
        [h - r1, .01 ,  1     ],
        [h,  r1,  1],
        //[15, 10, r2    ],
        //[17, 2,  rEnd  ]
    ];

    translate([0,ee/2,0])
    linear_extrude(w, center=true){
        polygon(polyRound(beamChain(radiiPoints,offset1=ee/2, offset2=-ee/2),20));
    }
    
    linear_extrude(w, center=true)
    polygon([[0,0], [0,r+ee], [r+ee,0]]);
    
}

module pos_suporte(w=bw, w2=sw){
    translate([w-w2/2,0,0])
    rotate([0,-90,0])
    children();
}




module suporte_textura(){

mir2()
intersection(){

translate([0,-.5,0])
pos_suporte()
suporte(ee=3);




rotate([90,0,0])
linear_extrude(20, center=true)
#textura_diamante(15, x=9, y=9);
}

}

module base_textura(){
intersection(){
translate([0,0,1]) {
linear_extrude(2)
mir2()
textura_diamante(15);
}

translate([0,0,1.5])
base(ee=1);
}
}

base(ee=2);
base_textura();

mir2()
pos_suporte()
suporte(ee=2);

//suporte_textura();