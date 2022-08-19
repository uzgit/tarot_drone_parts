$fn=20;

module pad()
{
    diameter = 50;
    z = 7.5;
    leg_support_diameter = 20;
    leg_support_length = 20;
    leg_void_diameter = 16;
    leg_angle = 15;
    
    difference()
    {
        union()
        {
            // the pad itself
//            translate([0, 0, -10])
            cylinder(d=diameter,h=z);
            
            // leg support
            rotate([-leg_angle, 0, 0])
            translate([0, 0, z/2])
            cylinder(d=leg_support_diameter, h=leg_support_length);
        }
        union()
        {
            rotate([-leg_angle, 0, 0])
            translate([0, 0, z/2])
            cylinder(d=leg_void_diameter, h=leg_support_length + 1);
            
            for( x_translation = [15, -15] )
            {
                translate([x_translation, 0, z ])
                rotate([180, 0, 0])
                {
                    // threaded insert
                    cylinder(d=4, h=6);
                    
                    // screw void
                    cylinder(d=3.2, h=10);
                }
            }
        }
    }
}

module spike_pad_linear()
{
    diameter = 55;
    z = 2;
    cone_diameter = 6;
    cone_height = 5;
    
    cylinder(d=diameter, h=z);
    translate([0, 0, z])
//    cylinder(h=cone_height, d1=cone_diameter, d2=0);
    for(x_translation = [ -diameter/2 : cone_diameter+1 : diameter/2 ] )
    {
        for(y_translation = [ -diameter/2 : cone_diameter : diameter/2 ] )
        {
            if( sqrt( x_translation*x_translation + y_translation*y_translation) < diameter/2 - cone_diameter/2 - 1)
            {
            translate([x_translation, y_translation, 0])
            cylinder(h=cone_height, d1=cone_diameter, d2=0);
            }
        }
    }
}

module spike_pad_radial()
{
    diameter = 55;
    z = 2;
    cone_diameter = 6;
    cone_height = 5;
    
    cylinder(d=diameter, h=z);
    translate([0, 0, z])
//    cylinder(h=cone_height, d1=cone_diameter, d2=0);
    for(x_translation = [ -diameter/2 : cone_diameter+1 : diameter/2 ] )
    {
        for(y_translation = [ -diameter/2 : cone_diameter : diameter/2 ] )
        {
            if( sqrt( x_translation*x_translation + y_translation*y_translation) < diameter/2 - cone_diameter/2 - 1)
            {
            translate([x_translation, y_translation, 0])
            cylinder(h=cone_height, d1=cone_diameter, d2=0);
            }
        }
    }
}

//pad();

spike_pad_radial();