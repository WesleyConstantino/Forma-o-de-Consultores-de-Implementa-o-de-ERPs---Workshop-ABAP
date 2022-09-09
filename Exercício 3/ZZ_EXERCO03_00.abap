Programa ZZ_EXERCO03_##

REPORT ZZ_EXERCO03_00.

    DATA: 
      v_altura TYPE F,
      v_base TYPE F,
      v_area TYPE F.

 
v_altura = 180.0.
v_base = 100.0.
v_area = v_altura * v_base / 2.



WRITE: 'A área do triângulo é: ', v_area.
