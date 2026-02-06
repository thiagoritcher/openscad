include <lib/func.scad>
include <lib/lin.scad>


module bottom_grid(
  vsize = [200,200,1.2], w=1.2, dx=10, dy=10, ang=45
){
  nx = (vsize.x)/ dx;
  ny = (vsize.y)/ dy;
  
  difference() {
    children();
    rot(z=ang)
    tr(x=-vsize.x/2, y= -vsize.y/2){
        
      linv(dir=vecx, n=nx, size=vsize.x, width=w, first=dx, last=dx)
      tr(y=-w/2)
      cube([w,vsize.y,1]);
      
      linv(dir=vecy, n=ny, size=vsize.y, width=w, first=dy, last=dy)
      tr(x=-w/2)
      cube([vsize.x,w,1]);
    }
  }
  
}

module bottom_grid_demo(){
bottom_grid()
cube([200,200,1]);
}
bottom_grid_demo();

