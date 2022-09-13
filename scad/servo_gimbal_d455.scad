include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/regular_shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>
include <../library/lib-gear-dh.scad>
include <../library/boxes.scad>

$fn = 120;

motor_mount_outer_diameter = 26S;
motor_mount_height = 14;

camera_mount_thickness = 20;
camera_mount_length = 140;
camera_mount_height = 35.5;

screw_slot_diameter = 4;

camera_width = 128;
camera_height = 30;
camera_depth = 27;
camera_mount_thickness = 2;
camera_mount_screw_width = 95;
camera_mount_screw_hole_diameter = 4.2;

usb_x_offset = 37;
usb_y_offset = 6;
usb_width = 20;
usb_depth = 7;

module servo_mount_screw_holes(height=8, center=false, center_hole=true)
{
    screw_symmetry_radius = 14.5/2;
    num_screws = 8;
    
    for( angle = [0 : 360/num_screws : 360] )
    {
        rotate([0, 0, angle])
        translate([screw_symmetry_radius, 0, 0])
        cylinder(d=2, h=height, center=center);
        
        if(center_hole)
        {
            cylinder(d=6.5, h=height);
        }
    }
}

module servo_mount_void(height=8, void_height=3.5)
{
    translate([0, 0, height - void_height])
    cylinder(d=20.5, h=void_height);
}

module servo_top_mount()
{
    screw_symmetry_radius = 14.5/2;
    num_screws = 8;
    height = 8;
    void_height = 3.5;
    
    difference()
    {
        union()
        {
            cylinder(d=25, h=height);
        }
        
        union()
        {
            cylinder(d=6.5, h=height);
            
            servo_mount_void();
            
//            translate([0, 0, height - void_height])
//            cylinder(d=20.5, h=void_height);
            
            servo_mount_screw_holes();
        }
    }
}

//module camera_mount()
//{
//    difference()
//    {
//        union()
//        {
//            cube([camera_width + camera_mount_thickness*2, camera_depth + camera_mount_thickness, camera_height + camera_mount_thickness*2], true);
//            
//            camera_mount_x_boundary = camera_width/2 + camera_mount_thickness;
//            for( x_translation = [ -camera_mount_x_boundary, camera_mount_x_boundary] )
//            {
//                translate([x_translation, 0, 0], true)
////                cube([100, 100, 100]);
//                rotate([0, 90*sign(x_translation), 0])
//                servo_top_mount();
//            }
//        }
//        union()
//        {
//            translate([0, -camera_mount_thickness/2, 0])
//            cube([camera_width, camera_depth, camera_height], true);
//            
//            for( x_translation = [-camera_mount_screw_width/2, camera_mount_screw_width/2] )
//            {
//                translate([x_translation, 0, 0])
//                rotate([-90, 0, 0])
//                cylinder(d=camera_mount_screw_hole_diameter, h=(camera_depth/2 + camera_mount_thickness/2));
//            }
//            
//            translate([-usb_x_offset, usb_y_offset, -(camera_height/2 + camera_mount_thickness/2)])
//            cube([usb_width, usb_depth, camera_mount_thickness], true);
//            
//            rotate([0, 90, 0])
//            {
//                cylinder(d=6.5, h=200, center=true);
//                servo_mount_screw_holes(height=200, center=true);
//            }
//        }
//    }
//}

module camera_mount_screw_insert_support(screw_support_side_length = 10, depth=10)
{
    translate([0, -depth/2, 0])
    difference()
    {
        union()
        {
            cube([screw_support_side_length, depth, screw_support_side_length]);
        }
        union()
        {
            rotate([0, 45, 0])
            cube([screw_support_side_length, depth, 2*screw_support_side_length]);
            
            rotation = [0, 45, 0];
            translate([0, 0, screw_support_side_length])
            rotate(rotation)
            translate([3, 0, 0])
            rotate(-rotation)
            rotate([-90, 0, 0])
            cylinder(d=4, h=6);
        }
    }
}

module camera_mount_skinny(pivot_cylinder_height=5)
{
    difference()
    {
        union()
        {
            cube([camera_width + camera_mount_thickness*2, camera_depth + camera_mount_thickness, camera_height + camera_mount_thickness*2], true);

        
            for( x_translation = [-camera_width/2 - camera_mount_thickness, camera_width/2 + camera_mount_thickness] )
            {
                translate([x_translation, 0, 0])
                rotate([0, 90*sign(x_translation), 0])
                difference()
                {
                    union()
                    {
                        cylinder(d=15, h=pivot_cylinder_height);
                        translate([0, 0, 2.5])
                        cube([20, 3, 5], center=true);
                    }
                    cylinder(d=5, h=pivot_cylinder_height);
                }
            }
        }
        union()
        {
            for( x_translation = [-camera_width/2 - camera_mount_thickness, camera_width/2 + camera_mount_thickness] )
            {
                translate([x_translation, 0, 0])
                rotate([0, 90*sign(x_translation), 0])
                translate([0, 0, -2])
                nutHole(4);
            }            
            
            translate([0, -camera_mount_thickness/2, 0])
            cube([camera_width, camera_depth, camera_height], true);
            
            for( x_translation = [-camera_mount_screw_width/2, camera_mount_screw_width/2] )
            {
                translate([x_translation, 0, 0])
                rotate([-90, 0, 0])
                cylinder(d=camera_mount_screw_hole_diameter, h=(camera_depth/2 + camera_mount_thickness/2));
            }
            
            translate([-usb_x_offset, usb_y_offset, -(camera_height/2 + camera_mount_thickness/2)])
            cube([usb_width, usb_depth, camera_mount_thickness], true);
        }
    }
    
//    cube([camera_width + camera_mount_thickness*2, camera_depth + camera_mount_thickness, camera_height + camera_mount_thickness*2], true);
    
    
    
//    translate([0, 0, 100])
    translate([-64, 0, 5])
    camera_mount_screw_insert_support(depth=camera_depth + camera_mount_thickness);
    
