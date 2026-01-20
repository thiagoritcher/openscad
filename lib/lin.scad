module linv(dir=[0,0,1], n=2, size=0, width=0, first=0, last=0){
  vfirst = dir * first + dir*width/2;
  n1 = n-1;
  dx = (size - (first + last + width)) / n1;

  translate(vfirst)
  for(i = [0:n1]){
    translate(dir * i * dx)
      children();
  }
}
