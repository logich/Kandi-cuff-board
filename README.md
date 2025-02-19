# Kandi-cuff-board
Parametric Generation of a Kandi Cuff Beading Board

This is a Open SCAD program to create a board for building Kandi Cuffs or Pony Bead Cuffs.
This file can be redered with OpenSCAD to create an STL file, which can be sliced for a 3D printer.

You can use the bambulab online Parametric Model Maker to import this model, tweak it, and download an STL or 3MF model file. 
https://makerworld.com/en/makerlab/parametricModelMaker?from=makerlab

This is inspired by the design of MamaKatzCrafts but I built this from scratch because I wanted to print my own version.
Because this is parameterized you can make it any shape or size you need, and if you want to use other kinds of beads you can alter the design.

However, if you want something really well made and don't want to tinker you can get a premade board here: https://mamacatzcrafts.com

Standard pony bead measurements seem to be 9 mm diameter by 6mm length but there is a lot of variation so you can adjust it to your needs. 
While the beads are curved my slots are cylinders, so there may be a little play.

The basic function is to 
1. Make a rounded rect base that is sized for the number of rows and columns
1. Make a depression sized for the bead
1. Repeat this for the length of the board
1. Offset the next row by half a bead in the x and a defined number of mm in y


License: Creative Commons Attribution-ShareAlike (CC BY-SA)
