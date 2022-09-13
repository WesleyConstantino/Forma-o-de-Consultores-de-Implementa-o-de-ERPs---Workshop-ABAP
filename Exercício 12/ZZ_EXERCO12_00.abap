REPORT ZZ_EXERCO12_00.

 DATA v_contador type I VALUE 1.

 PARAMETERS: 
      v_numero TYPE I.

START-OF-SELECTION.

WHILE v_contador >= 10.
WRITE:/ v_numero * v_contador.
v_contador ++.
ENDWHILE.
