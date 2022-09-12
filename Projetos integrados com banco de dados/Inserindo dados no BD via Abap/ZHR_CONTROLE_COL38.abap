REPORT ZHR_CONTROLE_COL38.

"Esses sao os campos da minha tabela zhr001_3 no banco de dados
*ZZ_RE
*ZZ_NOME_EMP
*ZZ_CARGO
*ZZ_STATUS_EMP
*ZZ_DATA_CAD

*zhr001_3 é o nome da minha tabela física no banco de dados
DATA: wa_001 type zhr001_38.

*aqui defino as variáveis do TYPE da minha tabela sendo de uma linha específica 
*No exemplo de p_RE TYPE zhr001_38-zz_re, seguimos a regra <Nome da variável> TYPE <Nome da tabela do BD> <<-> o traco sempara a tabela da linha> <Nome da linha da tabela> 
*PARAMETER cria a interface do usuario (com campos para ele preencher)
PARAMETERS: p_RE TYPE zhr001_38-zz_re OBLIGATORY,  "OBLIGATORY faz o preenchimento um campo pelo usuário ser obrigatório
            p_nome TYPE zhr001_38-zz_nome_emp,
            p_cargo TYPE zhr001_38-zz_cargo,
            p_stt TYPE zhr001_38-zz_status_emp,
            p_dtc TYPE zhr001_38-zz_data_cad.

"executa daqui em diante quando o usuario aperta enter
START-OF-SELECTION.
"PERFORM chama a "função" FORM, nesse caso o forme é f_insert
PERFORM f_insert.

"form executa um bloco de comandos, é como se fosse uma função em outras linguagens
*nesse caso insere passa os valores armazenados em wa_001-zz_re para o campo p_RE da tabela do banco de dados, no primeiro caso a baixo
*No exemplo de wa_001-zz_re = p_RE, seguimos a regra <Nome da variável que armazena os dados> < - traco para separ >  < Linha da tabela do BD >  < Variável dentro da outra variável que armazena um valor especiifico >
FORM f_insert.
wa_001-zz_re = p_RE.
wa_001-zz_nome_emp = p_nome.
wa_001-zz_cargo = p_cargo.
wa_001-zz_status_emp = p_stt.
wa_001-zz_data_cad =  p_dtc.

*Insere tudo que está dentro de wa_001 para a tabela do banco de dados zhr001_38
INSERT zhr001_38 FROM wa_001.

*se for igual a 0
*IS INITIAL é a mesma coisa que == 0
*SY-subrc é uma espécie de biblioteca que retorna 0 para operacoes bem sucedidas e qualquer outro valor para operacoes que falham 
IF SY-subrc IS INITIAL.
*COMMIT WORK dá commit no banco dedos e AND WAIT pede para esperar a gravação dos dados no banco de dados
 COMMIT WORK AND WAIT.
*mensagem de sucesso
 MESSAGE S208(00) WITH 'SALVO COM SUCESSO!'.
ELSE.
"ROLLBACK WORK desfaz tudo o que aconteceu na operação
 ROLLBACK WORK.
*mensagem de erro
 MESSAGE S208(00) WITH 'ERRO AO GRAVAR!'DISPLAY LIKE 'E'.
ENDIF.

ENDFORM.
