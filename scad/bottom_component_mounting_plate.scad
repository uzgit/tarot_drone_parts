include <../library/regular_shapes.scad>
include <../library/boxes.scad>
include <../library/nuts_and_bolts.scad>

$fn=20;

module servo(width=41.5, depth=42, height=20, mount_width=6, mount_depth=60, extend=false, holes=true)
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
        
//        if( holes )
//        {
////            translate([height/2, 0, 0])
//            for( y_translation = [-10/2, 10/2] )
//            {
//                for(z_translation = [ -47.5/2, 47.5/2 ])
//                {
//                    translate([y_translation, 0, z_translation])
//                    rotate([90, 0, 0])
//                    cylinder(d=4, h=600);
//                }
//            }
//        }
    }
    
    if( extend )
    {
        translate([0, -depth/2, -height/2])
        cube([width, depth, height], center=false);
    }
    

}

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

//module battery_holder_bottom()
//{
//    battery_length      = 180;
//    battery_side_length = 85;
//    thickness           = 10;
//    
//    translate([0, 0, battery_side_length])
//    rotate([90, 90, 0])
//    hull()
//    {
//        roundedCube([thickness, battery_side_length + thickness, battery_length], 5, true, true);
//        translate([thickness/2, 0, 0])
//        cube([1, battery_side_length + thickness, battery_length], true);
//    }
//}

module battery_holder_bottom()
{
    battery_length      = 180;
    battery_side_length = 70;
    width = 85;
    thickness           = 10;
    
    difference()
    {
        translate([0, 0, battery_side_length])
        rotate([90, 90, 0])
        hull()
        {
            roundedCube([thickness, width + thickness, battery_length], 5, true, true);
            translate([thickness/2, 0, 0])
            cube([1, width + thickness, battery_length], true);
        }
        
        union()
        {
            
            translate([0, 0, battery_side_length])
            for( x_translation = [-width/2, width/2] )
            {
                y_translation_abs = width + thickness/2;
                for( y_translation = [-y_translation_abs, y_translation_abs] )
                {
                    translate([x_translation, y_translation, 0])
                    rotate([90*sign(y_translation), 0, 0])
                    cylinder(d=4, h=6, center=false);
                }
            }
        
                num_screws_per_side = 5;
                y_translation_increment = battery_length / num_screws_per_side;
                translate( [0, -battery_length / 2 - y_translation_increment/2, battery_side_length ])
                for( x_translation = [-width/2, width/2] )
                for( y_translation = [ 1 : num_screws_per_side ] )
                {
                    translate( [ x_translation, y_translation * y_translation_increment, -thickness+4] )
                    {
                        cylinder(d=3.2, h=thickness+1, center=false);
                        
                        translate([0, 0, 6])
                        cylinder(d=6.5, h=10, center=false);
                    }
                }
        }
    }
}

module battery_holder()
{
    battery_length      = 180;
    battery_side_length = 70;
    width = 85;
    thickness           = 10;
    
    strap_gap_thickness = 5;
    strap_length = 30;
    
    num_screws_per_side = 5;
    num_screws_per_front_side = 3;
    
    threaded_insert_diameter = 4;
    threaded_insert_height = 6;
    
    // walls
    for( x_translation = [-width/2, width/2] )
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
                    cube([width + 2*thickness, length, clearance], true);
                    
                    translate([0, y_translation, 53 + lower_clearance/2])
                    cube([width + 2*thickness, length, lower_clearance], true);
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

module plain_front()
{
    battery_side_length = 70;
    width = 95;
    thickness           = 10;
    
    height = battery_side_length + thickness;
    threaded_insert_diameter = 4;
    threaded_insert_height = 6;
    
