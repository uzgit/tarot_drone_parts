scalar = 1.4;

difference()
{
    translate([0, 0, 0.5])
    cube([200, 200, 1], center=true);
    
    linear_extrude(height=1)
    scale([scalar, scalar, scalar])
    import("../library/Reykjavik_University_Logo.svg", center=true);
}

cylinder(r=65, h=1);