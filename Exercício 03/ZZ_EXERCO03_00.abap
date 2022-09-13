REPORT ZZ_EXERCO03_00.

    DATA:
      v_area TYPE p decimals 2.

 PARAMETERS: v_alt TYPE p decimals 2,
             v_base TYPE p decimals 2.


START-OF-SELECTION.
v_area = v_alt * v_base / 2.



WRITE: 'A área do triângulo é: ', v_area.
