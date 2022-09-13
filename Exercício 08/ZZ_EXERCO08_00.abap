REPORT ZZ_EXERCO08_00.

 PARAMETERS: 
      v_num TYPE I.

START-OF-SELECTION.

if v_num MOD 2 = 0.
  WRITE: 'Par!'.
else.
  WRITE: 'Impar!'.
endif.
