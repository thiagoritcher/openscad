include <lib/polymath.scad>

f = [2.5,2.5];
nr = 15;
nl = 10;

function form(f) =
    [[-f.x, 0], [0, f.y]];

function line(n, f) =
    n == 0 ? []:
    concat(
        line(n-1, f),
        poly_trans(
        form(f), [n*f.x*2, 0]));
        
function arc(n, ang, r, f) =
    n == -1 ? []:
    concat(
        arc(n-1,ang, r, f),
        poly_rot(
            poly_trans(
                form(f), 
                [r, 0]),
            (n)*ang));



function radius(n, f) =
    2*n*(f.x*2)/PI;
    
    
a = arc(nr,90/nr, radius(nr, f), f);

l = 
poly_trans(
    line(10, f),
    [-f.x,radius(nr,f)-f.y]
    );
    

    
da = 
poly_trans(
    concat(
        reverse(a),
        poly_mult(a, [1,-1])), [f.x*nl*2, 0]);
            
res = 
    concat(l,da);



echo(res); 
polygon(res);
