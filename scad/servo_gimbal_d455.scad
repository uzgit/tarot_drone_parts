    include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>

$fn = 60;

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

module camera_mount()
{
    difference()
    {
        union()
        {
            cube([camera_width + camera_mount_thickness*2, camera_depth + camera_mount_thickness, camera_height + camera_mount_thickness*2], true);
            
            camera_mount_x_boundary = camera_width/2 + camera_mount_thickness;
            for( x_translation = [ -camera_mount_x_boundary, camera_mount_x_boundary] )
            {
                translate([x_translation, 0, 0], true)
//                cube([100, 100, 100]);
                rotate([0, 90*sign(x_translation), 0])
                servo_top_mount();
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
            
            rotate([0, 90, 0])
            {
                cylinder(d=6.5, h=200, center=true);
                servo_mount_screw_holes(height=200, center=true);
            }
        }
    }
}

module servo(width=38, depth=42, height=20, mount_width=6, mount_depth=60, extend=false)
{
    
    cube([width, depth, height], center=true);
    
    translate([13 - mount_width/2, 0, 0])
    {
        cube([mount_width, mount_depth, height], center=true);
        
        
        for( z_translation = [-5, 5] )
        {
            
            translate([0, depth/2 + 4, z_translation])
            rotate([0, -90, 0])
            cylinder(d=3, h=40, center=false);
        }
    }
    
    if( extend )
    {
        translate([0, -depth/2, -height/2])
        cube([width, depth, height], center=false);
    }
}

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

module tilt_mount(height=25, width=240, depth=60, y_translation=15, void_width=148, void_width_gap=2, void_depth=60, wall_thickness=3)
{
    difference()
    {
        union()
        {
            translate([0, y_translation, 0])
            cube([width, depth, height], true);
            
            
        }
        union()
        {
            cube([void_width + 2*void_width_gap, void_depth, height], true);
            
            translate([0, depth/2 + y_translation - 8])
            rotate([-90, 0, 0])
            {
                servo_mount_void();
                translate([0, 0, -10])
                servo_mount_screw_holes(height=100);
            }
            
            translate([-76 - (8 - 3.5) - 36.5/2 + 4, 9, 0])
            {
                servo(extend=true);
                
                translate([0, -30, 0])
                cube([38, 50, 20], center=true);
            }
//            translate([-76 - (8 - 3.5) - 36.5/2 + 4, 0, 0])
//            servo(extend=true);
            
            // screw void
            translate([66+8+2, 0, 0])
            rotate([0, 90, 0])
            cylinder(d=5.9, h=33+100);
            
            // screw bigger void
            translate([66+8+2+10, 0, 0])
            rotate([0, 90, 0])
            cylinder(d=19, h=23+100);
        }
    }
    
}

//camera_mount();
tilt_mount();