    difference()
    {
        hull()
        {            
            translate([-width/2, -10, 0])
            roundedCube([width, thickness, height], 5, center=false);
            
            translate([-width/2, 0, 0])
            union()
            {
//                cube([width, 1, height-4.5], center=false);
                
//                translate([-width/2, 1, 70])
                rotate([90, 0, 0])
                roundedCube([width, height, 1], 5, true, center=false);
            }
        }
        
        union()
        {
            y_translation = -thickness;
            z_translation_increment = battery_side_length / 3;
            translate([0, 0, -z_translation_increment/2])
            for( x_translation = [-(width-thickness)/2, (width-thickness)/2] )
            for( z_translation = [ 1 : 3 ] )
            {
                rotation = -90;
                
                translate([x_translation, y_translation, z_translation * z_translation_increment])
                rotate( [ rotation, 0, 0 ] )
                {
                    cylinder(d=3.2, h=15);
                    cylinder(d=6.5, h=5);
                }
            }
            
            z_translation = height - 5;
            y_translation = -thickness;
            for( x_translation = [-(width-thickness)/2, (width-thickness)/2] )
            {
                rotation = -90;
                
                translate([x_translation, y_translation, z_translation])
                rotate( [ rotation, 0, 0 ] )
                {
                    cylinder(d=3.2, h=15);
                    cylinder(d=6.5, h=5);
                }
            }
            
            translate([0, 0, 40])
            rotate([0, 90, 0])
            servo();
            
            translate([0, 0, 40])
            for( x_translation = [-10/2, 10/2] )
            {
                for(z_translation = [ -47.5/2, 47.5/2 ])
                {
                    translate([x_translation, 0, z_translation])
                    rotate([90, 0, 0])
                    union()
                    {
                        cylinder(d=4, h=6);
                        cylinder(d=3.2, h=10);
                    }
                }
            }
        }
    }
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
            tarot_680_base_plate_screw_holes(5);
        }
    }
}

module front_cover_gimbal()
{
    battery_side_length = 70;
    width = 95;
    thickness           = 10;
    
    height = battery_side_length + thickness;
    threaded_insert_diameter = 4;
    threaded_insert_height = 6;
    
    difference()
    {
        union()
        {
            hull()
            {            
                translate([-width/2, -10, 0])
                roundedCube([width, thickness, height], 5, center=false);
                
                translate([-width/2, 0, 0])
                union()
                {
    //                cube([width, 1, height-4.5], center=false);
                    
    //                translate([-width/2, 1, 70])
                    rotate([90, 0, 0])
                    roundedCube([width, height, 1], 5, true, center=false);
                }
                
                
            }

        }
        
        union()
        {
            y_translation = -thickness;
            z_translation_increment = battery_side_length / 3;
            translate([0, 0, -z_translation_increment/2])
            for( x_translation = [-(width-thickness)/2, (width-thickness)/2] )
            for( z_translation = [ 1 : 3 ] )
            {
                rotation = -90;
                
                translate([x_translation, y_translation, z_translation * z_translation_increment])
                rotate( [ rotation, 0, 0 ] )
                {
                    cylinder(d=3.2, h=15);
                    cylinder(d=6.5, h=5);
                }
            }
            
            z_translation = height - 5;
            y_translation = -thickness;
            for( x_translation = [-(width-thickness)/2, (width-thickness)/2] )
            {
                rotation = -90;
                
                translate([x_translation, y_translation, z_translation])
                rotate( [ rotation, 0, 0 ] )
                {
                    cylinder(d=3.2, h=15);
                    cylinder(d=6.5, h=5);
                }
            }
            
            translate([0, 0, 70])
            rotate([90, 0, 0])
            {
                cylinder(d=4.5, h=thickness);
//                nutHole(4); // screw goes the other way actually
            }
            
            translate([0, 0, 70])
            rotate([0, -15, 0])
            translate([-41.5/2+10, 0, -34.5])
            rotate([0, 90, 0])
            {
                rotate([0, 90, 0])
                
                servo();
                
                for( x_translation = [-10/2, 10/2] )
                {
                    for(z_translation = [ -47.5/2, 47.5/2 ])
                    {
                        translate([x_translation, 0, z_translation])
                        rotate([90, 0, 0])
                        union()
                        {
                            cylinder(d=4, h=6);
                            cylinder(d=3.2, h=10);
                        }
                    }
                }
            }
        }
    }
}

//bottom_component_mounting_plate();
//
//translate([0, 0, 5])
//translate([0, 0, 15])
//battery_holder_bottom();

//translate([0, -100, 0])
front_cover_gimbal();

    