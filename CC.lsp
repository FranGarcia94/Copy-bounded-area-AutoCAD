(defun C:CC (/ en ss lst ssall tmp head)
(COMMAND "_.PASTEORIG" conj)
(command "_.ZOOM" "E")
(COMMAND "_.maptrim" "Seleccionar" Pause "No" "No" "Exterior" "Si" "Si" "Suprimir" "Si")
(princ "Nombre del Archivo:")
(setq n_hoja (read-line))
(setq name (strcat "C:\\...\\ INSERT THE PATH HERE" n_hoja ".dwg"))
(command "_.SAVE" name)
)
