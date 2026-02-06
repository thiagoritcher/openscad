//put n children along dir dividing size in equal spacing 
//leaving first as space before and last as space after
module linv(dir=[1,0,0], n=2, size=10, width=1, first=0, last=0){
  vfirst = dir * first + dir*width/2;
  n1 = n-1;
  dx = (size - (first + last + width)) / n1;

  translate(vfirst)
  for(i = [0:n1]){
    translate(dir * i * dx)
      children();
  }
}

//put n children along dir leaving spacing between each and
//leaving first as space before 
module linvs(dir=[1,0,0], n=2, spacing=0, width=0, first=0){
  vfirst = dir * first + dir*width/2;
  n1 = n-1;
  dx = spacing + width;

  translate(vfirst)
  for(i = [0:n1]){
    translate(dir * i * dx)
      children();
  }
}

function linsv_size(n=2, spacing=0, width=0, first=0) = 
  first + n * width + (n -1) * spacing;

module lin_demo(){

  cylinder(r=.1, h=1);
  translate([10,0,0])
  cylinder(r=.1, h=1);

  linv(n=5, size=10)
    cube([1,1,1], center=true);
}

module linrot(angs=[0,90], axis=[0,0,1], n=5, radius=50){
  ang = (angs[1] - angs[0])/n;
  for(i = [0:n]){
    translate([      
      radius * cos(i * ang + angs[0]),
      radius * sin(i * ang + angs[0]),
      0])
    rotate(axis * (i * ang + angs[0]))
    children();
  }
}

function nw_radius(n, w, ang=90) = 
    sqrt( (w ^2) / (2 * (1 - cos(ang / n))));

