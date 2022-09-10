REPORT ZZ_CALC_MEDIA_38.

DATA: v_media type p decimals 2,
     v_resultado(100) type c.

"cria labels para input em tela (GUI)
*interface do usuario
PARAMETERS: p_nota1 type p decimals 2,
            p_nota2 type p decimals 2,
            p_nota3 type p decimals 2,
            p_nota4 type p decimals 2.

"executa daqui em diante quando o usuario aperta enter
START-OF-SELECTION.
v_media = ( p_nota1 + p_nota2 + p_nota3 + p_nota  ) / 4.

IF v_media GE 7.
 v_resultado = 'Aprovado!'.
ELSE.
  v_resultado = 'Resprovado!'.
ENDIF.
