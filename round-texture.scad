r=4; 
module line(dx, e, int=.2){
    nx = dx / (2*r-1);
    module a(d, y=0){
        for(i = [0:nx]){
            translate([i * 2*r,y,0])
            circle(d+int);
        }
    }
    difference(){
        a(r, 0);
        a(r, e);
    }
    
}

module arc(va, ra, e, int=.2){
    ss = ((va[1] - va[0])/360)* 2*PI*ra;
    nx = ss/(2*r);
    da = (va[1] - va[0])/nx;
    
    module a(r, d){
        for(i = [0:nx]){
            translate([
            (ra -d) * sin(va[0] + i *da) ,
            (ra -d) * cos(va[0] + i *da) ,0])
            circle(r+int);
        }
    }
    difference(){
        a(r, 0);
        a(e*2, e);
    }
}

