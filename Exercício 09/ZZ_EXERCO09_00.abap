REPORT ZZ_EXERCO09_00.

DATA: v_peso_ideal TYPE p DECIMALS 2.
CONSTANTS: c_m      TYPE c VALUE 'M',
           c_f      TYPE c VALUE 'F',
           c_peso_h TYPE p DECIMALS 2 VALUE '72.7',
           c_peso_m TYPE p DECIMALS 2 VALUE '61.2'.

PARAMETERS:
  v_sexo(1) TYPE c OBLIGATORY,
  v_altura  TYPE p DECIMALS 2 OBLIGATORY.

START-OF-SELECTION.

  IF v_sexo EQ c_m. "Masculino
    v_peso_ideal = ( c_peso_h * v_altura ) - 58.
  ELSEIF v_sexo EQ c_f. "Feminino
    v_peso_ideal = ( c_peso_m * v_altura ) - 44.
  ELSE.
    WRITE: text-001.
  ENDIF.


  PERFORM f_exibe_msg.

FORM f_exibe_msg.
  WRITE: text-002, v_peso_ideal.
ENDFORM.
