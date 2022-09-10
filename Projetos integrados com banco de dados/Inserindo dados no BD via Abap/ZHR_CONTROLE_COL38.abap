REPORT ZHR_CONTROLE_COL38.

"Esses sao os campos da minha tabela zhr001_3 no banco de dados
*ZZ_RE
*ZZ_NOME_EMP
*ZZ_CARGO
*ZZ_STATUS_EMP
*ZZ_DATA_CAD

*zhr001_3 é o nome da minha tabela física no banco de dados
DATA: wa_001 type zhr001_38.


PARAMETERS: p_RE TYPE zhr001_38-zz_re,
            p_nome TYPE zhr001_38-zz_nome_emp,
            p_cargo TYPE zhr001_38-zz_cargo,
            p_stt TYPE zhr001_38-zz_status_emp,
            p_dtc TYPE zhr001_38-zz_data_cad.

START-OF-SELECTION.
PERFORM f_insert.

FORM f_insert.
wa_001-zz_re = p_RE.
wa_001-zz_nome_emp = p_nome.
wa_001-zz_cargo = p_cargo.
wa_001-zz_status_emp = p_stt.
wa_001-zz_data_cad =  p_dtc.

INSERT zhr001_38 FROM wa_001.

*se for igual a 0
IF SY-subrc IS INITIAL.
*Dá commit no banco dedos
 COMMIT WORK AND WAIT.
*mensagem de sucesso
 MESSAGE S208(00) WITH 'SALVO COM SUCESSO!'.
ELSE.
 ROLLBACK WORK.
*mensagem de erro
 MESSAGE S208(00) WITH 'ERRO AO GRAVAR!'DISPLAY LIKE 'E'.
ENDIF.

ENDFORM.
