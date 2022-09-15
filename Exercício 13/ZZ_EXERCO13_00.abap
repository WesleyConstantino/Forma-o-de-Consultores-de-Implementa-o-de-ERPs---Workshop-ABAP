REPORT ZZ_EXERCO13_00.

  DATA v_multiplos type I VALUE 1.
      

 PARAMETERS: 
      v_numero TYPE I.

START-OF-SELECTION.

IF v_numero <= 0.
 WRITE: 'Número inválido!'.
ELSE.
   WRITE: 'Os múltiplos de 2 menores que', v_numero ,'são:'.
   WRITE:/ v_multiplos.
 WHILE v_multiplos * 2 <= v_numero.
   v_multiplos = v_multiplos * 2.
   WRITE:/ v_multiplos.
 ENDWHILE.
ENDIF.
