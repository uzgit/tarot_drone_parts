include <../library/regular_shapes.scad>
include <../library/boxes.scad>

$fn=60;

module dodecagon_rotated(radius, rotation=15)
{
    rotate([0, 0, rotation])
    dodecagon(radius);
}

module dodecagon_prism_rotated(height, radius, rotation=15)
{
    rotate([0, 0, rotation])
    dodecagon_prism(height, radius);
}

module tarot_680_base_plate_void_holes(void_thickness)
{
    // holes around the center for side arms
    for ( x_offset = [-92, -36, 36, 92] )
    {
        for ( y_offset = [-11, 11] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=7, h=void_thickness);
        }
    }
    
    for ( x_offset = [-21, 21] )
    {
        for ( y_offset = [-36.5, 36.5] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=7, h=void_thickness);
        }
    }
    
    for ( x_offset = [-81, 81] )
    {
        for ( y_offset = [-29.25, -20.25, 20.25, 29.25] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=7, h=void_thickness);
        }
    }
    
    for ( x_offset = [-30, 30] )
    {
        for ( y_offset = [-88.5, 88.5] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=7, h=void_thickness);
        }
    }
    
        for ( x_offset = [-38, 38] )
    {
        for ( y_offset = [-84, 84] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=7, h=void_thickness);
        }
    }
}

module tarot_680_base_plate_screw_holes(void_thickness)
{
    for ( x_offset = [-37, -23, 23, 37] )
    {
        for ( y_offset = [-73, 73] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=4, h=void_thickness);
        }
    }
    
    for ( x_offset = [-74, 74] )
    {
        for ( y_offset = [-11, 11] )
        {
            translate([x_offset, y_offset, 0])
            cylinder(d=4, h=void_thickness);
        }
    }
}

module supports()
{
    width = 10;
    height = 15;
    translation = 45;
    for( x_translation = [-translation, translation] )
    {
        for( y_translation = [-translation, translation] )
        {
            translate([x_translation - width/2, y_translation -width/2, 0])
            difference()
            {
                cube([width, width, height]);
                
                translate([width/2, width/2, 0])
                cylinder(d=3.2, h=height);
            }
        }
    }
}

module base_plate( thickness=4.5, bottom_thickness=4, radius=210/2, wall_height=35, wall_thickness=3, edge_thickness=1.3, edge_height=3 )
{
    difference()
    {
        union()
        {
            // bottom base
            difference()
            {
                dodecagon_prism_rotated(height=bottom_thickness, radius=radius);
                tarot_680_base_plate_void_holes(thickness);
            }
            
            // top base
            translate([0, 0, bottom_thickness])
            dodecagon_prism_rotated(height=thickness-bottom_thickness, radius=radius);
        }
        union()
        {
            tarot_680_base_plate_screw_holes(thickness);
            
//            cylinder(d=21, h=thickness);
        }
    }
}

module top(radius=205/2, height=70, wall_thickness=3, wall_height=5, edge_thickness=1.8, edge_height=3 )
{
    difference()
    {
        union()
        {
            // edge
            difference()
            {
                dodecagon_prism_rotated(height=edge_height, radius=radius);
                dodecagon_prism_rotated(height=edge_height, radius=radius-(wall_thickness-edge_thickness));
            }
            
            // main canopy
            difference()
            {
                hull()
                {
                    // wall
                    translate([0, 0, edge_height])
                    dodecagon_prism_rotated(height=wall_height, radius=radius);
                    
                    translate([0, 0, edge_height - wall_height + 70])
                    dodecagon_prism_rotated(height=wall_height, radius=radius/1.2);
                }
                
                hull()
                {
                    // wall
                    translate([0, 0, edge_height])
                    dodecagon_prism_rotated(height=wall_height, radius=radius-wall_thickness);
                    
                    translate([0, 0, edge_height - wall_height + 70])
                    dodecagon_prism_rotated(height=wall_height-wall_thickness, radius=(radius/1.2)-wall_thickness);
                }
            }
        }
        union()
        {
            translate([0, 0, edge_height - wall_thickness + 70])
            cylinder(d=15, h=wall_thickness);
        }
    }
}

