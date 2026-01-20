include <round-texture.scad>

module wall(){
    s = 50;
    
    module a(){
        rotate([0,0,90])
        translate([0,-50,0])
        {
            linear_extrude(60)
            line(s, 2);
            
            linear_extrude(2)
            translate([0,-2,0])
            square(s+2);
            
        }
        
        
        
    }
    a();
    mirror([1,0,0]) a();
}

wall();

module wall2(){
    module a(){
        linear_extrude(60)
        arc([0,90], 50, 2);
        
         linear_extrude(2)
        circle(50+2);
    }
    translate([0,50,0]) {
        a();
        mirror([1,0,0])
        a();
    }
    
}

mirror([0,1,0]){
    wall();
wall2();
}
wall();
wall2();