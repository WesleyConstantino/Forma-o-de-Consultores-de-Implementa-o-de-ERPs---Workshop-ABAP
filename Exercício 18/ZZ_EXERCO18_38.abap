REPORT ZZ_EXERCO18_38.

PARAMETERS: p_horas TYPE p decimals 2,
            p_valor  TYPE p decimals 2.

DATA: v_salr TYPE p DECIMALS 2.

IF p_horas > 160.
  v_sal = ( 160 * p_valor ) + ( ( p_horas - 160 ) * ( p_valor * '1.30') ).
ELSE.
  v_sal = p_horas * p_valor.
ENDIF.

WRITE: 'Seu Salário é: R$', v_sal.
