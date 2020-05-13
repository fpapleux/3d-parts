; LULZBOT TAZ 6 DUAL EXTRUDER V3
; START CODE
; DUAL EXTRUSION - START WITH EXTRUDER 2 | PLA & PETG
; 05/13/2020

M73 P0                        ; clear GLCD progress bar
M75 		; start GLCD timer
G26                          ; clear potential 'probe fail' condition
M107                         ; disable fans
M420 S0                      ; disable leveling matrix
G90                          ; absolute positioning
M117 Soften Temp...

; --- SOFTEN TEMP
; T0
M104 S150 T0
; T1
M104 S170 T1		; soften filament -- HARDCODED TEMP
M140 S80		; get bed heating up

M109 R150 T0
M109 R170 T1
; ----------

G28

M117 Heating...              ; LCD status message

; --- RETRACTION
T0                           ; select this extruder first
M82                          ; set extruder to absolute mode
G92 E0                       ; set extruder to zero
G1 E-5 F125                  ; retract XXmm of filament
T1                           ; select this extruder first
M82                          ; set extruder to absolute mode
G92 E0                       ; set extruder to zero
G1 E-5 F125                  ; retract XXmm of filament
; ----------

G1 Y100 F5000          ; move above wiper pad

; --- WIPING TEMP
M117 Wiping temp...			; LCD status message
M107						; Turn off fan
M109 R150 T0
M109 R170 T1				; wait for T0 to reach temp
; ----------

; T0                           ; switch extruders
G1 Z1                        ; push nozzle into wiper
G1 Y90 F1000                   ; slow wipe
G1 Y85 F1000                   ; slow wipe
G1 Y90 F1000                   ; slow wipe
G1 Y80 F1000                   ; slow wipe
G1 Y95 F1000                   ; slow wipe
G1 Y75 F2000                   ; fast wipe
G1 Y65 F2000                   ; fast wipe
G1 Y70 F2000                   ; fast wipe
G1 Y60 F2000                   ; fast wipe
G1 Y55 F2000                   ; fast wipe
G1 Y50 F2000                   ; fast wipe
G1 Y40 F2000                   ; fast wipe
G1 Y45 F2000                   ; fast wipe
G1 Y35 F2000                   ; fast wipe
G1 Y40 F2000                   ; fast wipe
G1 Y70 F2000                   ; fast wipe
G1 Y30 Z2 F2000                ; fast wipe
G1 Y35 F2000                   ; fast wipe
G1 Y25 F2000                   ; fast wipe
G1 Y30 F2000                   ; fast wipe
G1 Y25 Z1.5 F1000              ; slow wipe
G1 Y23 F1000                   ; slow wipe
G1 Y10 Z25                      ; raise extruder

; --- probing temp
M106
; T1
M104 S140 T0
M109 R140 T1
M107

M204 S175                    ; set accel for probing
G29                          ; probe sequence (for auto-leveling)
M420 S1                      ; enable leveling matrix
M425 Z					     ; use measured Z backlash for compensation
M425 Z F0		    		 ; turn off measured Z backlash compensation. (if activated in the quality settings, this command will automatically be ignored)
M204 S500                    ; set accel back to normal

; --- T1 TO PRINT TEMP
M104 S230 T1				 ; set extruder temp -- HARDCODED TEMP
; ----------

; --- T0 to PRINT TEMP
M104 S200 T0
; ----------

G1 X100 Y-25 Z0.5 F4500      ; move to open space
M400                         ; clear buffer
M117 Heating...              ; LCD status message

; --- PRINT TEMP
; T1
M109 R230 T1				 ; set extruder temp and wait -- HARDCODED TEMP
M109 R200 T0
; ----------

M117 Purging...              ; LCD status message

; -------------------- PURGE EXT 0 ------------------------------------
T0                           ; select this extruder first
G1  E0 F125  	             ; undo retraction
G92 E-50                     ; set extruder negative amount to purge
G1  E0 F125                  ; purge XXmm of filament
; ---- SET EXT 0 TO STANDBY TEMP
M104 S160

; -------------------- PURGE EXT 1 ------------------------------------
T1                           ; select this extruder first
G1  E0 F125  	             ; undo retraction
G92 E-50                     ; set extruder negative amount to purge
G1  E0 F125                  ; purge XXmm of filament

T1
G1 Z0.5                      ; clear bed (barely)
G1 X100 Y0 F5000             ; move above bed to shear off filament
M400                         ; clear buffer
M107

; -------------------- TURN EXT 2 OFF FOR SINGLE EXTRUDER PRINT ------------------
; T0
; M104 S0 T0                     ; T1 hotend off
T1
; --------------------------------------------------------------------------------

M117 TAZ Printing...         ; LCD status message
