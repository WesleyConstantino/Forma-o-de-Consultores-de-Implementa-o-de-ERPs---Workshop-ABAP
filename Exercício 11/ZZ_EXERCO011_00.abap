REPORT ZZ_EXERCO011_00.

    DATA:
      v_cont TYPE I.

START-OF-SELECTION.
v_cont = 0.

WHILE v_cont < 100.
   WRITE:\ 'v_cont'.
   v_cont ++. 
ENDWHILE .
