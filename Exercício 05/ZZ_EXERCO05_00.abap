REPORT ZZ_EXERCO05_00.

    DATA:
      v_idade_atual TYPE I,
      v_idade_2015 TYPE I.

 PARAMETERS:
      v_nasc TYPE I,
      v_ano TYPE I.


START-OF-SELECTION.
v_idade_atual = v_ano - v_nasc.
v_idade_2015 = v_nasc - 2015.

PERFORM f_exibe_msg_1.
PERFORM f_exibe_msg_2.

FORM f_exibe_msg_1.
   WRITE: 'A idade atual é: ', v_idade_atual, 'anos'.
ENDFORM.

FORM f_exibe_msg_2.
   WRITE:/ 'A idade em 2015 foi: ', v_idade_2015 , 'anos'.
ENDFORM.
