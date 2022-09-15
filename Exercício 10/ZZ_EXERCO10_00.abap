REPORT ZZ_EXERCO10_00.


 DATA: v_resultado type I.  " p decimals 2.

 PARAMETERS: 
      v_n1 TYPE I,
      v_op(1) TYPE C,
      v_n2 TYPE I.

START-OF-SELECTION.

CASE v_op.
WHEN '+'.
  v_resultado = v_n1 + v_n2.
WHEN '-'.
  v_resultado = v_n1 - v_n2.
WHEN '*'.
  v_resultado = v_n1 * v_n2.
WHEN '/'.
  v_resultado = v_n1 / v_n2.
WHEN 'MOD' OR 'mod' OR 'Mod'.
  v_resultado = v_n1 MOD v_n2.
ENDCASE.

PERFORM f_exibe_msg.

FORM f_exibe_msg.
   WRITE: v_resultado.
ENDFORM.
