$fn=20;

module pad()
{
    diameter = 50;
    z = 7;
    leg_support_diameter = 20;
    leg_support_length = 20;
    leg_void_diameter = 16;
    leg_angle = 15;
    
    lock_z = 10;
    
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
            {
                cylinder(d=leg_support_diameter, h=leg_support_length);
                
                translate([0, 13.5, 15])
                rotate([0, 90, 0])
                {
                    difference()
                    {
                        hull()
                        {
                            translate([0, -10, 0])
                            cube([10, 20, 7], center=true);
                            cylinder(d=10, h=7, center=true);
                        }
                        cylinder(d=3.2, h=7, center=true);
                    }
                }
            }
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
            
            translate([-0.5, 0, z])
            cube([1, diameter/2, leg_support_length]);
        }
    }
}

//module spike_pad_linear()
//{
//    diameter = 55;
//    z = 2;
//    cone_diameter = 6;
//    cone_height = 5;
//    
//    cylinder(d=diameter, h=z);
//    translate([0, 0, z])
////    cylinder(h=cone_height, d1=cone_diameter, d2=0);
//    for(x_translation = [ -diameter/2 : cone_diameter+1 : diameter/2 ] )
//    {
//        for(y_translation = [ -diameter/2 : cone_diameter : diameter/2 ] )
//        {
//            if( sqrt( x_translation*x_translation + y_translation*y_translation) < diameter/2 - cone_diameter/2 - 1)
//            {
//            translate([x_translation, y_translation, 0])
//            cylinder(h=cone_height, d1=cone_diameter, d2=0);
//            }
//        }
//    }
//}

module spike_pad_radial()
{
    diameter = 50;
    z = 2;
    cone_diameter = 6;
    cone_height = 5;
    
    cylinder(d=diameter, h=z);
    translate([0, 0, z])
    for( radius = [ 0 : cone_diameter/2 + 1 : diameter/2 ] )
    {
        num_cones = (2 * 3.14159 * radius) / (cone_diameter *2);
        delta_angle = 360 / num_cones;
        for( angle = [ 0 : delta_angle : 360 ] )
        {
            rotate([0, 0, angle])
            translate([ radius, 0, 0] )
            cylinder(h=cone_height, d1=cone_diameter, d2=0);
        }
    }
}

module spike_pad_linear_2()
{
    diameter = 50;
    z = 2;
    cone_diameter = 5;
    cone_height = 5;
    
    difference()
    {
        union()
        {
            cylinder(d=diameter, h=z);
            translate([0, 0, z])
        //    cylinder(h=cone_height, d1=cone_diameter, d2=0);
            for(x_translation = [ -diameter/2 : cone_diameter+1 : diameter/2 ] )
            {
                x_translation = x_translation + cone_diameter/2;
                for(y_translation = [ -diameter/2 : cone_diameter : diameter/2 ] )
                {
                    y_translation = y_translation + cone_diameter/2;
                    if( sqrt( x_translation*x_translation + y_translation*y_translation) < diameter/2 - cone_diameter/2)
                    {
                    translate([x_translation, y_translation, 0])
                    cylinder(h=cone_height, d1=cone_diameter, d2=0);
                    }
                }
            }
        }
        union()
        {
            for( x_translation = [15, -15] )
            {
                translate([x_translation, 0, -z ])
                rotate([0, 0, 0])
                {
                    // screw void
                    cylinder(d=3.2, h=10+cone_height);
                }
            }
        }
    }
}

//module spherical_pad()
//{
//    radius = 46;
//    bottom_thickness = 7;
//    
//    difference()
//    {
//        union()
//        {
//            translate([0, 0, radius - bottom_thickness])
//            sphere(r=radius, $fn=90);
//            
//            for( x_translation = [15, -15] )
//            {
//                translate([x_translation, 0, 0 ])
//                rotate([180, 0, 0])
//                {
//                    // screw void
//                    cylinder(d=3.2, h=bottom_thickness);
//                    
//                    translate([0, 0, -bottom_thickness-100])
//                    rotate([180, 0, 0])
//                    cylinder(d=6, h=100);
//                }
//            }
//        }
//        union()
//        {
//            translate([-5000, -5000, 5000])
//            cube([10000, 10000, 10000]);
//            
////            for( x_translation = [15, -15] )
////            {
////                translate([x_translation, 0, 0 ])
////                rotate([180, 0, 0])
////                {
////                    // screw void
////                    cylinder(d=3.2, h=bottom_thickness);
////                    
////                    translate([0, 0, -bottom_thickness])
////                    rotate([180, 0, 0])
////                    cylinder(d=6, h=10);
////                }
////            }
//        }
//    }
//}

module spherical_pad()
{
    radius = 46;
    bottom_thickness = 7;
    
    difference()
    {
        union()
        {
            translate([0, 0, -radius + bottom_thickness])
            sphere(r=radius, $fn=90);
        }
        union()
        {
            translate([-5000, -5000, -10000])
            cube([10000, 10000, 10000]);
            
            for( x_translation = [15, -15] )
            {
                translate([x_translation, 0, 0 ])
                {
                    // screw void
                    cylinder(d=3.2, h=bottom_thickness);
                    
                    translate([0, 0, 3])
                    cylinder(d=6, h=4);
                }
            }
        }
    }
}

//pad();

//rotate([180, 0, 0])
spike_pad_linear_2();

//rotate([180, 0, 0])
//spike_pad_radial();

//translate([0, 0, -10])
//spherical_pad();