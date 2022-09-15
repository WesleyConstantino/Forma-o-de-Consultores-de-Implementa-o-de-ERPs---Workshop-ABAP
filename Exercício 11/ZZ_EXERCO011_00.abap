REPORT ZZ_EXERCO011_00.
    DATA:
      v_cont TYPE I VALUE 0.

START-OF-SELECTION.

WHILE v_cont <= 100.
   WRITE:/ v_cont.
   v_cont = v_cont + 1.
ENDWHILE .
