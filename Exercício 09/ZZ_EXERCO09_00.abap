REPORT ZZ_EXERCO09_00.

 DATA: v_peso_ideal type p decimals 2.

 PARAMETERS: 
      v_sexo(1) TYPE C OBLIGATORY,
      v_altura TYPE p decimals 2 OBLIGATORY.

START-OF-SELECTION.

if v_sexo EQ 'M' OR v_sexo EQ 'm'.
  v_peso_ideal = ( 72,7 * v_altura ) - 58.
Elseif v_sexo EQ 'F' OR v_sexo EQ 'f'.
  v_peso_ideal = ( 62,1 * v_altura ) - 44,7.
Else.
  WRITE: 'Caractere inválido!'.
endif.


PERFORM f_exibe_msg.

FORM f_exibe_msg.
   WRITE: 'O seu peso ideal é: ', v_peso_ideal.
ENDFORM.

