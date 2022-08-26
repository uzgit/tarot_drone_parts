include <../library/PiHoles.scad>

$fn=20;

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

module support_mount_voids(height=2)
{
    inner_width = 10;
    translation = 45;
    for( x_translation = [-translation, translation] )
    {
        for( y_translation = [-translation, translation] )
        {
            translate([x_translation, y_translation, 0])
            translate([-inner_width/2, -inner_width/2, 0])
            cube([inner_width, inner_width, height]);
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
            cylinder(d=3.2, h=4);
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
            
            translate([3, -15.5, 55])
            raspberry_pi_mount();
//            support_mounts();
            
            translate([65, 0, 0])
            herelink_mount();
            
            translate([0, 42.25+45, 4])
            bec_mount();
        }
        union()
        {
            center_hole();
            support_mount_screw_voids();
            support_mount_voids();
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
            cylinder(d=3, h=4);
        }
    }
}

module center_hole()
{
    side_length = 60;
    
    translate([-side_length/2, -side_length/2, 0])
    cube([side_length, side_length, 10]);
}

module raspberry_pi_mount()
{
    x = 65;
    y = 65;
    z = 3;
    thickness = z;
    support_height = 24;
    
    translate([-x/2+2, -y/2+5, 9])
    rotate([-70, 0, 90])
    union()
    {
        difference()
        {
        cube([x, y, thickness]);
        
//            translate([56, 0, 0])
//            rotate([0, 0, 90])
        translate([0, 0, thickness])
        piHoles("3B", depth = thickness);
        }
        
        translate([x/2, y/2+20, -support_height/2 + 3])
        rotate([-30, 180, 0])
        cube([15, thickness, support_height], center=true);
    }
}

module herelink_mount()
{
    wall_thickness = 3;
    bottom_thickness = 4;
    
    x = 15.5;
    y = 79;
    z = 20;
    
    translate([0, 0, z/2])
    difference()
    {
        cube([x + wall_thickness*2, y, z], center=true);
        cube([x, y, z], center=true);
    }
    
    translate([0, 0, bottom_thickness/2])
    cube([x, y, bottom_thickness], center=true);
}

module bec_mount()
{
    x = 45;
    y = 3;
    z = 30;
    
    translate([0, -25/2, -4/2])
    cube([x, 25+3, 4], center=true);
    
    translate([0, 0, z/2])
    cube([x, y, z], center=true);
}

component_mounting_plate();