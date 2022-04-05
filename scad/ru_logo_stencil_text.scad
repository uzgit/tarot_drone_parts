scalar = 1.4;

width = 160;

difference()
{
    translate([0, 0, 0.5])
    cube([width, width, 1], center=true);
    
    linear_extrude(height=1)
    scale([scalar, scalar, scalar])
    import("../library/Reykjavik_University_Logo.svg", center=true);
}

cylinder(r=65, h=1);

// first R in reykjavik university
translate([-68, -23, 1])
rotate([0, 0, 12])
cube([2, 10, 1]);

// A in reykjavik university
translate([-35, -65, 1])
rotate([0, 0, 50])
cube([2, 10, 1]);

// second R in reykjavik university
translate([55, -46, 1])
rotate([0, 0, 138])
cube([2, 10, 1]);

// A in haskolinn
translate([-67, 23, 1])
rotate([0, 0, 165])
cube([2, 10, 1]);

// O in haskolinn
translate([-47, 52, 1])
rotate([0, 0, 140])
cube([2, 10, 1]);

// R in haskolinn i reykjavik
translate([23, 67.5, 1])
rotate([0, 0, 75])
cube([2, 10, 1]);

// second A in haskolinn i reykjavik
translate([64, 30, 1])
rotate([0, 0, 30])
cube([2, 10, 1]);