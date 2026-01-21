
include <lib/func.scad>
include <lib/arc.scad>

module arcd(
  r = 4, //radius
  ra = 2, //second radius
  w = 1, //width
  fn=12 //number of points
){
  arc(r, [0,180], w,fn);
  tr(x=ra+r + w)
  arc(ra, [180,360], w, fn);
}

function arcd_size(
  r = 4, //radius
  ra = 2, //second radius
  w = 1, //width
  fn=12 //number of points
) = ra*2+r*2 + w*2;

module arcd_demo(){
  arcd();
  tr(x=arcd_size())
  arcd();
}





