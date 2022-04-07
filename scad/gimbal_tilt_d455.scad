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

module motor_mount()
{
    difference()
    {
        union()
        {
            octagon(motor_mount_outer_diameter, 14);
            
            translate([-camera_mount_thickness, -camera_mount_height/2, -motor_mount_height/2])
            
            translate([7, 0, 0])
            cube([camera_mount_thickness, camera_mount_height, motor_mount_height/2]);
        }
        union()
        {
            translate([0, 0, -(motor_mount_height/2 - 3)])
            cylinder(d=24, h=100);
            
            translate([0, 0, -10])
            cylinder(d=10, h=30);
            
            for(angle = [0, 90, 180, 270])
            {
                rotate(angle+45)
                translate([8, 0, -10])
                cylinder(d=2, h=10);
            }
            
            // for the limit tab
            translate([-8, -27, (motor_mount_height/2 - 5)])
            rotate([0, 0, 25])
            cube([40, 30, 5]);
        }
    }
}

module camera_mount()
{
    difference()
    {
        union()
        {
            translate([-camera_mount_thickness, 0, -camera_mount_height/2])
            cube([camera_mount_thickness, camera_mount_length, camera_mount_height]);
        }
        union()
        {
            translate([-camera_mount_thickness+2, 0, -camera_mount_height/2+2])
            cube([camera_mount_thickness-2, camera_mount_length-2, camera_mount_height-4]);            
            
            translate([-camera_mount_thickness, screw_slot_diameter, -2])
            cube([2, 130, 4]);
        }
    }
}

translate([0, -motor_mount_height/2, 0])
rotate([90, 0, 0])
motor_mount();

translate([7, 0, 0])
camera_mount();