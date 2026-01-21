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
module linvs(dir=[0,0,1], n=2, spacing=0, width=0, first=0){
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
