    include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>

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

module servo_mount_screw_holes(height=8, center=false)
{
    screw_symmetry_radius = 14.5/2;
    num_screws = 8;
    
    for( angle = [0 : 360/num_screws : 360] )
    {
        rotate([0, 0, angle])
        translate([screw_symmetry_radius, 0, 0])
        cylinder(d=1.5, h=height, center=center);
    }
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
            
            translate([0, 0, height - void_height])
            cylinder(d=20.5, h=void_height);
            
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

module tilt_mount()
{
    height = 20;
    
    
    difference()
    {
        union()
        {
            translate([0, 15, 0])
            cube([138 + 80, 60, 20], true);
        }
        union()
        {
            cube([149, 55, 50], true);
        }
    }
    
}

camera_mount();
tilt_mount();