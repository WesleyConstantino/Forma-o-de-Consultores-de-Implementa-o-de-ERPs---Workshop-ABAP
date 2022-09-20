REPORT zhr_report_col38.

*TABLES: zhr001_00.
DATA:    v_re        TYPE zhr001_38-zz_re,
         v_nome      TYPE zhr001_38-zz_nome_emp,
         v_cargo     TYPE zhr001_38-zz_cargo,
         v_stt       TYPE zhr001_38-zz_status_emp,
         v_dtc       TYPE zhr001_38-zz_data_cad,

*Boas práricas usar t_out e wa_out pois, se mudarmos o nome da tabela zhr001_38 em t_out, não precisaremos alterar mais trechos de código no programa
         t_out       TYPE TABLE OF zhr001_38, "TABELA INTERNA (matriz) para jogar os dados do BD e manipulá-los de forma indireta
         wa_out      LIKE LINE OF t_out,  "ESTRUTURA / WORK AREA (linha) é uma linha de t_out
*ALV
         t_fieldcat  TYPE  slis_t_fieldcat_alv, "t_fieldcat é uma tabela interna
         wa_fieldcat LIKE LINE OF t_fieldcat, "wa_fieldcat é uma linha da tabela interna t_fieldcat
         wa_layout   TYPE  slis_layout_alv. "Alimentando o is_layout para deixar a tabela ALV ajustada ao tamanho dos textos automáticamente

*DATA: r_re     TYPE RANGE OF v_re.

"001 é o código que demos ao título que escrevemos em "Ir para" -> "Elementos de texto" -> "Símbolos de texto"
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-001.
*SELECT-OPTIONS cria labels "DE" e "ATÉ" no front-end; são dois compos numa mesma linha
SELECT-OPTIONS: s_re     FOR v_re,
                s_nome   FOR v_nome,
                s_cargo  FOR v_cargo,
                s_stt    FOR v_stt,
                s_dtc    FOR v_dtc.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.

  PERFORM f_buscar_dados. "Busca os dados da tabela transparente zhr001_38 e popula na tabela interna t_out. 
  PERFORM f_exibir_alv. "Exibe o report


*&---------------------------------------------------------------------*
*&      Form  F_BUSCAR_DADOS
*&---------------------------------------------------------------------*
*       DUPLO CLICK NO NOME DE UM PERFORME CRIA UM FORM
*----------------------------------------------------------------------*
*  -->  ESCOLHER A OPÇÃO DA SEGUNDA LINHA APÓS O DUPLO CLICK
*  <--  
*----------------------------------------------------------------------*
FORM f_buscar_dados.
  REFRESH: t_out[]. "Limpa uma tabela; é a mesma coisa de "CLEAR: t_out[]" ou "FREE: t_out[]"

  SELECT  mandt  "SELECT seleciona os campos "x" de uma tabela do BD
          zz_re
          zz_nome_emp
          zz_cargo
          zz_status_emp
          zz_data_cad
    INTO TABLE t_out  "INTO TABLE joga os campos do BD acima dentro da tabela interna TABLE t_out  
    FROM zhr001_38  "É necessário também declarar de onde virão os campos que t_out receberá
    WHERE zz_re         IN s_re "Jogamos os conjuntos de dados dos campos da tabela transparente do BD "zhr001_38" "IN" dentro da tabebela interna "t_out" (populando a nossa tabela local)
      AND zz_nome_emp   IN s_nome
      AND zz_cargo      IN s_cargo
      AND zz_status_emp IN s_stt
      AND zz_data_cad   IN s_dtc.

  IF t_out[] IS INITIAL. "Verificar se a tabela está vazia
    MESSAGE e208(00) WITH 'NENHUM REGISTRO ENCONTRADO!'.
  ENDIF.

  DELETE t_out WHERE zz_nome_emp IS INITIAL. "Deleta todos os campos do  t_out onde o zz_nome_emp está vazio

*  cl_demo_output=>display_data( t_out ).

ENDFORM.



*&---------------------------------------------------------------------*
*&      Form  F_EXIBIR_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_exibir_alv.

  DATA: lv_tabix TYPE sy-tabix.

*  PERFORM f_cria_fcat USING:
*        '1'    'ZZ_RE'          'T_OUT'    'ZHR001_00'    'ZZ_RE'          'CÓD.MAT.'    'X'    'X',
*        '2'    'ZZ_NOME_EMP'    'T_OUT'    'ZHR001_00'    'ZZ_NOME_EMP'    'NOME'        ''     '',
*        '3'    'ZZ_CARGO'       'T_OUT'    'ZHR001_00'    'ZZ_CARGO'       'CARGO'       ''     '',
*        '4'    'ZZ_STATUS_EMP'  'T_OUT'    'ZHR001_00'    'ZZ_STATUS_EMP'  'STATUS'      ''     '',
*        '5'    'ZZ_DATA_CAD'    'T_OUT'    'ZHR001_00'    'ZZ_DATA_CAD'    'DAT.CAD.'    ''     ''.


  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZHR001_38' "Passamos o nome da nossa tabela transparente aqui
      i_client_never_display = abap_true   "Para não exibir o MANDANTE na tela
    CHANGING
      ct_fieldcat            = t_fieldcat  "Passamos o nome da nossa tabela interna t_fieldcat que foi criada lá em "DATA:", no início do código
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2.

