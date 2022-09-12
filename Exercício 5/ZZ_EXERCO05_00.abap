REPORT ZZ_EXERCO05_00.

    DATA: 
      v_ano_nascimento TYPE I,
      v_ano_atual TYPE I,
      v_idade_atual TYPE I,
      v_idade_2015 TYPE I.

 
v_ano_nascimento = 1997.
v_ano_atual = 2022.
v_idade_atual = v_ano_atual - v_ano_nascimento.
v_idade_2015 = v_ano_atual - 2015.


WRITE: 'A idade atual é: ', v_idade_atual.
WRITE: 'A idade em 2015 foi: ', v_idade_2015.
