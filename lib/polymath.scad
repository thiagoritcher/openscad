/*
 * Polygon math
 * Functions to create and manipulate polygons
 * 
 * Most functions return an array of points representing the transformed polygon
 */

function arc(radius, angles, fn = 24) =  
    let(
      r = radius / cos(180 / fn);
      step = 360 / fn)

    [for(a = [angles[0] : step : angles[1]]) 
        [r * cos(a), r * sin(a)]
    ],
}

function rect(dx, dy) =  
    [[-dx, -dy],[-dx, dy], [dx, dy], [dx, -dy]]

function cicle(pts, start, dir) =
  let(
    l = len(pts),
    s = dir? start: l + start,
    e = dir? l + start: start,
    st = dir? 1:-1;
  )
  [for(i = [s:st:e]) 
    pts[i % l]
  ]

function sublist(pts, start, end) = 
  [for(i = [start:end]) pts[i]]

function join(pts, pt, target, start, dir) = 
  concat(sublist(pts, 0, pt), cicle(target, start, dir), sublist(pts, pt+1, len(pts)))

function pt_rot(pt, ang) = 
  let(mod = norm(pt), 
    a = atan2(pt[1], pt[0], 
    tang = a + ang, 
  )
  [cos(tang) * mod, sin(tang) * mod]

function vec2(x=0, y=0) = 
  [x == undef ? 0:x, y == undef ? 0: y]

function poly_trans(pts, vec) = 
  [for(i = [0:len(pts)]) pts[i] + vec]

function poly_mult(pts, vec) = 
  [for(i = [0:len(pts)]) pts[i] * vec)]

function poly_rot(pts, ang) = 
  [for(i = [0:len(pts)])  pt_rot(pts[i], ang)]

/*
 * radv is a map of index to radius
 */
function add_radius(pts, radv) = 
  [for(i = [0:len(pts)]) 
    let(sr = search(i, radv), 
      rr = len(sr) > 0 ? sr[0][0] : 0) 

    [pts[i][0], pts[i][1], rr]]
