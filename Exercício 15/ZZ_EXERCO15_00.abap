REPORT ZZ_EXERCO15_00.

 DATA: v_soma type I,
       v_maior type I,
       v_menor type I,
       v_media type I.

 PARAMETERS:
      v_n1 TYPE I,
      v_n2 TYPE I,
      v_n3 TYPE I,
      v_n4 TYPE I,
      v_n5 TYPE I.


START-OF-SELECTION.

START-OF-SELECTION.
IF v_n1 < 0 OR v_n2 < 0 OR v_n3 < 0 OR v_n4 < 0 OR v_n5 < 0.
WRITE: 'Não são permitidos números negativos.'.
EXIT.
ENDIF.

IF v_n1 mod 2 EQ 0.
 WRITE:/ 'Par:', v_n1.
ENDIF.
IF v_n2 mod 2 EQ 0.
 WRITE:/ 'Par:', v_n2.
ENDIF.
IF v_n3 mod 2 EQ 0.
 WRITE:/ 'Par:', v_n3.
ENDIF.
IF v_n4 mod 2 EQ 0.
 WRITE:/ 'Par:', v_n4.
ENDIF.
IF v_n5 mod 2 EQ 0.
 WRITE:/ 'Par:', v_n5.
ENDIF.

v_soma = v_n1 + v_n2 + v_n3 + v_n4 + v_n5.
v_media = v_soma / 5.

IF v_n1 > v_n2 AND v_n1 > v_n3 AND v_n1 > v_n4 AND v_n1 > v_n5.
 v_maior = v_n1.
ELSEIF v_n2 > v_n1 AND v_n2 > v_n3 AND v_n2 > v_n4 AND v_n2 > v_n5.
 v_maior = v_n2.
ELSEIF v_n3 > v_n1 AND v_n3 > v_n2 AND v_n3 > v_n4 AND v_n3 > v_n5.
 v_maior = v_n3.
ELSEIF v_n4 > v_n1 AND v_n4 > v_n2 AND v_n4 > v_n3 AND v_n4 > v_n5.
 v_maior = v_n4.
ELSE.
v_maior = v_n5.
ENDIF.

IF v_n1 < v_n2 AND v_n1 < v_n3 AND v_n1 < v_n4 AND v_n1 < v_n5.
 v_menor = v_n1.
ELSEIF v_n2 < v_n1 AND v_n2 < v_n3 AND v_n2 < v_n4 AND v_n2 < v_n5.
 v_menor = v_n2.
ELSEIF v_n3 < v_n1 AND v_n3 < v_n2 AND v_n3 < v_n4 AND v_n3 < v_n5.
 v_menor = v_n3.
ELSEIF v_n4 < v_n1 AND v_n4 < v_n2 AND v_n4 < v_n3 AND v_n4 < v_n5.
 v_menor = v_n4.
ELSE.
 v_menor = v_n5.
ENDIF.

PERFORM f_exibe_media.
PERFORM f_exibe_soma.
PERFORM f_exibe_maior.
PERFORM f_exibe_menor.

FORM f_exibe_soma.
WRITE:/ 'Soma:', v_soma.
ENDFORM.
FORM f_exibe_maior.
WRITE:/ 'Maior:', v_maior.
ENDFORM.
FORM f_exibe_menor.
WRITE:/ 'Menor:',v_menor.
ENDFORM.
FORM f_exibe_media.
WRITE:/ 'Média:', v_media.
ENDFORM.
