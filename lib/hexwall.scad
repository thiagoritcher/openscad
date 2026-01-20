include <lib/func.scad>

module hex_single(
b2 = 4,
t2 = 3,
h = 3
) 
{
  polygon([
    [-b2, 0],
    [-t2, h],
    [t2, h],
    [b2, 0]]
  );
}

module hex_w(
b2 = 3,
t2 = 2,
h = 2,
w =.6 
)
{
  py = (h - w)/(h);
  px = (b2 - w)/(b2);

  difference(){
    hex_single(b2, t2, h);
    hex_single(b2*px, t2*px, h*py);
  }
}


function hex_w_size(
b2 = 3,
t2 = 2,
h = 2,
w =.6 
) = b2 * 2 - w;


module dhex_wall(
b2 = 3,
t2 = 2,
h2 = 2,
w =.6 
){
  hex_w(b2, t2, h2, w);

  rot(z=-180)
  tr(x= hex_w_size(b2, t2, h2, w))
  hex_w(b2, t2, h2, w);
}

function dhex_wall_size(
b2 = 3,
t2 = 2,
h2 = 2,
w =.6 
) = hex_w_size(b2, t2, h2, w) *2;


linear_extrude(100){

dhex_wall();
tr(x=dhex_wall_size())
dhex_wall();

  }
