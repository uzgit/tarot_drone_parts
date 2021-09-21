// tarot 680 pro mounting plate - a OpenSCAD 
// Copyright (C) 2015  Gerard Valade

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>

draft = false;
$fn = 60;

module m3_hole(center_x, center_y)
{
    translate([center_x, center_y, -10]);
    union() difference() {
                cylinder( d = 20.0, h = 19 );
                cylinder( d = 17.00, h = 19);
     }
}

module m3_standoff(height = 10)
{
    standoff_outer_diameter = 6.2;
    m3_hole_diameter        = 3.2;
    screw_head_depth = 10;
    screw_head_radius = 5.25;
    difference()
    {
        union()
        {
            cylinder( d = standoff_outer_diameter, h = height);
            rotate_extrude()
            {
                polygon(points=[[0,0],[screw_head_radius, 0],[0,screw_head_depth]], paths=[[0,1,2]]);
            }
        }
        {
            cylinder( d = m3_hole_diameter, h = height);
        }
    }
}

diameter = 177;

draft_thickness = 0.3;
final_thickness = 3;

thickness = final_thickness;

cut_thickness = thickness + 10;
base_plate_screw_hole_size = 4;
base_plate_screw_void_size = 7;

module center_hole()
{
    side_length = 30;
    roundness = 10;
    roundCornersCube(side_length, side_length, cut_thickness, roundness);
}

module lightening_holes()
{
    height = 30;
    width = 50;
    roundness = 10;
    y_offset = 40;
//    translate([0, y_offset, 0]) roundCornersCube(width, height, thickness, roundness);
//    translate([0, -y_offset, 0]) roundCornersCube(width, height, thickness, roundness);
    
    side_length = 30;
    roundness = 10;
    
