include <../library/regular_shapes.scad>
include <../library/boxes.scad>
//roundedCube([

loft_height=4.5;

$fn=20;

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

module base(diameter=40, thickness = 10, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=15)
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
                    width = 20 + stand_diameter/2;
                    height = 10;
                    
                    cylinder(d=stand_diameter, h=1);
    //                translate([-8, -8, 10])
//                    translate([8.5, 0, intermediate_mount_height-1])
//                    {
//                        roundedCube([25+stand_diameter/2, 16, 1], 8, true, center=true);
//                    }
                    
                    translate([0, 0, intermediate_mount_height-1])
                    cylinder(d=30, h=1);
                    
                    translate([10, 0, intermediate_mount_height-1])
                    cylinder(d=30, h=1);
                }
                
                union()
                {
                    cylinder(d=stand_diameter-2*stand_thickness, h=stand_height);
                    
                    translate([18.75-5, 0, 0])
                    for( y_translation = [-5, 5] )
                    {
                        translate([0, y_translation, 9])
                        {
                            cylinder(d=4, h=6);
                        }
                    }
                    
                    translate([-9.5, 0, 9])
                    cylinder(d=4, h=6);
                }
                
//                hull()
//                {
//                    width = 20 + stand_diameter/2;
//                    height = 10;
//                    
//                    cylinder(d=stand_diameter-2*stand_thickness, h=intermediate_mount_height);
//    //                translate([-8, -8, 10])
//                    translate([8.5, 0, intermediate_mount_height-1])
//                    roundedCube([25, 10, 1], 5, true, center=true);
////                    cube([5, 2, 1], center=true);
//                }
            }
            
            
            
//            gps_tab_thickness = 6.25;
//            gps_tab_gap = 14.5;
//            y_translation_abs = (gps_tab_thickness + gps_tab_gap)/2;
//            translate([0, 0, thickness+stand_height+intermediate_mount_height])
//            for( y_translation = [-y_translation_abs, y_translation_abs])
//            {
//                translate([18.75, y_translation, 0])
//                cube([gps_tab_thickness, gps_tab_thickness, 3.5], center=true);
//            }
            
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

module stand(inner_diameter=32, outer_diameter=68, height=4.5, thickness = 3, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=15, base_height=5)
{
    
    translate([18.75, 0, 0])
    difference()
    {
//        cylinder(d=72, h=height + base_height);
        
//        translate([0, 0, thickness])
//        hull()
//        {
//            cylinder(d=inner_diameter + 2*thickness, h=1);
//            
//            translate([0, 0, height-1 + thickness])
//            cylinder(d=outer_diameter + 2*thickness, h=1);
//        }
        
//        cylinder(d=outer_diameter + 2*thickness, h=height+base_height);
        cylinder(d=85, h=height+base_height);
        
        union()
        {
            translate([0, 0, base_height])
            hull()
            {
                cylinder(d=inner_diameter, h=1);
                
                translate([0, 0, height-1])
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
            
            for( y_translation = [-5, 5] )
            {
                translate([0, y_translation, 0])
                {
                    cylinder(d=3.2, h=height + base_height);
                    
                    translate([0, 0, 3])
                    cylinder(d=6, h=height + base_height - 3);
                }
            }
            
            translate([-18.75, 0, 0])
            translate([-9.5, 0, 0])
            {
                cylinder(d=3.2, h=20);
                translate([0, 0, 3])
                cylinder(d=6, h=height + base_height - 3);
            }
            
            translate([-18.75, 0, 0])
            cylinder(d=stand_diameter-2*stand_thickness, h=height + base_height);
            
            x_translation_abs = outer_diameter/2 + 4;
            translate([0, 0, height+base_height])
            for( x_translation = [-x_translation_abs, x_translation_abs] )
            {
                translate([x_translation, 0, 0])
                rotate([180, 0, 0])
                cylinder(d=4, h=6);
            }
        }
    }
//    difference()
//    {
//        hull()
//        {
//            
//            cylinder(d=stand_diameter, h=1);
////            translate([0, 0, 0.5])
////            roundedCube([25+stand_diameter/2, 16, 1], 8, true, center=true);
//            
//            translate([18.75, 0, 0])
//            cylinder(d=diam, h=1);
//            
//            translate([18.75, 0, height])
//        }
//        cylinder(d=stand_diameter-2*stand_thickness, h=1);
//    }
}

module top(inner_diameter=32, outer_diameter=68, height=4.5, thickness = 3, center_hole_diameter=10, stand_height=30, stand_diameter=16, stand_thickness=3, intermediate_mount_height=15, base_height=5)
{
    
    translate([18.75, 0, 0])
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
            translate([0, 0, height+base_height])
            for( x_translation = [-x_translation_abs, x_translation_abs] )
            {
                translate([x_translation, 0, 0])
                rotate([180, 0, 0])
                cylinder(d=3.2, h=6);
            }
        }
    }
}

base();

translate([0, 0, 70])
stand();

translate([0, 0, 110])
rotate([180, 0, 0])
top();