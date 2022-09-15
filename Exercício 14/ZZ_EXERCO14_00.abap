REPORT ZZ_EXERCO14_00.

DATA: v_maior type I,
       v_menor type I.
      
 PARAMETERS: 
      v_n1 TYPE I,
      v_n2 TYPE I.

START-OF-SELECTION.

IF v_n1 > v_n2.
 v_maior = v_n1.
 v_menor = v_n2.
ELSE.
 v_maior = v_n2.
 v_menor = v_n1.
ENDIF.

PERFORM f_exibe_cres.
PERFORM f_exibe_dcres.

FORM f_exibe_cres.
WRITE: 'Sequência crescente: ', v_menor , v_maior.
ENDFORM.
FORM f_exibe_dcres.
WRITE:/ 'Sequência decrescente: ', v_maior , v_menor.
ENDFORM.
