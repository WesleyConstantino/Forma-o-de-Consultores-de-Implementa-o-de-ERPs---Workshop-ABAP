REPORT ZZ_EXERCO17_38.

DATA v_cont TYPE i VALUE 100.

WHILE v_cont <= 200.
  IF ( v_cont MOD 2 ) <> 0 .
    WRITE v_cont.
  ENDIF.
ENDWHILE.
