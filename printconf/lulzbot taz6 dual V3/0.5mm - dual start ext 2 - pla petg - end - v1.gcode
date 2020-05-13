; LULZBOT TAZ 6 DUAL EXTRUDER V3
; END CODE
; DUAL EXTRUSION - START WITH EXTRUDER 2 | PLA & PETG
; 05/13/2020

M400
M104 S0 T0                     ; T0 hotend off
M104 S0 T1                     ; T1 hotend off
M140 S40
M106                           ; fans full speed
G91                            ; relative positioning

; --- RETRACT EXT 2
;T1
;G1 E-5 F300                    ; retract the filament a bit before lifting the nozzle, to release some of the pressure

G1 Z120
T1
M117 Cooling please wait       ; progress indicator message
G90                            ; absolute positioning

; --- COOL OFF BED
; M190 R40                       ; set bed to cool off

G1 Y280 F3000                  ; present finished print
M107						   ; Turn fans off
M140 S40                       ; keep temperature or cool downs
M77			       ; stop GLCD timer
M84                            ; steppers off
G90                            ; absolute positioning
M117 Print complete            ; progress indicator message
