// File: kandi-cuff-board.scad
// Created: 2025-01-21
// Author: Logan Browne
// Description:
// Shape program in SCAD to create a board for building Pony Bead Cuffs.
// This is inspired by the design of MamaKatzCrafts but built from scratch.
// License: Creative Commons Attribution-ShareAlike (CC BY-SA)

// DEFINE VARIABLES

// These two numbers define the size of the object. 24 rows and 16 columns is a good base size.
// length of cuff 
num_rows = 24; 
// width of cuff. columns must be even number because of offset row
num_columns = 16; 

// resolution for objects
$fn = 90;

// diameter of common pony bead plus 0.1 mm so it does not fit too tight
bead_diameter = 9.3;
// length of common pony bead plus 0.1 mm so it does not fit too tight
bead_length = 6.6 ;

// space between the rows so the beads don't bump
row_spacing = 0.75;
// separate the columns so you can feed the string
column_spacing = 0.75;

// a zero value will have holes in the bottom, higher values make the board thicker
board_floor = 0.4;
// board should just cup the beads by being a little deeper than half the diameter
board_height = (0.5 * bead_diameter) + board_floor;
// radius is symetrical to the beads
board_corner_radius = bead_diameter;

// make the board size based on the rows and columns needed
// width is the number of rows and the spacing for each accounting with extra for the radii and the offset row
board_width = (bead_diameter + row_spacing) * (num_rows + 1.25);
// length is similar but without the offset row
board_length = (bead_length + column_spacing) * (num_columns + .6) ;

// colors for coloring the rows to make it easier to see in scad
color_vec = ["black","red","blue","green","pink","purple"];

// BUILD THE OBJECT

// build the board and subtract the bead depressions
// dynamic size based on the sizes and numbers defined above
difference() { // Subtracts the 2nd (and all further) child nodes from the first one (logical and not).
    // build the board
    make_board([board_width,board_length,board_height], board_corner_radius);
    // shift the first row close to the x edge but missing the radius curve
    // add a z floor so that there are not holes 
    translate([(0.2 * bead_diameter), 0, board_floor])
    // build columns two at a time
    for (column =[-1:2:num_columns-2]) {
        // build the rows for the first column
        for (row =[0:1:num_rows-1]) {
            x = ((bead_diameter + row_spacing) * row);
            y = ((bead_length + column_spacing) * column);
            // color the depressions to make it easier to see
            color(color_vec[(column+row)%len(color_vec)])
            translate([x , y , 0]) bead_depression(bead_length, bead_diameter , bead_diameter); 
            }
        // build the second column at a half diameter offset
        for (row =[0:1:num_rows-1]) {
            x = (((bead_diameter + row_spacing) * row) + (0.5 * bead_diameter));
            y = ((bead_length + column_spacing) * (column + 1));
            // color the depressions to make it easier to see (alternating by one from prior column)
            color(color_vec[(column + row + 1) % len(color_vec)])
            translate([x , y , 0]) bead_depression(bead_length, bead_diameter , bead_diameter); 
            }
       }
}

// DEFINE MODULES

// this module builds the board with the rounded edges using a hull function
// simplified rcube with all the same radius rounded corners
// code is from https://blog.prusa3d.com/parametric-design-in-openscad_8758/
module make_board(size, radius) {
    hull() {
        // back left
        translate([radius, radius]) cylinder(r = radius, h = size[2]);
        // back right
        translate([size[0] - radius, radius]) cylinder(r = radius, h = size[2]);
        // front right
        translate([size[0] - radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
        // front left
        translate([radius, size[1] - radius]) cylinder(r = radius, h = size[2]);
    }
}

module bead_depression(length, width, depth) {
    
    // move build point by a bead size and make sure it's not above the plane of the board
    // rotate so the the cylinder is on it's side, then make a simple cylinder the size of a bead
    translate([length, width , (.5 * depth)]) rotate([-90, 0 , 0]) cylinder(h = length, d = width);
    
}

