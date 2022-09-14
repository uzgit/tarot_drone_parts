include <../library/tarot680Modules.scad>
include <../library/shapes.scad>
include <../library/regular_shapes.scad>
include <../library/roundCornersCube.scad>
include <../library/nuts_and_bolts.scad>
include <../library/lib-gear-dh.scad>
include <../library/boxes.scad>

$fn = 120;

x = 132;
y = 34;

screw_x_translation = 124;
screw_y_translation = 25.5;

module rounded_square( width, radius_corner ) {
	translate( [ radius_corner, radius_corner, 0 ] )
		minkowski() {
			square( width - 2 * radius_corner );
			circle( radius_corner );
		}
}

module rounded_rectangle(x=x, y=y, radius=2)
{
    difference()
    {
        hull()
        {
            translate([radius, radius, 0])
            circle(d=2*radius);
            
            translate([x-radius, radius, 0])
            circle(d=2*radius);
            
            translate([radius, y-radius, 0])
            circle(d=2*radius);
            
            translate([x-radius, y-radius, 0])
            circle(d=2*radius);
        }
        
        union()
        {
            translate([x/2, y/2, 0])
            
            for(x_translation = [-screw_x_translation/2, screw_x_translation/2])
            for(y_translation = [-screw_y_translation/2, screw_y_translation/2])
                translate([x_translation, y_translation, 0])
                circle(d=3.2);
        }
    }
}

rounded_rectangle();