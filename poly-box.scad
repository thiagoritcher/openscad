include <lib/polymath.scad>

caixa();
//tampa();
//divs();



/* [Dimensoes] */

//altura
hh=90;

//num curva
nr = 14;

//num x
nl = 1;

//num y
nw = 8;



/* [Espessuras caixa] */
//esp. parede
ew = 1.2;

//esp. base;
eb = 1.2;



/* [Tampa] */
//esp. tampa
et = .9;

//tampa trava
tl = +0;

//tampa folga
tf = ew + .4;

//tampa esp externa
tr = 1.5;



/* [Divisorias] */
//esp divisoria
dw = 2;

//div quantidade x
dnx = 4;
//div quantidade y
dny = 2;


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

module di(){
  s = sizey() / dnx;
  dih = hh - tl - et;
  
  if(dnx > 1)
  for(i = [1:dnx - 1])
  translate([0,sizey()/2 - i*s,dih/2])
  cube([sizex()+ 2*f.y,dw,dih], center=true);
    

  sy = sizex() / dny;

  if(dny > 1)
  for(i = [1:dny - 1])
  translate([sizex()/2 - i*sy,0,dih/2])
  cube([dw, sizey() + 2*f.y,dih], center=true);
}

intersection(){
  di();
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
        offset(-f.y - ew) 
        polygon(sq(formb(f.x, f.y), f));    
        
      }
  }
}

