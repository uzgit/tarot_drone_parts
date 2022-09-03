include <../library/regular_shapes.scad>
include <../library/boxes.scad>
//roundedCube([

loft_height=4.5;

$fn=120;

//cylinder(d=31, h=2);

module stand_threaded_insert_holes(height)
{
    for( x_translation = [-10, 10 ] )
    for( y_translation = [-10, 10 ] )
        translate([ x_translation, y_translation, 0 ])
        {
            cylinder(d=3.2, h=height-6);
            translate([0, 0, height-6])
            cylinder(d=4, h=6);
        }
}

//module base(diameter=40, thickness = 10, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=35)
//{
//    difference()
//    {
//        union()
//        {
//            cylinder(d=diameter, h=thickness);
//            
//            translate([0, 0, thickness])
//            difference()
//            {
//                union()
//                {
//                    cylinder(d=stand_diameter, h=stand_height);
//                }
//                union()
//                {
//                    cylinder(d=stand_diameter-2*stand_thickness, h=stand_height);
//                }
//            }
//            
//            translate([0, 0, thickness+stand_height])
//            difference()
//            {
//                hull()
//                {
//                    width = 20 + stand_diameter/2;
//                    height = 10;
//                    
//                    cylinder(d=stand_diameter, h=1);
//                    
//                    translate([0, 0, intermediate_mount_height-1])
//                    cylinder(d=30, h=1);
//                    
//                    translate([10, 0, intermediate_mount_height-1])
//                    cylinder(d=30, h=1);
//                }
//                
//                translate([0, 0, intermediate_mount_height-10])
//                union()
//                {
//                    cylinder(d=stand_diameter-2*stand_thickness, h=stand_height);
//                    
//                    translate([18.75-5, 0, 0])
//                    for( y_translation = [-5, 5] )
//                    {
//                        translate([0, y_translation, 9])
//                        {
//                            cylinder(d=4, h=6);
//                        }
//                    }
//                    
//                    translate([-9.5, 0, 9])
//                    cylinder(d=4, h=6);
//                }
//            }
//        }
//        union()
//        {
//            // screw/insert holes
//            stand_threaded_insert_holes(thickness);
//            
//            // center hole
//            cylinder(d=center_hole_diameter, h=thickness);
//        }
//    }
//}

module base(diameter=40, thickness = 10, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=35, outer_diameter=69)
{
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=thickness);
            
            translate([0, 0, thickness])
            difference()
            {
                union()
                {
                    cylinder(d=stand_diameter, h=stand_height);
                }
                union()
                {
                    cylinder(d=stand_diameter-2*stand_thickness, h=stand_height);
                }
            }
            
            translate([0, 0, thickness+stand_height])
            difference()
            {
                hull()
                {
                    cylinder(d=stand_diameter, h=1);
                    
                    translate([15, 0, intermediate_mount_height-1])
                    cylinder(d=30, h=1);
                    
                    translate([-15, 0, intermediate_mount_height-1])
                    cylinder(d=30, h=1);
                }
                hull()
                {
                    cylinder(d=stand_diameter, h=1);
                    
                    translate([15, 0, intermediate_mount_height-1])
                    cylinder(d=25, h=1);
                    
                    translate([-15, 0, intermediate_mount_height-1])
                    cylinder(d=25, h=1);
                }
//                translate([0, 0, intermediate_mount_height-10])
//                union()
//                {
//                    cylinder(d=stand_diameter-2*stand_thickness, h=stand_height);
//                    
//                    translate([18.75-5, 0, 0])
//                    for( y_translation = [-5, 5] )
//                    {
//                        translate([0, y_translation, 9])
//                        {
//                            cylinder(d=4, h=6);
//                        }
//                    }
//                    
//                    translate([-9.5, 0, 9])
//                    cylinder(d=4, h=6);
//                }
            }
        }
        union()
        {
            // screw/insert holes
            stand_threaded_insert_holes(thickness);
            
            // center hole
            cylinder(d=center_hole_diameter, h=thickness);
        }
    }
}

module stand(inner_diameter=32, outer_diameter=69, height=4.5, thickness = 3, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=15, base_height=5, )
{
    main_cylinder_height=height+base_height+1;
    difference()
    {
        union()
        {
            cylinder(d=85, h=main_cylinder_height);
        }
        
        union()
        {
            // the contour around the GPS module itself
            translate([0, 0, base_height])
            hull()
            {
                cylinder(d=inner_diameter, h=1);
                
                translate([0, 0, height-1])
                cylinder(d=outer_diameter, h=1);
                
                translate([0, 0, 50])
                cylinder(d=outer_diameter, h=1);
            }
            
            // cutting off the sides to expose the lights
            side = 500;
            y_translation_abs = inner_diameter/2 + side/2;
            translate([0, 0, thickness])
            for( y_translation = [-y_translation_abs, y_translation_abs] )
            {
                
                translate([0, y_translation, 0])
                cube([side, side, side], center=true);
            }
            
//            x_translation_abs_ = 30;
//            for( x_translation = [0, -x_translation_abs_, x_translation_abs_] )
//            {
//                translate([x_translation, 0, 0])
//                {
//                    cylinder(d=3.2, h=height + base_height);
//                    
//                    translate([0, 0, 3])
//                    cylinder(d=6, h=main_cylinder_height);
//                }
//            }
            
            // cube for the antenna
            translate([-20, 0, 0])
            {
                translate([0, 0, height/2])
                cube([12, 12, height + base_height], center=true);
            }
            
            for( x_translation_ = [-(outer_diameter/2 + 4), outer_diameter/2 + 4] )
            {
                translate([x_translation_, 0, 0])
                {
                    cylinder(d=4, h=6);
                    
                    translate([0, 0, 6])
                    cylinder(d=3.2, h=10);
                }
            }
        }
    }
    
    gps_tab_thickness = 6.25;
    gps_tab_gap = 14.5;
    translation_y_abs = (gps_tab_thickness + gps_tab_gap)/2;
    translate([0, 0, base_height])
    for( translation_y = [-translation_y_abs, translation_y_abs])
    {
        translate([0, translation_y, 3.5/2])
        cube([gps_tab_thickness, gps_tab_thickness, 3.5], center=true);
    }
}

module top(inner_diameter=32, outer_diameter=69, height=4.5, thickness = 3, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=15, base_height=5)
{
    difference()
    {
        cylinder(d=85, h=height+base_height-1+8.5);
        
        union()
        {
            translate([0, 0, base_height])
            hull()
            {
                cylinder(d=inner_diameter, h=1);
                
                translate([0, 0, height-1])
                cylinder(d=outer_diameter, h=1);
                
                translate([0, 0, 50])
                cylinder(d=outer_diameter, h=1);
            }
            
            side = 500;
            y_translation_abs = inner_diameter/2 + side/2;
            translate([0, 0, thickness])
            for( y_translation = [-y_translation_abs, y_translation_abs] )
            {
                
                translate([0, y_translation, 0])
                cube([side, side, side], center=true);
            }
            
            x_translation_abs = outer_diameter/2 + 4;
            for( x_translation = [-x_translation_abs, x_translation_abs] )
            {
                translate([x_translation, 0, 0])
                cylinder(d=3.2, h=height+base_height-1+8.5);
            }
        }
    }
}

//base();
//
//translate([0, 0, 75])
//stand();

//translate([0, 0, 130])
//rotate([180, 0, 0])
top();