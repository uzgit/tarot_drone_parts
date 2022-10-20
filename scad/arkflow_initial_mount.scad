$fn=120;

side_length = 30;
height = 2;
standoff_height = 6;
hole_translation = 24;

translate([0, 0, -height/2])
cube([side_length,side_length,height], center=true);

for( x_translation = [-hole_translation/2, hole_translation/2] )
    for( y_translation = [-hole_translation/2, hole_translation/2] )
    {
        translate([x_translation, y_translation])
        difference()
        {
            cylinder(d=6, h=standoff_height);
            cylinder(d=4, h=standoff_height);
        }
    }