REPORT ZZ_EXERCO04_00.

    DATA:
       v_media_aluno TYPE p decimals 2.

 PARAMETERS:       
         v_nota_1 TYPE p decimals 2,
         v_nota_2 TYPE p decimals 2,
         v_nota_3 TYPE p decimals 2,
         v_nota_4 TYPE p decimals 2.

START-OF-SELECTION.
v_media_aluno = v_nota_1 + v_nota_2 + v_nota_3 + v_nota_4 / 4.


PERFORM f_exibe_msg.

FORM f_exibe_msg.
  WRITE: 'A média do aluno é: ', v_media_aluno.
ENFORM.
