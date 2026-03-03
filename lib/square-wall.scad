include <lib/polymath.scad>

function form(w, h) =
    [[-w, 0], [-w, h], [w, h], [w, 0]];


function lp(frm, n, w) =
    n == -1 ? []:
        concat(
            lp(frm, n-1, w),
            poly_trans(frm, [w * n,0,0])
            );

module p(n, w, h){
    polygon(
        concat(
        [[-w,-5]],
        lp(form(w, h), n, 4*w),
        [[4*w*n + w,-5]]
        )
    );
}

module w(){
    ee = .8;
    n= 4; 
    w = 5; 
    h = 3;
    
    difference(){
        p(n, w, h);

        union(){
        offset(-ee, $fn=24)
        p(n, w, h);
        
        translate([-w,-10 - ee,0])
            square([4*w*n + w*2,10]);
        }
    }
}
linear_extrude(100)
w();