* EXEMPLO MODIFY
*  LOOP AT t_fieldcat INTO wa_fieldcat. "Para cada linha da Work-Area(wa_fieldcat) podermos definir algo. O loop vai ser feito uma vez por linha
*    lv_tabix = sy-tabix.
*
*    CASE wa_fieldcat-fieldname. "Variável local para guardar o número da linha que será processada "1" mensionado abaixo em "READ TABLE t_out INTO wa_out INDEX 1."
*
*      WHEN 'ZZ_RE'.
*        READ TABLE t_out INTO wa_out INDEX 1. "Lê a primeira linha da tabela t-out e joga o conteúdo lido para dentro da estrutura de dados wa_out
*
*        wa_fieldcat-hotspot = abap_true. "Solicita que o campo chave da tabela ALV seja apresentade de outra cor para o usuário
*        MODIFY t_fieldcat FROM wa_fieldcat INDEX lv_tabix. "Aplica a solicitação pedida na linha acima
*
*      WHEN 'ZZ_DATA_CAD'.   "Não queremos que o ALV exiba o campo "ZZ_DATA_CAD", então fazemos o comando abaixo
*        wa_fieldcat-no_out = abap_true. "wa_fieldcat-no_out não oculta um determinado campo na ALV; nesse caso "ZZ_DATA_CAD" declarado acima
*        MODIFY t_fieldcat FROM wa_fieldcat INDEX lv_tabix.
*
*      WHEN OTHERS.
*    ENDCASE.
*  ENDLOOP.

  FIELD-SYMBOLS: <lfs_line>  TYPE slis_fieldcat_alv.
*                 <lfs_repid> TYPE any.
*
*  ASSIGN ('(SAPLSALV)G_REPID') TO <lfs_repid>.
*  IF <lfs_repid> IS ASSIGNED.
*    <lfs_repid> = abap_true.
*  ENDIF.

  LOOP AT t_fieldcat ASSIGNING <lfs_line>.
    CASE <lfs_line>-fieldname.
      WHEN 'ZZ_RE'.
        <lfs_line>-hotspot = abap_true.

      WHEN 'ZZ_DATA_CAD'.
        <lfs_line>-no_out = abap_true.

      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.


  wa_layout-colwidth_optimize = abap_true.  "Aqui habilitamos o ujuste automático de coluna do layout ALV com "abap_true" 
  wa_layout-zebra             = abap_true.  "Aqui habilitamos a cor zebra ao layout da tabela ALV com "abap_true"

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = wa_layout "Deixa a tabela ALV ajustada ao tamanho dos textos automáticamente
      it_fieldcat   = t_fieldcat
    TABLES
      t_outtab      = t_out
    EXCEPTIONS
      program_error = 1.

  IF sy-subrc IS NOT INITIAL.
    "TRATAMENTO DO ERRO
    MESSAGE e208(00) WITH 'ERRO GERAR O ALV!'.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_CRIA_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_cria_fcat USING VALUE(p_col_pos)  "USING indica que t_fieldcat está recebendo como valor todos esses parametros a frente de VALUE
                       VALUE(p_fieldname)
                       VALUE(p_tabname)
                       VALUE(p_ref_tabname)
                       VALUE(p_ref_fieldname)
                       VALUE(p_seltext_m)
                       VALUE(p_key)
                       VALUE(p_hotspot).

  CLEAR: wa_fieldcat.
  wa_fieldcat-col_pos       = p_col_pos. "Posição da coluna
  wa_fieldcat-fieldname     = p_fieldname. "Nome do campo que está na nossa tabela interna t_out. Ex: zz_re, zz_cargo...
  wa_fieldcat-tabname       = p_tabname. "Referencia da tabela para sabermos o tipo de dados que vai ser apresentado em campo. No caso t_out
  wa_fieldcat-ref_tabname   = p_ref_tabname. "Nome da tabela transparente. No caso zhr001_38
  wa_fieldcat-ref_fieldname = p_ref_fieldname. "Nome da tabela de referencia. Ex: Também zz_re, zz_cargo...
  wa_fieldcat-seltext_m     = p_seltext_m. "Tipo de texto para ser exibido; aqui podemos escolher o tamanho da fonte wa_fieldcat-sel<Apertando ctrl + espaço é possível ver as opções>
  wa_fieldcat-key           = p_key. "Indicar o campo chave com uma cor diferente para visualização do usuário 
  wa_fieldcat-hotspot       = p_hotspot. "Posibilita colocar um hiperlink
  APPEND wa_fieldcat TO t_fieldcat.

ENDFORM.
