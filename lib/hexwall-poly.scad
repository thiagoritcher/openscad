include <lib/polymath.scad>

base = 12;
top = 8;
hh = 4;
nn = 20;

function hex_pt(base, top, hh) =
    [[-base/2, 0], [-top/2, hh], [top/2, hh], [base/2, 0]];


function linpts(n, pts, w) =
    n == 0 ? [] :
    concat (
        linpts(n - 1, pts, w),
        poly_trans(pts,  [(n -1) * w, 0, 0]));

module wallp(){
polygon(
    concat(
    [[-base/2, -10]],
    linpts(nn, hex_pt(base, top, hh), base+top),
    [[(base + top) *(nn-1) + base/2, -10]]
    ));

}

module wall(ee) {
difference(){
    difference(){
        wallp();
        offset(-ee, $fn=24)
        wallp();
    }
    translate([-base/2,-10 - ee,0])
    square([(base + top) *(nn)-base/2,10]);
}
}

module hexwall_poly_demo() {
linear_extrude(20)
wall(1.4);
}

hexwall_poly_demo();