    translate([54, 0, 15])
    rotate([0, 90, 0])
    camera_mount_screw_insert_support(depth=camera_depth + camera_mount_thickness);
    
    translate([64, 0, -5])
    rotate([0, 180, 0])
    camera_mount_screw_insert_support(depth=camera_depth + camera_mount_thickness);
    
    translate([-54, 0, -15])
    rotate([0, 270, 0])
    camera_mount_screw_insert_support(depth=camera_depth + camera_mount_thickness);
}

module servo(width=37, depth=20, height=41)
{
    translate([width/2, 0, -9])
    cube([width, depth, height], center=true);
}

module servo_mount(width=13.5, depth=43, height=58)
{
//    translate([0, -10, -height/2-9])
    translate([0, -10, -36])
    
    difference()
    {
        translate([0, 0, -2])
        cube([width, depth, height]);
        union()
        {
            for( y_translation = [4, 14] )
                for( z_translation = [3, 51] )
                    translate([width-6, y_translation, z_translation])
                    rotate([0, 90, 0])
                    cylinder(d=4, h=6);
        }
    }
    
    
}

module tilt_mount_skinny(height=30, width=162, depth=105, y_translation=15, void_width=142, void_width_gap=1, void_depth=67.5, wall_thickness=3, mount_thickness=15)
{
    
    difference()
    {
        union()
        {
//            translate([-width/2, -y_translation, -height/2])
//            cube([width, depth, height]);
            translate([-width/2, -y_translation, height/2])
            rotate([0, 90, 0])
            roundedCube([height, depth, width], 15, true, center=false);
        }
        union()
        {
            // main cavity
            translate([-(void_width + 2*void_width_gap)/2, -y_translation, -height/2])
            cube([void_width + 2*void_width_gap, void_depth, height]);
            
            // rear cutoff
            translate([-width/2, -y_translation + void_depth + mount_thickness, -height/2])
            cube([width, void_depth, height]);
            
            // rear servo mount
            translate([0, depth/2 + y_translation - 15, 0])
            rotate([90, 0, 0])
            {
                translate([0, 0, -5])
                cylinder(d=13, h=5);
                
                translate([0, 0, -10])
                cylinder(d=10, h=5);
                
                translate([0, 0, -15])
                cylinder(d=13, h=5);
                
                translate([0, 0, -15])
                for(x_translation = [-11, 11])
                    translate([x_translation, 0, 0])
                    cylinder(d=4, h=6);
                
//                servo_mount_void();
//                translate([0, 0, -10])
//                servo_mount_screw_holes(height=100);
            }
            
            // large screw holes
            x_translation_abs = width/2;
            for( x_translation = [-x_translation_abs, x_translation_abs] )
            {
                translate([x_translation, 0, 0])
                rotate([0, -90*sign(x_translation), 0])
                union()
                {
                    cylinder(d=13, h=5);
                    cylinder(d=10, h=9);
                }
            }
        }
    }
}

module camera_mount_gear(height=10)
{
    rotate([0, -90, 0])
    difference()
    {
        gear(30, height, 20);
        union()
        {
            cylinder(d=15, h=height);
            translate([0, 0, 2.5])
            cube([20, 3, 5], center=true);
        }
    }
}

module servo_gear(height=9)
{
    // absolute axis
    rotate([0, -90, 0])
    rotate([0, 0, 8]) // gear axis
    difference()
    {
        gear(22, height, 20);
        servo_mount_screw_holes();
    }
}

module assembly()
{
//    camera_mount_skinny();
//    translate([-camera_width/2 - 1.5*camera_mount_thickness, 0, 0])
//    camera_mount_gear();
    tilt_mount_skinny();
//    tilt_mount_gear();
//    
//    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
//    servo_gear();
//    
    difference()
    {
    translate([-camera_width/2 - 1.5*camera_mount_thickness + 1, 34.5, 0])
    servo_mount();
    
    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
    servo();
    }
}

module servo_gear_2(height=9)
{
    // absolute axis
    rotate([0, -90, 0])
    rotate([0, 0, 8]) // gear axis
    difference()
    {
        gear(22, height, 21);
        servo_mount_screw_holes();
    }
}

module assembly()
{
    camera_mount_skinny();
//    translate([-camera_width/2 - 1.5*camera_mount_thickness, 0, 0])
//    camera_mount_gear();
//    tilt_mount_skinny();
//    tilt_mount_gear();
//    
//    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
//    servo_gear();
//    
//    difference()
//    {
//    translate([-camera_width/2 - 1.5*camera_mount_thickness + 1, 34.5, 0])
//    servo_mount();
//    
//    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
//    servo();
//    }
}

module tilt_mount_gear()
{
    translate([0, 100, 0])
    rotate([90, 0, 0])
    difference()
    {
        gear(30, 10, 20);
        
        union()
        {
            cylinder(d=10, h=10);
//            translate([0, 0, -15])
            for(x_translation = [-11, 11])
                translate([x_translation, 0, 0])
                cylinder(d=3.2, h=6);
        }
    }
}

assembly();
//rotate([0, 90, 0])
//roundedCube([30, 60, 30], 15, true, center=false);


//servo_gear();
//
//translate([10, 0, 0])
//servo_gear_2();