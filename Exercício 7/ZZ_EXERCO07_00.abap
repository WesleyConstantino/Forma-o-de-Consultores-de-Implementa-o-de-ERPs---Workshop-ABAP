REPORT ZZ_EXERCO07_00.

    DATA: 
      v_valor_1 TYPE I,
      v_valor_2 TYPE I,
      v_maior TYPE I.
 
v_valor_1 = 2.
v_valor_2 = 8.
v_maior = 0.

if v_valor_1 < v_valor_2.
  v_maior = v_valor_2.
else.
  v_maior = v_valor_1.
endif.
