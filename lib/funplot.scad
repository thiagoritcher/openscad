module pltsin(angles, radius){
    points = [
        for(a = [angles[0]:1:angles[1]]) [a, radius * sin(a)]
    ];
        
    polygon(concat(points));
}
//pltsin([-180,180], 100);

module pltcos(angles, radius){
    points = [
        for(a = [angles[0]:1:angles[1]]) [a, radius * cos(a)]
    ];
        
    polygon(concat([[0,-radius]],points));
}

module pltsq(angles, radius){
    points = [
        for(a = [angles[0]:1:angles[1]]) [a*radius, a*a]
    ];
        
    polygon(concat([[0,-radius]],points, [[0,180*180]]));
}

module funplot_demo(){
  translate([0,60,0])
  pltsq([0,180], 60);
}
