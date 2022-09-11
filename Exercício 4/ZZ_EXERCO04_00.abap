REPORT ZZ_EXERCO04_00.

    DATA: 
      v_nota_1 TYPE F,
      v_nota_2 TYPE F,
      v_nota_3 TYPE F,
      v_nota_4 TYPE F. 
      v_media_aluno TYPE F. 

 
v_nota_1 = 5.3.
v_nota_2 = 10.0.
v_nota_3 = 8.2.
v_nota_4 = 9.0.
v_media_aluno = v_nota_1 + v_nota_2 + v_nota_3 + v_nota_4.

WRITE: 'A média do aluno é: ', v_media_aluno.
