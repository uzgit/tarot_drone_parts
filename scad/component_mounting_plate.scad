$fn=120;

module support_mounts()
{
    width = 20;
    inner_width = 10;
    
    height = 4;
    
    translation = 45;
    for( x_translation = [-translation, translation] )
    {
        for( y_translation = [-translation, translation] )
        {
            translate([x_translation, y_translation, -height])
            difference()
            {
                translate([-width/2, -width/2, 0])
                cube([width, width, height]);
                
                translate([-inner_width/2, -inner_width/2, 0])
                cube([inner_width, inner_width, height]);
            }
        }
    }
}

module support_mount_screw_voids()
{
    translation = 45;
    for( x_translation = [-translation, translation] )
    {
        for( y_translation = [-translation, translation] )
        {
            translate([x_translation, y_translation, 0])
            cylinder(d=2.7, h=4);
        }
    }
}

module component_mounting_plate()
{
    base_side_length = 125;
    thickness = 4;
    
    difference()
    {
        union()
        {
            translate([-base_side_length/2, -base_side_length/2, 0])
            cube([base_side_length, base_side_length, thickness]);
            
            support_mounts();
            
        }
        union()
        {
            center_hole();
            support_mount_screw_voids();
            pixhawk_holes();
        }
    }
}

module pixhawk_holes()
{
    z_translation = 0;
    for( x_translation = [-17, 17] )
    {
        for( y_translation = [-42.25, 42.25] )
        {
            translate([x_translation, y_translation, z_translation])
            cylinder(d=2.7, h=4);
        }
    }
}

module center_hole()
{
    side_length = 60;
    
    translate([-side_length/2, -side_length/2, 0])
    cube([side_length, side_length, 4]);
}

component_mounting_plate();
