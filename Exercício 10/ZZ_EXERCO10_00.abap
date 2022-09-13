REPORT ZZ_EXERCO10_00.

 DATA: v_resultado type I,

 PARAMETERS: 
      v_operador(1) TYPE C,
      v_n1 TYPE I,
      v_n2 TYPE I.

START-OF-SELECTION.

CASE v_operador.
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


PERFORM f_exibe_msg.

FORM f_exibe_msg.
   WRITE: v_resultado.
ENDFORM.
