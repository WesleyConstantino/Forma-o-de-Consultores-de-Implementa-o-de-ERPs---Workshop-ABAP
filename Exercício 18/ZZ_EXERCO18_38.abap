REPORT ZZ_EXERCO18_38.

PARAMETERS: p_horas TYPE i,
            p_sphr  TYPE netpr.

DATA: v_salr TYPE p DECIMALS 2.

IF p_horas > 160.
  v_salr = ( 160 * p_sphr ) + ( ( p_horas - 160 ) * ( p_sphr * '1.30') ).
ELSE.
  v_salr = p_horas * p_sphr.
ENDIF.

WRITE: 'Seu Salário é: R$', v_salr.
