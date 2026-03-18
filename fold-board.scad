include <lib/polymath.scad>


nn=41;
dy = 270;



#translate([-6,0,0])
cube([6,nn*10/2,5]);


for(i = [1:(nn/2)]){
  linear_extrude(6.5)
  translate([-1,
    i > 9 ?
    6.5 + (i-1)*10 :
    8 + (i-1)*10
  ,0])
  rotate([0,0,90])
  scale(.5)
  text(str(i), "eurofurence:style=bold");
}

#translate([-6,-8,0])
cube([dy+6,8,5]);


for(i = [1:dy /10]){
  
translate([-.6 + i * 10,-5 ,0])
cube([1.2,5,6.5]);

linear_extrude(6.5)
translate([-3 + i * 10,
  i > 9 ?
  -8: -6
  ,0])
rotate([0,0,90])
scale(.5)
text(str(i), "eurofurence:style=bold");

}






function form(x=0, y1=1.2, y2=3) =
[[x,y2], [x+4,y2], [x+4,y1], [x+6,y1], [x+6, y2]];


function form_n(n=nn) =
    n == 0? []:
    concat(
      form_n(n-1),
      form(x = n*5));


module board() {
  rotate([90,0,90])
  linear_extrude(dy)
  polygon(concat(
    [[0,0]],
  poly_trans(form_n(), [-5,0]),
    [[nn*5 + 1,0]]
  ));
}


board();