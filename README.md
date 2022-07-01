# Copy-bounded-area-AutoCAD
![AutoCAD_version](https://img.shields.io/badge/version-S.51.0.0%20AutoCAD%202022-brightgreen)
<br></br>
Copy the area bounded by a polygon and everything inside it, to paste into a new file

The code is divided into two parts, one to copy the entities and another part where the original coordinates are pasted into a new drawing. This code is intended for a large drawing with a grid structure where the drawing is formed by polygonal subdivisions of it.

Something like this:
<br></br>
<img width="274" alt="image" src="https://user-images.githubusercontent.com/107102754/175125057-5d936bb5-63d2-4c43-bf59-0add84f5b368.png">

In this context, if you want to save certain parts of the drawing separately and store it in separate files, you could do it using the following code.

## AA
### 1. Select an entity from the drawing and initialize variables.
    (SETQ cont 0)
    (setq lista (entget(car(entsel)))); It asks us to select an entity of the drawing, in our case, we will select the frame that delimits the sheet that we want to copy and saves all the characteristics of the selected entity in a variable called 'lista'.
    (setq puntos ())

### 2. Get the data of the vertices of the sheet frame.
    (WHILE (/= (nth cont lista) (nth 39 lista))
    (if (= (car(nth cont lista)) 10)
    (setq puntos (append (list (cdr(nth cont lista))) (list puntos))))
    (setq cont (+ cont 1))); In this way we go through the list, until the penultimate position (39), we obtain the vertices of the rectangle, which are stored in the list within sublists with the prefix 10. These vertices are stored in the list 'puntos'
    
### 3. Separate the points.
    (setq p1 (car puntos))
    (setq p2 (car (car (cdr puntos))))
    (setq p3 (car (car (cdr (car (cdr puntos))))))
    (setq p4 (car (car (cdr (car (cdr (car (cdr puntos))))))))
    (setq pt_list (list p1 p2 p3 p4));

### 4. Select all entities within and passing through the sheet frame.
    (setq conj (ssget "_CP" pt_list))

### 5. Copy the set to the clipboard.
    (COMMAND "_.copyclip" conj "")
    (setq conj2 (ssget "_WP" pt_list))
    (command "_change" conj2 "" "_p" "_c" "3" ""); With this, the entities that are completely within the selected area are changed to green, this is to know which sheets have been copied.
    
    
## CC (Before this code, open a new draw)

### 6. Paste the entiti es at original coordinates and focus the screen there.
    (COMMAND "_.PASTEORIG" conj)
    (command "_.ZOOM" "E")
    
### 7. Select polygon and delete everything outside said polygon.
    (COMMAND "_.maptrim" "Seleccionar" Pause "No" "No" "Exterior" "Si" "Si" "Suprimir" "Si"); This command needs to be changed, it depends on the version.
    
### 8. Select file name and save it in specified folder.
    (princ "Nombre del Archivo:")
    (setq n_hoja (read-line)); We write the name of the new sheet
    (setq name (strcat "C:\\Users\\...\\ INSERT HERE THE PATH" n_hoja ".dwg"))
    (command "_.SAVE" name)

## The steps to load and run these files.
### 1. Open the file and activate and unlock the layers that you want to copy.
### 2. Now you have to load the files with the code. To do this, it is first necessary to save the files in .lsp format through a text file.

To upload the files you have to access the 'Manage' tab on the toolbar and within this select upload application.
![image](https://user-images.githubusercontent.com/107102754/175130329-33fe7969-919f-4d0e-9519-e09e79b07df6.png)
A pop-up window like this will open:
![image](https://user-images.githubusercontent.com/107102754/175130421-798ce312-8ee8-4f4c-bd2c-899e367fb22f.png)

There we look for the folder where the '.lsp' files that we have created are located and press load. If everything went well, the box below will show that the action has been successful.

Now, so that these files can be found in each new drawing that is opened, we will have to load them at the beginning, therefore, without leaving this window, click 'Content...' in the part that says 'Load at the beginning' and will open another popup:
![image](https://user-images.githubusercontent.com/107102754/175130726-3e2d6011-19db-4f13-9c9c-e7c7b7869ec3.png)

In this case, the loaded files already appear, but if it is the first time, they must be loaded by searching for the files once we have clicked 'Add'. Once this is done we close both pop-up windows.

The code is already loaded in AutoCAD, now you have to run it. To do this, simply write the name of the file in the autocad drawing window or in the command line and execute it.

Example:
We select the file saved as 'AA'
![image](https://user-images.githubusercontent.com/107102754/175130924-7dc3e69a-ab79-4dea-8de3-5e842a2ac11a.png)

We select the frame of the sheet that we want to extract, press enter and all the entities within the frame will automatically change to green, to highlight that this sheet is already copied.
![image](https://user-images.githubusercontent.com/107102754/175131141-0cbc7430-ab94-4edf-b9e2-8d568c54503e.png)

![image](https://user-images.githubusercontent.com/107102754/175131205-fdf97d15-cf6c-421c-8e05-3ae4c95e2d75.png)

Next, a new drawing must be opened and in it the same as in the first step above will be done, but this time with the CC command and the result is:
<br></br>
![image](https://user-images.githubusercontent.com/107102754/175131411-d5b3334c-d624-4734-8658-1facfebdf1be.png)

We mark the frame of the sheet again so that the outside of it is cut:
![image](https://user-images.githubusercontent.com/107102754/175131538-1dc1cd9b-29cf-4c98-a77c-bef00ef6732c.png)

We put the name of the file and it will automatically be saved in the path specified in the code.



