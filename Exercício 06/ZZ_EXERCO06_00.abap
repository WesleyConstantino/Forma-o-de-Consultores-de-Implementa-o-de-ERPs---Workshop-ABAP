REPORT ZZ_EXERCO06_00.

   PARAMETERS: 
      v_valor TYPE I.
 
START-OF-SELECTION.

if v_valor <= 3.
  WRITE: v_valor .
endif.
