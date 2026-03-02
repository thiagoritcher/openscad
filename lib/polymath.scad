/*
 * Polygon math
 * Functions to create and manipulate polygons
 * 
 * Most functions return an array of points representing the transformed polygon
 */

function poly_arc(radius, angles, fn = 24) =  
    let(
      r = radius / cos(180 / fn),
      step = 360 / fn)

    [for(a = [angles[0] : step : angles[1]]) 
        [r * cos(a), r * sin(a)]
    ];

function poly_rect(dx, dy) =  
    [[-dx, -dy],[-dx, dy], [dx, dy], [dx, -dy]];

function poly_cicle(pts, start, dir) =
  let(
    l = len(pts) ,
    s = dir == 1? start: l + start,
    e = dir == 1? l + start: start,
    st =dir == 1? 1:-1
  )
  [for(i = [s:st:e - dir]) 
    pts[i % l]
  ];

function reverse(lst) =
  [for (i = [len(lst)-1:-1:0])
      lst[i]];

function sublist(pts, start, end) = 
  start >= end ? [] :
  [for(i = [start:end - 1]) pts[i]];
    

function reverse(pts) = 
  [for (i = [len(pts) - 1: -1: 0]) pts[i]];


/**
 * Join two polygons by joining vertices
 *
 * pts: the first polygon
 * pt: the index of the last vertex of the first polygon
 * target: the second polygon
 * start: the index of the first vertex of the second polygon
 * dir: the direction of the second polygon
 *
 * for 2 rectangles created with poly_rect
 * to join them on the outside use dir = 1 and start = 
 *  3 left, 0 top, 1 right, 2 bottom
 * to join them on the inside (cut) use dir = -1 and start = 
 *  0 left, 1 top, 2 right, 3 bottom
 *

    p = poly_rect(10, 20);
    b = poly_rect(1, 2);

    //union
      //left
   //c = poly_join(p, 1, poly_trans(b, [-10-1,0]), 3, 1);
      //top
   // c = poly_join(p, 2, poly_trans(b, [0,20+2]), 0, 1);
      //right
   // c = poly_join(p, 3, poly_trans(b, [11,0]), 1, 1);
      //bottom
    //c = poly_join(p, 4, poly_trans(b, [0,-22]), 2, 1);

    //cut
      //left
    //c = poly_join(p, 1, poly_trans(b, [-10+1,0]), 0, -1);
      //top
    //c = poly_join(p, 2, poly_trans(b, [0,20-2]), 1, -1);
      //right
    // c = poly_join(p, 3, poly_trans(b, [10 - 1,0]), 2, -1);
      //bottom
    // c = poly_join(p, 4, poly_trans(b, [0,-20 +2]), 3,-1);
    polygon(c);
 */
function poly_join(pts, pt, target, start, dir) = 
  concat(sublist(pts, 0, pt), poly_cicle(target, start, dir), sublist(pts, pt, len(pts)));

function poly_pt_rot(pt, ang) = 
  let(
    mod = norm(pt), 
    a = atan2(pt[1], pt[0]), 
    tang = a + ang
  )
  [cos(tang) * mod, sin(tang) * mod];

function vec2(x=0, y=0) = 
  [x == undef ? 0:x, y == undef ? 0: y];

function poly_trans(pts, vec) = 
  [for(i = [0:len(pts) - 1]) pts[i] + vec];

function poly_mult(pts, vec) = 
  [for(i = [0:len(pts) - 1]) [pts[i].x * vec.x, pts[i].y * vec.y]];

function poly_rot(pts, ang) = 
  [for(i = [0:len(pts) - 1])  poly_pt_rot(pts[i], ang)];

/*
 * radv is a map of index to radius
 */
function poly_add_radius(pts, radv) = 
  [for(i = [0:len(pts) - 1]) 
    let(
      sr = search(i, radv), 
      rr = len(sr) > 0 ? radv[sr[0]][1] : 0,
      v = echo(sr)
    )
    [pts[i][0], pts[i][1], rr]];
