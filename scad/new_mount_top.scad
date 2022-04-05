include <../library/regular_shapes.scad>

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

module base_plate( thickness=3.5, bottom_thickness=2, radius=198/2, wall_height=15, wall_thickness=3, edge_thickness=1.5, edge_height=1.5 )
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
            
            // wall
            translate([0, 0, thickness])
            difference()
            {
                dodecagon_prism_rotated(height=wall_height, radius=radius);
                dodecagon_prism_rotated(height=wall_height, radius=radius-wall_thickness);
            }
            
            // edge
            translate([0, 0, thickness+wall_height])
            difference()
            {
                dodecagon_prism_rotated(height=edge_height, radius=radius-wall_thickness+edge_thickness);
                dodecagon_prism_rotated(height=edge_height, radius=radius-wall_thickness);
            }
        }
        union()
        {
            tarot_680_base_plate_screw_holes(thickness);
            
            cylinder(d=15, h=thickness);
        }
    }
}

//module top(radius=198/2, height=70, wall_thickness=3, wall_height=5, edge_thickness=1.5, edge_height=1.5 )
//{
//    // edge
//    difference()
//    {
//        dodecagon_prism_rotated(height=edge_height, radius=radius);
//        dodecagon_prism_rotated(height=edge_height, radius=radius-(wall_thickness-edge_thickness));
//    }
//    
//    // wall
//    translate([0, 0, edge_height])
//    difference()
//    {
//        dodecagon_prism_rotated(height=wall_height, radius=radius);
//        dodecagon_prism_rotated(height=wall_height, radius=radius-wall_thickness);
//    }
//}

module top(radius=205/2, height=70, wall_thickness=3, wall_height=5, edge_thickness=1.8    , edge_height=3 )
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
            cylinder(d=21, h=wall_thickness);
        }
    }
}

//base_plate();
//
//translate([0, 0, 50])
top();
