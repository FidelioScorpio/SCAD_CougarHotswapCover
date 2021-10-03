text = "";


{
width_front_top = 107.7; // AD
width_front_bottom = 101.8; // BC
width_back = 103.7; // EF
top_length = 94.5; // AF
bottom_length = 89.4; // BF

height_front_angled = sqrt(pow(top_length, 2) - pow(bottom_length, 2));

lower_y = (pow(top_length, 2) + pow(height_front_angled, 2) - pow(bottom_length, 2)) / (2 * top_length);
lower_z = sqrt(pow(height_front_angled, 2) - pow(lower_y, 2));

_points = [[0,0,0], 
           [width_front_top/2 - width_front_bottom/2,lower_y,-lower_z], 
           [width_front_top/2 + width_front_bottom/2,lower_y,-lower_z], 
           [width_front_top, 0, 0],
           [width_front_top/2 + width_back/2,top_length,0],
           [width_front_top/2 - width_back/2,top_length,0]];
_centre = [width_front_top/2, top_length/2, 0];

//_centre = [51.95, 47, 0];
//_points = [[-1.75, 0, 0], [0, 0, -31], [103.9, 0, -31], [107.4-1.75, 0, 0], [103.9, 94.3, 0], [0, 94.0, 0]];
_faces = [[1, 0, 3, 2], [2, 3, 4], [0, 5, 4, 3], [0, 1, 5], [1,2,4,5]];

// MAIN SHAPE
// Remove the debossed lettering
difference()
{
    translate(-_centre) difference()
    {
        // The MAIN shape
        color("orange")
        {
            polyhedron(points=_points, faces=_faces, convexity=10);
        }
        // SATA cutout cube
        color("orange") translate([11,lower_y-2,-lower_z-2]) rotate([asin(lower_z/bottom_length),0,0]) cube([45, 12, 7]);
    }

    // The sphere to remove for the finger
    color("orange") translate([0, -20, 0]) sphere(20, $fn = 360);
    
    // The lettering to debosse
    color("orange") translate([0, ((47+20)/2) - 20, -2]) linear_extrude(2.1) text(text, font="Courier New:style=Bold", size = 20, halign="center", valign="center");
}

// HANDLE
// Remove handle hole
// Join the Finger-hole cover

// I need to make a donut the size of d=25 with its own d at 2
difference()
{
    // Add the handle
    color("orange") translate([-21, -41, -2]) cube([42, 42, 2]);
    
    
    //Handle Hole
    translate([0, -20, -3]) cylinder(5, d=25);
}
color("orange") translate([0, -20, -1]) rotate_extrude(convexity = 10, $fn = 360) translate([25/2, 0, 0]) circle(d=2, $fn = 100);

} //end rotate
// Dimensions:
/*
in CM

width top 10.83
width top chamfer point 10.74
width bottom ?10.39
width back 10.39

height front 3.1

length 9.40
_points = [[-1.75, 0, 0], [0, 0, -31], [103.9, 0, -31], [107.4-1.75, 0, 0], [103.9, 94.3, 0], [0, 94.0, 0]];

NEW
(103.7 ask => 103.9)

width front top (chamfer point) 107.7
width front bottom ?101.8
width back 103.7

height front 29.9

top length 94.1
bottom length 87.6

_points = [[0, 0, 0], [0, 0, -31], [103.9, 0, -31], [107.4-1.75, 0, 0], [103.9, 94.3, 0], [0, 94.0, 0]];

*/




