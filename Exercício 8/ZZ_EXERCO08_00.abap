Programa ZZ_EXERCO08_##

REPORT ZZ_EXERCO08_00.

    DATA: 
      v_num TYPE I,

v_num = 2.

if v_num MOD 2 = 0.
  WRITE: 'Par!'.
else.
  WRITE: 'Impar!'.
endif.
