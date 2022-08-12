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

dodecagon_prism_rotated(height=3, radius=205/2);
tarot_680_base_plate_void_holes(thickness);