REPORT ZZ_EXERCO02_00.

    DATA: 
      v_a TYPE I,
      v_b TYPE I,
      v_c TYPE I.

 
v_a = 3.
v_b = 2.
v_c = 5.

if v_a > v_b.
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.
    
if not (v_b = v_a).
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.

if not (v_a >= v_b AND v_c <> 5).
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.

if v_b < v_a OR v_a = 3.
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.

if v_a > v_b OR v_a =3.
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.

if v_c <= 7 AND v_b > 0 AND v_c > v_a.
  WRITE: 'Verdadeiro!'.
else.
  WRITE: 'Falso!'.
endif.
