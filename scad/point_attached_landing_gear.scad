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

module point_mount(diameter=30, height=30, mount_width=16, mount_thickness=10)
{
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=height, center=true);
            
            rotate([0, 90, 0])
            cylinder(d=17.5, h=50);
            
            translate([1.5, 0, 0])
            difference()
            {
                cube([10, diameter + mount_width, height], center=true);
                
                x_translation = 1.5;
                for( y_translation = [ diameter/2 + mount_width/5, -(diameter/2 + mount_width/5) ] )
                for( z_translation = [height/3, -height/3] )
                {
                    translate([-x_translation + 1, y_translation, z_translation])
                    rotate([0, 90, 0])
                    cylinder(d=4, h=6);
                    
                    translate([-mount_thickness/2 - x_translation, y_translation, z_translation])
                    rotate([0, 90, 0])
                    cylinder(d=3.2, h=6);
                }
            }
        }
        union()
        {
            cylinder(d=16, h=height, center=true);
            
            rotate([0, 90, 0])
            cylinder(d=10, h=50);
        }
    }
}

module assembly()
{
    x = 300;
    y = 15;
    z = 30;
    radius = 170;
    
    mount_x = 32;
    mount_y = 28;
    mount_z = 24;
    
    landing_gear_screw_x = 22;
    landing_gear_screw_y = 18;
    landing_gear_screw_z = 24;
    
    distance_between_point_mounts = 170;
    
    difference()
    {
        union()
        {
            for( x_translation = [-distance_between_point_mounts/2, distance_between_point_mounts/2] )
            {
                translate([x_translation, 0, 0])
                rotate([0, 0, 30 * sign(x_translation)])
                translate([ 15 * sign(x_translation), 0, 0, ])
                point_mount();
            }
        }
        
        union()
        {
//            rods();
            
            translate([0, radius, 0])
            rotate([90, 0, 0])
            union()
            {
                rods();
                cutoffs();
            }
//            
//            // screw holes for landing gear
//            for(x_translation = [-landing_gear_screw_x/2, landing_gear_screw_x/2])
//            for(y_translation = [-landing_gear_screw_y/2, landing_gear_screw_y/2])
//            translate([x_translation, y_translation, 0])
//            union()
//            {
//                translate([0, 0, -z/2])
//                cylinder(d=2.7, h=z/2);
//                
//                translate([0, 0, 0])
//                cylinder(d=5, h=z/2);
//            }
//            
//            for( x_translation = [11, 67, 102.5] )
//            {
//                translate([x_translation, 0, -z/2])
//                union()
//                {
//                    cylinder(d=3.2, h=z);
//                    cylinder(d=4, h=6);
//                }
//                
//                translate([-x_translation, 0, -z/2])
//                union()
//                {
//                    cylinder(d=3.2, h=z);
//                    cylinder(d=4, h=6);
//                }
//            }
//            
//            // slice off the top
//            translate([0, 0, z/2])
//            cube([1000, 1000, z], center=true);
        }
    }
    
}

//point_mount();

module top()
{

    difference()
    {
        point_mount();
        
        translate([0, -50, -50])
        cube([100, 100, 100]);
    }
}

module bottom()
{

    difference()
    {
        point_mount();
        
        translate([-100, -50, -50])
        cube([100, 100, 100]);
    }
}

distance = 10;

//translate([-distance/2, 0, 0])
//top();

translate([distance/2, 0, 0])
bottom();

//assembly();

//roundedCube([32, 28, 30], 5, true, true);
//roundedCube([mount_x, mount_y, z], 5, true, true);

//rods();
//cutoffs();