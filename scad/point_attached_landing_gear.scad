include <../library/boxes.scad>
include <../library/regular_shapes.scad>

$fn=20;

module rod(outer_diameter=16, length=300, inner_diameter=15, hollow=true)
{
    rotate([0, 90, 0])
    difference()
    {
        cylinder(d=outer_diameter, h=length);
        if( hollow )
        {
            cylinder(d=inner_diameter, h=length);
        }
    }
}

module leg_rod(diameter=10)
{
    cylinder(d=10, h=281);
}

////////// orig
//module leg_rod(diameter=16, inner_diameter=10, length=281, support_length=30)
//{
//    translate([0, 0, length])
//    rotate([180, 0, 0])
//    difference()
//    {
//        cylinder(d=diameter, h=support_length);
//        cylinder(d=inner_diameter, h=support_length);
//    }
//}

module leg_rod(diameter=16, inner_diameter=10, length=281, support_length=30, angle=0)
{
    translate([0, 0, length])
    rotate([180, 0, 0])
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=support_length);
            
            rotate([0, 0, angle])            
            translate([0, 10, support_length-9/2])
            {
                difference()
                {
                    cube([9, 11.5, 9], center=true);
                    
                    union()
                    {
                        rotate([0, -90*sign(angle), 0])
                        cylinder(d=4, h=6);
                        
                        rotate([0, 90*sign(angle), 0])
                        cylinder(d=3.2, h=6);
                    }
                }
            }
        }
        union()
        {
            cylinder(d=inner_diameter, h=support_length);
            
            rotate([0, 0, angle])            
            translate([2.5*sign(angle), 10, support_length/2])
            {
                cube([1, 12, support_length], center=true);
            }
            
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

module rod_with_leg(angle=0, rod=true, angle=0)
{
    if( rod )
    {
        rod(hollow=hollow);
    }
    
    translate([170, 0, -10])
    rotate([180, 0, 0])
    leg_rod(diameter=16,inner_diameter=10.2, angle=angle);
}

module leg_structure()
{
    angle = 18;
    
    difference()
    {
        union()
        {
            rotate([angle, 0,-30])
            rod_with_leg(angle, rod=false, angle=31.5);
            
            rotate([-angle, 0, 30])
            rod_with_leg(-angle, rod=false, angle=-211.5);
        }
        union()
        {
            rotate([0, 15, 0])
            cube([50, 50, 30], center=true);
        }
    }
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

module point_mount(diameter=30, height=30, mount_width=16, mount_thickness=10, sleeve_length=50, sleeve_screw_mount_thickness=9)
{
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=height, center=true);
            
            rotate([0, 90, 0])
            cylinder(d=17.5, h=sleeve_length);
            
            translate([sleeve_length/2, 0, height/4])
            cube([sleeve_length, sleeve_screw_mount_thickness, height/2], center=true);
            
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
            
            // gap for screw mount
            translate([sleeve_length/2 + diameter/2, 2.5, height/4])
            cube([sleeve_length, 0.75, height/2], center=true);
            
            translate([0, -sleeve_screw_mount_thickness/2, 11.25 ])
            for(x_translation = [30, 45])
            {
                translate([x_translation, 0, 0])
                rotate([-90, 0, 0])
                {
                    cylinder(d=4, h=6);
                    cylinder(d=3.2, h=sleeve_screw_mount_thickness);
                }
            }
            
            rotate([0, 90, 0])
            cylinder(d=10.25, h=50);
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
        
        translate([-99.75, -50, -50])
        cube([100, 100, 100]);
    }
}

distance = 10;

module pad()
{
    diameter = 50;
    z = 7;
    leg_support_diameter = 20;
    leg_support_length = 20;
    leg_void_diameter = 16;
    leg_angle = 15;
    
    lock_z = 10;
    
    difference()
    {
        union()
        {
            // the pad itself
//            translate([0, 0, -10])
            cylinder(d=diameter,h=z);
            
            // leg support
            rotate([-leg_angle, 0, 0])
            translate([0, 0, z/2])
            {
                cylinder(d=leg_support_diameter, h=leg_support_length);
                
                translate([0, 13.5, 15])
                rotate([0, 90, 0])
                {
                    difference()
                    {
                        hull()
                        {
                            translate([0, -10, 0])
                            cube([10, 20, 7], center=true);
                            cylinder(d=10, h=7, center=true);
                        }
                        cylinder(d=3.2, h=7, center=true);
                    }
                }
            }
        }
        union()
        {
            rotate([-leg_angle, 0, 0])
            translate([0, 0, z/2])
            cylinder(d=leg_void_diameter, h=leg_support_length + 1);
            
            for( y_translation = [15, -15] )
            {
                translate([0, y_translation, z ])
                rotate([180, 0, 0])
                {
                    // threaded insert
                    cylinder(d=4, h=6);
                    
                    // screw void
                    cylinder(d=3.2, h=10);
                }
            }
            
            translate([-0.5, 0, z])
            cube([1, diameter/2, leg_support_length]);
        }
    }
}

module pad2()
{
    diameter = 50;
    z = 7;
    leg_support_diameter = 20;
    leg_support_length = 20;
    leg_void_diameter = 16;
    leg_angle = 15;
    
    lock_z = 10;
    
    difference()
    {
        union()
        {
            // the pad itself
//            translate([0, 0, -10])
            cylinder(d=diameter,h=z);
            
            translate([-192, 0, 280])
            leg_structure();
            
//            // leg support
//            rotate([-leg_angle, 0, 0])
//            translate([0, 0, z/2])
//            {
//                cylinder(d=leg_support_diameter, h=leg_support_length);
//                
//                translate([0, 13.5, 15])
//                rotate([0, 90, 0])
//                {
//                    difference()
//                    {
//                        hull()
//                        {
//                            translate([0, -10, 0])
//                            cube([10, 20, 7], center=true);
//                            cylinder(d=10, h=7, center=true);
//                        }
//                        cylinder(d=3.2, h=7, center=true);
//                    }
//                }
//            }
        }
        union()
        {
//            rotate([-leg_angle, 0, 0])
//            translate([0, 0, z/2])
//            cylinder(d=leg_void_diameter, h=leg_support_length + 1);
            
            for( x_translation = [15, -15] )
            {
                translate([x_translation, 0, z ])
                rotate([180, 0, 0])
                {
                    // threaded insert
                    cylinder(d=4, h=6);
                    
                    // screw void
                    cylinder(d=3.2, h=10);
                }
            }
            
//            translate([-0.5, 0, z])
//            cube([1, diameter/2, leg_support_length]);
        }
    }
}

pad2();

//translate([-distance/2, 0, 0])
//top();

//translate([distance/2, 0, 0])
//bottom();

//assembly();

//difference()
//{
//    union()
//    {
//        pad();
//    }
//    union()
//    {
//        leg_structure();
//    }
//}

//leg_structure();

//roundedCube([32, 28, 30], 5, true, true);
//roundedCube([mount_x, mount_y, z], 5, true, true);

//rods();
//cutoffs();
    