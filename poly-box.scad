include <lib/polymath.scad>

//union(){ 
//  caixa(); 
//  divs();
//}
tampa();




/* [Dimensoes] */

//altura
hh=40;

//num curva
nr = 10;

//num x
nl = 4;

//num y
nw = 6;

esph = 1.2;
//esph = 0.8;


/* [Espessuras caixa] */
//esp. parede

//ew = 0.8;
ew = esph;

//esp. base;
eb = .8;



/* [Tampa] */
//esp. tampa
et = .8;

//tampa trava
tl = 8+0;

//tampa folga
tf = ew + .4;

//tampa esp externa
tr = 2.4;



/* [Divisorias] */
//esp divisoria
dw = esph;

//div quantidade x
dnx = 2;
//div quantidade y
dny = 2;

//div habilita x
dex = [
  [0, 1, 1],
  [1, 1, 1]
];

//div habilita y
dey = [
  [1],
  [1]
];


/* [Forma parede] */
//forma
f = [2.5, 2.5];




function radius(ang, n, w) = 
  (n * w * 360) / (ang * 2 * PI);

r = radius(90, nr, f.x*2);
  
function forma(x, y) =
  [[-x, 0], [0, y]];
  
function formb(x, y) =
  [[-x, y], [0, y]];


function arc(form, f, n, r, ang) = 
  n == 0 ? []:
  concat(
    arc(form, f, n - 1, r, ang),
    poly_rot(
      poly_trans(
        form, 
        [-f.x, r]), 
      -ang * (n )));
    
    
function line(form, f, n) = 
  n == 0 ? []:
  concat(
    line(form, f, n-1), 
    poly_trans(
      form, 
      [(n)*f.x*2 -f.x, 0]));



function round(form, f) =
let(
  res = arc(form, f, nr , r, 90/nr),
  res2 = poly_mult(res, [1,-1]),
    
  l1 = poly_trans(
          line(form, f, nl),
            ,[0, r]),
            
  l2 = reverse(poly_mult(l1, [1, -1])),

  a = poly_trans(
        concat(res,[[r, 0]], reverse(res2)),
        [nl * f.x*2, 0]),
        

        
  s1 = concat(l1, a, l2),
  s2 = reverse(poly_mult(s1, [-1, 1])))
concat(s1, s2);

//polygon(round());


function sq(form, f) =
let(

  a1 = 
    poly_trans(
      arc(form, f, nr , r, 90/nr),
      [nl * f.x*2, nw * f.x*2 - f.x]),
  
  a2 = poly_mult(reverse(a1), [1,-1]),
  
  lw = 
    reverse(
    poly_trans(
      poly_rot(
      line(form, f, nw),-90),
      [nl * f.x*2 + r,-f.x*2 +f.x])),
   
  lwm = poly_mult(reverse(lw), [1,-1]),
  
  l1 = poly_trans(
          line(form, f, nl),
            ,[0, r + nw*f.x*2 - f.x]),
            
  l2 = reverse(poly_mult(l1, [1, -1])),
  
  ma =concat(
    l1, 
    a1, 
    lw),
   
  mb = concat(
    lwm,
    a2, 
    l2),
    
  s = concat(ma, [[r+nl * f.x*2 + f.y, 0]], mb),
        
  sm = reverse(poly_mult(s, [-1, 1])))
//concat(mb);  
concat(s, sm);

function sizex() = 
  2*((f.x*2) * nl + r);
  
function sizey() = 
  2*((f.x*2) * nw - f.y + r);


module divs(){

module dc(){
  dih = (hh - tl - et);
  s = sizey() / dnx;
  
  sx = sizex()+ 2*f.y;
  
  if(dnx > 1)
    for(i = [1:dnx - 1])
      if(dex[0][i-1] == 1)
      translate([0, sizey()/2 - i*s -dw/2,0])
      cube([sx / 2,dw,dih], center=false);
    
  if(dnx > 1)  
    for(i = [1:dnx - 1])
      if(dex[1][i-1] == 1)
      mirror([1,0,0])
      translate([0, sizey()/2 - i*s -dw/2,0])
      cube([sx / 2,dw,dih], center=false);
    
    sy = sizex() / dny;

  ssy = sizey() + 2*f.y;
    
  if(dny > 1)
  for(i = [1:dny - 1])
    if(dey[0][i-1] == 1)
    translate([sizex()/2 - i*sy - dw/2,0,0])
    
    cube([dw, ssy/2,dih], center=false);
  
  if(dny > 1)
  for(i = [1:dny - 1])
    if(dey[1][i-1] == 1)
    mirror([0,1,0])
    translate([sizex()/2 - i*sy - dw/2,0,0])
    cube([dw, ssy/2,dih], center=false);
  
}




intersection(){
 dc();
  caixa_interior();
}
  
}


  

  




module caixa(){
  difference(){
  linear_extrude(hh) 
    polygon(sq(forma(f.x, f.y), f));
    
  caixa_interior();
  }
}

module caixa_interior(){
  translate([0,0,eb])
  linear_extrude(hh) 
    offset(-ew, $fn=12)
    polygon(sq(forma(f.x, f.y), f));
}



//#polygon(sq(forma(f.x, f.y), f));




module tampa(){
  translate([0,0,hh+et+tr])
  mirror([0,0,0])
  t();

  module t(){
    linear_extrude(et) 
      polygon(sq(formb(f.x, f.y), f));
    
    //lock
    translate([0,0,et])
    linear_extrude(et+ tl)
      difference(){
      offset(-f.y - tf) 
        polygon(sq(formb(f.x, f.y), f));
      offset(-f.y - tf - ew) 
          polygon(sq(formb(f.x, f.y), f));
      }
      
      //ring
    linear_extrude(et + tr) 
      difference(){
        polygon(sq(formb(f.x, f.y), f));
        offset(-ew ) 
        polygon(sq(formb(f.x, f.y), f));    
        
      }
  }
}

