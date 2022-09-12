REPORT ZZ_EXERCO07_00.

    DATA: 
      v_maior TYPE I.

 PARAMETERS:
      v_valor_1 TYPE I,
      v_valor_2 TYPE I.
 

START-OF-SELECTION.
v_maior = 0.

if v_valor_1 < v_valor_2.
  v_maior = v_valor_2.
else.
  v_maior = v_valor_1.
endif.

PERFORM f_exibe_msg.

FORM f_exibe_msg.
   WRITE: 'O número maior é: ', v_maior.
ENDFORM.