module battery_holder_bottom()
{
    battery_length      = 180;
    battery_side_length = 70;
    thickness           = 10;
    
    translate([0, 0, battery_side_length])
    rotate([90, 90, 0])
    hull()
    {
        roundedCube([thickness, battery_side_length + thickness, battery_length], 5, true, true);
        translate([thickness/2, 0, 0])
        cube([1, battery_side_length + thickness, battery_length], true);
    }
}

module battery_holder()
{
    battery_length      = 180;
    battery_side_length = 70;
    thickness           = 10;
    
    strap_gap_thickness = 5;
    strap_length = 30;
    
    num_screws_per_side = 5;
    num_screws_per_front_side = 3;
    
    threaded_insert_diameter = 4;
    threaded_insert_height = 6;
    
    // walls
    for( x_translation = [-battery_side_length/2, battery_side_length/2] )
    {
        difference()
        {
            
            translate([x_translation, 0, battery_side_length/2])
            cube([thickness, battery_length, battery_side_length], true);
            
            union()
            {
                y_translation_increment = battery_length / num_screws_per_side;
                translate( [0, -battery_length / 2 - y_translation_increment/2, 0 ])
                for( y_translation = [ 1 : num_screws_per_side ] )
                {
                    translate( [ x_translation, y_translation * y_translation_increment, battery_side_length - threaded_insert_height] )
                    cylinder(d=threaded_insert_diameter, h=threaded_insert_height);
                }
                
//                y_translation = battery_length / 2;
                z_translation_increment = battery_side_length / num_screws_per_front_side;
                translate([0, 0, -z_translation_increment/2])
                for( y_translation = [ -battery_length / 2, battery_length / 2] )
                for( z_translation = [ 1 : num_screws_per_front_side ] )
                {
                    rotation = 90;
                    
                    translate([x_translation, y_translation, z_translation * z_translation_increment])
                    rotate( [ sign(y_translation)*rotation, 0, 0 ] )
                    cylinder(d=threaded_insert_diameter, h=threaded_insert_height);
                }
                
                screw_clearance = 7.5;
                for( y_translation = [ -73, 73 ] )
                {
                    translate([0, y_translation, screw_clearance / 2])
                    cube([100, 7.5, screw_clearance], true);
                }
                
                // velcro strip slits
                clearance = 5;
                lower_clearance = 10;
                translation = 30;
                length = 30;
                for( y_translation = [-translation, translation] )
                {
                    translate([0, y_translation, clearance/2])
                    cube([battery_side_length + 2*thickness, length, clearance], true);
                    
                    translate([0, y_translation, 50 + lower_clearance/2])
                    cube([battery_side_length + 2*thickness, length, lower_clearance], true);
                }
            }
        }
    }
    
    // velcro strap 
   
    
//    translate([-battery_side_length/2 - thickness, -battery_length/2, -4.5])
//    difference()
//    {
//        union()
//        {
//            // holder
//            cube([battery_side_length + thickness*2, battery_length, battery_side_length + thickness*2]);
////            roundedCube([battery_side_length + thickness*2, battery_length, battery_side_length + thickness*2], 5, false, false);
////            roundedCube([battery_side_length + thickness*2, battery_length, 5], 5, false, false);
//        }
//        
//        union()
//        {
//            // cavity
//            translate([thickness, 0, thickness])
//            cube([battery_side_length, battery_length, battery_side_length]);
//            
//            // velcro strip slits
//            translation = 30;
//            length = 30;
//            for( y_translation = [-translation, translation] )
//            {
//                translate([0, battery_length/2 + y_translation -length/2, thickness])
//                cube([battery_side_length + 2*thickness, length, 5]);
//            }
//        }
//    }
}

module bottom_component_mounting_plate()
{
    difference()
    {
        union()
        {
            translate([0, 0, -4.5])
            base_plate();

            battery_holder();
        }
        union()
        {
            tarot_680_base_plate_screw_holes(10);
        }
    }
}

bottom_component_mounting_plate();

//translate([0, 0, 20])
//battery_holder_bottom();
