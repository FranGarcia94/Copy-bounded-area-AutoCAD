# Copy-bounded-area-AutoCAD
Copy the area bounded by a polygon and everything inside it, to paste into a new file

The code is divided into two parts, one to copy the entities and another part where the original coordinates are pasted into a new drawing. This code is intended for a large drawing with a grid structure where the drawing is formed by polygonal subdivisions of it.

Something like this:
<br></br>
<img width="274" alt="image" src="https://user-images.githubusercontent.com/107102754/175125057-5d936bb5-63d2-4c43-bf59-0add84f5b368.png">

In this context, if you want to save certain parts of the drawing separately and store it in separate files, you could do it using the following code.

## AA
1. Select an entity from the drawing and initialize variables.

