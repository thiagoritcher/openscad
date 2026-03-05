include <lib/func.scad>
include <lib/lin.scad>

function texform(x, y, w) = 
    [[0, y], [0, y+w], [x+w, 0], [x, 0]];
    
module textura(n, x=3, y=3, w=1.2){
    for(i = [0:n]){
        polygon(texform(i*x,i*y,w));
    }
}

module textura_diamante(n, x=3, y=3, w=1.2){
//mir4()
textura(n, x, y, w);
}

//textura_diamante(9);