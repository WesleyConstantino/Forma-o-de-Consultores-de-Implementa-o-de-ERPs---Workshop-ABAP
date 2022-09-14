REPORT ZZ_EXERCO07_00.

   DATA: 
      v_maior TYPE I.

 PARAMETERS:
      v_v1 TYPE I,
      v_v2 TYPE I.
 

START-OF-SELECTION.
v_maior = 0.

if v_v1 < v_v2.
  v_maior = v_v2.
else.
  v_maior = v_v1.
endif.

PERFORM f_exibe_msg.

FORM f_exibe_msg.
   WRITE: 'O número maior é: ', v_maior.
ENDFORM.