    // top left
    translate([-55, 40, 0]) rotate([0, 0, -30]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
    
    // top center
    translate([0, 60, 0]) rotate([0, 0, 0]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
    
    // top right
    translate([55, 40, 0]) rotate([0, 0, 30]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
    
    // bottom left
    translate([-55, -40, 0]) rotate([0, 0, 30]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
    
    // bottom center
    translate([0, -60, 0]) rotate([0, 0, 0]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
    
    // bottom right
    translate([55, -40, 0]) rotate([0, 0, -30]) roundCornersCube(side_length, side_length, cut_thickness, roundness);
}

module screw_hole_cylinder()
{
    cylinder( d = base_plate_screw_hole_size, h = 10);
}

module screw_void_cylinder()
{
    cylinder( d = base_plate_screw_void_size, h = cut_thickness);
}

// for mounting screws
module tarot_680_base_plate_screw_holes()
{
    z_offset = -thickness / 2.0;
    
    for ( x_offset = [-37, -23, 23, 37] )
    {
        for ( y_offset = [-73, 73] )
        {
            translate([x_offset, y_offset, z_offset]) screw_hole_cylinder();
        }
    }
    
    for ( x_offset = [-74, 74] )
    {
        for ( y_offset = [-11, 11] )
        {
            translate([x_offset, y_offset, z_offset]) screw_hole_cylinder();
        }
    }
}

// for sinking the screw heads
module base_plate_screw_head_cone()
{
    screw_head_depth = 2;
    screw_head_radius = 6;

    rotate_extrude()
    {
        translate([0, 0, 0]) polygon(points=[[0,0],[screw_head_radius, 0],[0,screw_head_depth]], paths=[[0,1,2]]);
    }
}

// for avoiding existing screws
module tarot_680_base_plate_void_holes()
{
    
    z_offset = -thickness / 2.0;
    
    // holes around the center for side arms
    for ( x_offset = [-36, 36] )
    {
        for ( y_offset = [-11, 11] )
        {
            translate([x_offset, y_offset, z_offset]) screw_void_cylinder();
        }
    }
    
    for ( x_offset = [-21, 21] )
    {
        for ( y_offset = [-36.5, 36.5] )
        {
            translate([x_offset, y_offset, z_offset]) screw_void_cylinder();
        }
    }
    
    for ( x_offset = [-81, 81] )
    {
        for ( y_offset = [-29.25, -20.25, 20.25, 29.25] )
        {
            translate([x_offset, y_offset, z_offset]) screw_void_cylinder();
        }
    }
}

module raspberry_pi_holes()
{
    z_offset = -thickness / 2.0;
    for ( x_offset = [3.5, 61.5] )
    {
        for ( y_offset = [3.5, 52.5] )
        {
            union()
            {
                translate([x_offset, y_offset, z_offset]) screw_hole_cylinder();
//                translate([x_offset, y_offset, -thickness]) base_plate_screw_head_cone();
                translate([x_offset, y_offset, z_offset]) nutHole(3);
                translate([x_offset, y_offset, z_offset + 2]) nutHole(3);
            }
        }
    }
}

module raspberry_pi_standoffs(height = 10)
{
    z_offset = thickness / 2.0;
    for ( x_offset = [3.5, 61.5] )
    {
        for ( y_offset = [3.5, 52.5] )
        {
            translate([x_offset, y_offset, z_offset]) m3_standoff(height);
        }
    }
}

module google_coral_holes()
{
    raspberry_pi_holes();
}

module google_coral_standoffs()
{
    raspberry_pi_standoffs();
}

module jetson_nano_holes()
{
    z_offset = -thickness / 2.0;
    for ( x_offset = [3.5, 61.5] )
    {
        for ( y_offset = [3.5, 89.5] )
        {
            translate([x_offset, y_offset, z_offset]) screw_hole_cylinder();
            translate([x_offset, y_offset, -thickness]) base_plate_screw_head_cone();
        }
    }
}

module jetson_nano_standoffs(height = 10)
{
    z_offset = thickness / 2.0;
    for ( x_offset = [3.5, 61.5] )
    {
        for ( y_offset = [3.5, 89.5] )
        {
            translate([x_offset, y_offset, z_offset]) m3_standoff(height);
        }
    }

}

module hinge_mount()
{
    hinge_outer_diameter = 6;
    
    x_length = 50;
    y_length = 10;
    roundness = 10;
    y_translation = -4;
    
    // i don't know exactly what to call this so this is what you get.
    hinge_width = 6;
    
    // base
    translate([-x_length / 2.0, y_translation, -thickness / 2.0]) cube([x_length, y_length, thickness]);
    
    // connecting corners
    translate([-x_length / 2.0, 5, -thickness / 2.0]) cube([x_length, 10, thickness]);
    
    // hinge
    difference()
    {
        union ()
        {
            // bottom of the hinge is like a cube
            translate([-x_length / 2.0, y_translation, thickness / 2.0])
            cube([x_length, hinge_outer_diameter, 4.5]);
            
            // top of the hinge is like a cylinder
            translate([-x_length / 2.0, y_translation + 3.1, (-thickness/2.0) + 6])
            rotate([0, 90, 0])
            cylinder(d = hinge_outer_diameter, h = x_length);
        }
        {
            // cylinder for the hinge pin (which can be a screw like M3x30mm)
            translate([-x_length / 2.0, y_translation + 3.1, (-thickness/2.0) + 6])
            rotate([0, 90, 0])
            cylinder(d = 3.2, h = x_length);
            
            // cut off the leftmost part of the hinge
            translate([-x_length / 2.0, y_translation - 10, 0])
            cube([(x_length / 2.0) - (2.5 * hinge_width), 20, 20]);
            // cut off the second hinge knuckle
            translate([-1.5 * hinge_width, y_translation - 10, 0])
            cube([hinge_width, 20, 20]);
            
            // cut off the fourth hinge knuckle
            translate([0.5 * hinge_width, y_translation - 10, 0])
            cube([hinge_width, 20, 20]);
            
            // cut off the rightmost part of the hinge
            translate([2.5 * hinge_width, y_translation - 10, 0])
            cube([(x_length / 2.0) - (2.5 * hinge_width), 20, 20]);
        }
    }
}

module velcro_slit()
{
    //roundCornersCube(side_length, side_length, thickness, roundness);
    x_length = 50;
    y_length = 15;
    hinge_mount_thickness = thickness;
    roundness = 10;
    
    y_translation = -9;
    
    // i don't know exactly what to call this so this is what you get.
    hinge_width = 6;
    

    
    // hinge
    difference()
    {
        union ()
        {
            
         //base
         translate([-x_length / 2.0, y_translation, -thickness / 2.0]) cube([x_length, y_length, hinge_mount_thickness]);
        
         // connecting corners
         translate([-x_length / 2.0, 5, -thickness / 2.0]) cube([x_length, 10, hinge_mount_thickness]);
        }
        
        translate([0, -4, 0]) roundCornersCube(33, 2, 10, 3);
        
    }

}

module tarot_680_base_plate()
{
    difference ()
    {
        union ()
        {
            dodecagon(diameter, thickness);
        }
        {
//            tarot_680_base_plate_screw_holes();
//            tarot_680_base_plate_void_holes();
            
            // raspberry pi has 22.5 mm extending past its longer side, so the holes should be offset accordingly
//            translate(raspberry_pi_translation) rotate(raspberry_pi_rotation) raspberry_pi_holes();
//            translate(google_coral_translation) rotate(google_coral_rotation) google_coral_holes();
//            center_hole();
//            lightening_holes();
        }
    }
    
}

// ********************** main **********************

// High-level component orientation variables
// ******************************************
raspberry_pi_rotation               = [0, 0, 0];
raspberry_pi_translation            = [-32, -29, 0];
centered_raspberry_pi_translation   = [-42, -27, 0];
jetson_nano_rotation                = [0, 0, -90];
jetson_nano_translation             = [-42, 56, 0];
google_coral_rotation               = [0, 0, 0];
google_coral_translation            = [-32, 5, 0];
// ******************************************

// add or remove components from here
difference()
{
    union()
    {
        // add components here
        tarot_680_base_plate();
        
        // hinge and velcro slit for canopy
//        translate([0, -95, 0]) hinge_mount();
        
        translate([0, 95, 0]) rotate([0, 0, 180]) velcro_slit();
        translate([0, -95, 0]) rotate([0, 0, 0]) velcro_slit();
        
        // if you add standoffs then you should remember to add the holes for them in the part below
        // standoffs for raspberry pi (presumably with Navio2)
        translate(raspberry_pi_translation) rotate(raspberry_pi_rotation) raspberry_pi_standoffs(height = 10);
//        translate(google_coral_translation) rotate(google_coral_rotation) raspberry_pi_standoffs(height = 10);

    }
    union()
    {
        // remove components here
        translate([0, 0, -thickness])
        center_hole();
        lightening_holes();
        tarot_680_base_plate_screw_holes();
        tarot_680_base_plate_void_holes();
        
        // add holes for standoffs here
        // holes through base plate for raspberry pi standoffs
        translate(raspberry_pi_translation) rotate(raspberry_pi_rotation) raspberry_pi_holes();
//        translate(google_coral_translation) rotate(google_coral_rotation) raspberry_pi_holes();
    }
}
// ********************** /main **********************
