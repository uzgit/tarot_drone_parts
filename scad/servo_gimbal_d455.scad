include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/regular_shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>
include <../library/lib-gear-dh.scad>
include <../library/boxes.scad>

$fn = 20;

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
        cylinder(d=1.5, h=height, center=center);
        
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

module camera_mount_skinny(pivot_cylinder_height=5)
{
    difference()
    {
        union()
        {
            cube([camera_width + camera_mount_thickness*2, camera_depth + camera_mount_thickness, camera_height + camera_mount_thickness*2], true);
            
//            camera_mount_x_boundary = camera_width/2 + camera_mount_thickness;
//            for( x_translation = [ -camera_mount_x_boundary, camera_mount_x_boundary] )
//            {
//                translate([x_translation, 0, 0], true)
////                cube([100, 100, 100]);
//                rotate([0, 90*sign(x_translation), 0])
//                servo_top_mount();
//            }
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
                    cylinder(d=6.5, h=pivot_cylinder_height);
                }
            }
        }
        union()
        {
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
}

module servo(width=37, depth=20, height=41)
{
    translate([width/2, 0, -9])
    cube([width, depth, height], center=true);
}

module servo_mount(width=11, depth=38, height=54)
{
    translate([0, -10, -height/2-9])
    
    difference()
    {
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

//module servo(width=38, depth=42, height=20, mount_width=6, mount_depth=60, extend=false)
//{
//    
//    cube([width, depth, height], center=true);
//    
//    translate([13 - mount_width/2, 0, 0])
//    {
//        cube([mount_width, mount_depth, height], center=true);
//        
//        
//        for( z_translation = [-5, 5] )
//        {
//            
//            translate([0, depth/2 + 4, z_translation])
//            rotate([0, -90, 0])
//            cylinder(d=3, h=40, center=false);
//        }
//    }
//    
//    if( extend )
//    {
//        translate([0, -depth/2, -height/2])
//        cube([width, depth, height], center=false);
//    }
//}

//module tilt_mount(height=25, width=218, depth=60, y_translation=15, void_width=148, void_width_gap=2, void_depth=60, wall_thickness=3)
//{
//    difference()
//    {
//        union()
//        {
//            translate([0, y_translation, 0])
//            cube([width, depth, height], true);
//            
//            
//        }
//        union()
//        {
//            cube([void_width + 2*void_width_gap, void_depth, height], true);
//            
//            translate([0, depth/2 + y_translation - 8])
//            rotate([-90, 0, 0])
//            {
//                servo_mount_void();
//                translate([0, 0, -10])
//                servo_mount_screw_holes(height=100);
//            }
//            
//            translate([-66 - (8 - 3.5) - 36.5/2, 0, 0])
//            servo();
//            
//            // screw void
//            translate([66+8+2, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=6.25, h=33);
//            
//            // screw bigger void
//            translate([66+8+2+10, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=19, h=23);
//        }
//    }
//    
//}

//module tilt_mount(height=25, width=240, depth=60, y_translation=15, void_width=148, void_width_gap=2, void_depth=60, wall_thickness=3)
//{
//    difference()
//    {
//        union()
//        {
//            translate([0, y_translation, 0])
//            cube([width, depth, height], true);
//            
//            
//        }
//        union()
//        {
//            cube([void_width + 2*void_width_gap, void_depth, height], true);
//            
//            translate([0, depth/2 + y_translation - 8])
//            rotate([-90, 0, 0])
//            {
//                servo_mount_void();
//                translate([0, 0, -10])
//                servo_mount_screw_holes(height=100);
//            }
//            
//            translate([-76 - (8 - 3.5) - 36.5/2, 0, 0])
//            servo(extend=true);
//            
//            // screw void
//            translate([66+8+2, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=6.25, h=33+100);
//            
//            // screw bigger void
//            translate([66+8+2+10, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=19, h=23+100);
//        }
//    }
//    
//}

//module tilt_mount(height=25, width=240, depth=60, y_translation=15, void_width=148, void_width_gap=2, void_depth=60, wall_thickness=3)
//{
//    difference()
//    {
//        union()
//        {
//            translate([0, y_translation, 0])
//            cube([width, depth, height], true);
//        }
//        union()
//        {
//            cube([void_width + 2*void_width_gap, void_depth, height], true);
//            
//            translate([0, depth/2 + y_translation - 8])
//            rotate([-90, 0, 0])
//            {
//                servo_mount_void();
//                translate([0, 0, -10])
//                servo_mount_screw_holes(height=100);
//            }
//            
//            translate([-76 - (8 - 3.5) - 36.5/2 + 4, 9, 0])
//            {
//                servo(extend=true);
//                
//                translate([0, -30, 0])
//                cube([38, 50, 20], center=true);
//            }
////            translate([-76 - (8 - 3.5) - 36.5/2 + 4, 0, 0])
////            servo(extend=true);
//            
//            // screw void
//            translate([66+8+2, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=5.9, h=33+100);
//            
//            // screw bigger void
//            translate([66+8+2+10, 0, 0])
//            rotate([0, 90, 0])
//            cylinder(d=19, h=23+100);
//        }
//    }
//    
//}

//module tilt_mount_skinny(height=25, width=162, depth=110, y_translation=15, void_width=142, void_width_gap=1, void_depth=60, wall_thickness=3)
//{
//    void_depth = depth;
//    
//    difference()
//    {
//        union()
//        {
//            translate([0, y_translation, 0])
//            cube([width, depth, height], true);
//        }
//        union()
//        {
//            cube([void_width + 2*void_width_gap, void_depth, height], true);
//            
//            translate([0, depth/2 + y_translation - 8])
//            rotate([-90, 0, 0])
//            {
//                servo_mount_void();
//                translate([0, 0, -10])
//                servo_mount_screw_holes(height=100);
//            }
//            
//            x_translation_abs = width/2;
//            for( x_translation = [-x_translation_abs, x_translation_abs] )
//            {
//                translate([x_translation, 0, 0])
//                rotate([0, -90*sign(x_translation), 0])
//                union()
//                {
//                    cylinder(d=15, h=5);
//                    cylinder(d=6.5, h=9);
//                }
//            }
//        }
//    }
//}

module tilt_mount_skinny(height=30, width=162, depth=105, y_translation=15, void_width=142, void_width_gap=1, void_depth=67.5, wall_thickness=3, mount_thickness=10)
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
            translate([0, depth/2 + y_translation - 13])
            rotate([-90, 0, 0])
            {
                servo_mount_void();
                translate([0, 0, -10])
                servo_mount_screw_holes(height=100);
            }
            
            // large screw holes
            x_translation_abs = width/2;
            for( x_translation = [-x_translation_abs, x_translation_abs] )
            {
                translate([x_translation, 0, 0])
                rotate([0, -90*sign(x_translation), 0])
                union()
                {
                    cylinder(d=15, h=5);
                    cylinder(d=6.5, h=9);
                }
            }
        }
    }
}

module camera_mount_gear(height=5)
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

module servo_gear(height=5)
{
    // absolute axis
    rotate([0, -90, 0])
    rotate([0, 0, 8]) // gear axis
    difference()
    {
        gear(22, 5, 20);
        servo_mount_screw_holes();
    }
}

module assembly()
{
    camera_mount_skinny();
    translate([-camera_width/2 - 1.5*camera_mount_thickness, 0, 0])
    camera_mount_gear();
    tilt_mount_skinny();
    
    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
    servo_gear();
    
    difference()
    {
    translate([-camera_width/2 - 1.5*camera_mount_thickness + 1, 34.5, 0])
    servo_mount();
    
    translate([-camera_width/2 - 1.5*camera_mount_thickness, 34.5, 0])
    servo();
    }
}

assembly();
//rotate([0, 90, 0])
//roundedCube([30, 60, 30], 15, true, center=false);