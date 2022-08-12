$fn=60;

depth = 105;
base_height = 10;
base_width = 30;

vertical_bracket_height = 25;
vertical_bracket_width = 100;
vertical_bracket_depth = 20;

//mounting_screw_depths = [8, 20, 45, 71, 97];
mounting_screw_depths = [8, 20, 45, 97];

module base()
{
    translate([-base_width/2, 0, 0])
    cube([base_width, depth, base_height]);
}

module screw_holes()
{
    for( y_translation = mounting_screw_depths )
    {
        translate([0, y_translation, 0])
        cylinder(d=3.2, h=base_height);
    }
    
    translate([0, mounting_screw_depths[3], 0])
    cylinder(d=4.2, h=base_height);
}

module screw_holes_2()
{
    
    
    x_translations1 = [-40, 0, 40];
    x_translations2 = [-20, 20];
    z_translation2 = 18.3;
    z_translation1 = 26.6;
    
    for( x_translation = x_translations1 )
    {
        translate([x_translation, 0, z_translation1])
        rotate([-90, 0, 0])
        cylinder(d=4.2, h=100);
    }
    
        for( x_translation = x_translations2 )
    {
        translate([x_translation, 0, z_translation2])
        rotate([-90, 0, 0])
        cylinder(d=4.2, h=100);
    }
}

module vertical()
{
    translate([-vertical_bracket_width/2, 52, 0])
    cube([vertical_bracket_width, vertical_bracket_depth, base_height + vertical_bracket_height]);
}

difference()
{
    union()
    {
        base();
        vertical();
    }
    union()
    {
        screw_holes();
        screw_holes_2();
    }
    
}
