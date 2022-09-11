REPORT ZZ_EXERCO04_00.

    DATA:
      v_nota_1 TYPE p decimals 2,
      v_nota_2 TYPE p decimals 2,
      v_nota_3 TYPE p decimals 2,
      v_nota_4 TYPE p decimals 2,
      v_media_aluno TYPE p decimals 2.


v_nota_1 = 5.
v_nota_2 = 10.
v_nota_3 = 8.
v_nota_4 = 9.
v_media_aluno = v_nota_1 + v_nota_2 + v_nota_3 + v_nota_4.

WRITE: 'A média do aluno é: ', v_media_aluno.
