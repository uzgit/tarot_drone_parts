include <../library/boxes.scad>
include <../library/regular_shapes.scad>

$fn=60;

module rod(outer_diameter=16, length=300, inner_diameter=15, hollow=true)
{
    difference()
    {
        cylinder(d=outer_diameter, h=length);
        if( hollow )
        {
            cylinder(d=inner_diameter, h=length);
        }
    }
}

module rods(hollow=false)
{
    rotate([0, -30, 0])
    rod(hollow=hollow);
    
    rotate([0, 30, 0])
    rod(hollow=hollow);
}

module cutoffs(exterior = 45, thickness=40, radius=145, angle=30)
{
    angle = 30;
    x_translation = exterior;
    
    rotate([0, -30, 0])
    translate([-x_translation, 0, 0])
    cube([thickness, 1000, 1000], center=true);
    
    rotate([0, 30, 0])
    translate([x_translation, 0, 0])
    cube([thickness, 1000, 1000], center=true);
}

module strut()
{
    x = 300;
    y = 15;
    z = 30;
    radius = 145;
    
    mount_x = 32;
    mount_y = 28;
    mount_z = 24;
    
    landing_gear_screw_x = 22;
    landing_gear_screw_y = 18;
    landing_gear_screw_z = 24;
    
    difference()
    {
        union()
        {
            cube([x, y, z], center=true);
            
            translate([-mount_x/2, -mount_y/2, -z/2])
            roundedCube([mount_x, mount_y, z/2], 5, sidesonly=true, center=false);
        }
        
        union()
        {
            translate([0, radius, 0])
            rotate([90, 0, 0])
            union()
            {
                rods();
                cutoffs();
            }
            
            // screw holes for landing gear
            for(x_translation = [-landing_gear_screw_x/2, landing_gear_screw_x/2])
            for(y_translation = [-landing_gear_screw_y/2, landing_gear_screw_y/2])
            translate([x_translation, y_translation, 0])
            union()
            {
                translate([0, 0, -z/2])
                cylinder(d=2.7, h=z/2);
                
                translate([0, 0, 0])
                cylinder(d=5, h=z/2);
            }
            
            for( x_translation = [11, 67, 102.5] )
            {
                translate([x_translation, 0, -z/2])
                union()
                {
                    cylinder(d=3.2, h=z);
                    cylinder(d=4, h=6);
                }
                
                translate([-x_translation, 0, -z/2])
                union()
                {
                    cylinder(d=3.2, h=z);
                    cylinder(d=4, h=6);
                }
            }
            
            // slice off the top
            translate([0, 0, z/2])
            cube([1000, 1000, z], center=true);
        }
    }
    
}
//roundedCube([32, 28, 30], 5, true, true);
//roundedCube([mount_x, mount_y, z], 5, true, true);

strut();

//rods();
//cutoffs();