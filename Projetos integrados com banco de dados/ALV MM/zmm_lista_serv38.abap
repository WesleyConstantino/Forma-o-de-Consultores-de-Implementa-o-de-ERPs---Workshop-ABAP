REPORT zmm_lista_serv38.

TYPES: BEGIN OF type_serv,       "BEGIN OF serve para escolher os campos que quero que sejam lidos de uma determinada tabela transparente
         matnr TYPE mara-matnr,  "Campos que quero que sejam lidos aqui.
         mtart TYPE mara-mtart,
         meins TYPE mara-meins,
         matkl TYPE mara-matkl,
         werks TYPE marc-werks,
         ekgrp TYPE marc-ekgrp,
         vprsv TYPE mbew-vprsv,
         verpr TYPE mbew-verpr,
         stprs TYPE mbew-stprs,
         peinh TYPE mbew-peinh,
       END OF type_serv,

       BEGIN OF type_makt,
         matnr TYPE mara-matnr,
         maktx TYPE zst_makt-maktx,
       END OF type_makt,

       BEGIN OF type_waers,
         werks TYPE t001w-werks,
         waers TYPE t001-waers,
       END OF type_waers.

* 1 – Tela de seleção:
********* PRIMEIRO PASSO ***********
DATA: v_matnr  TYPE mara-matnr,
      v_matkl  TYPE mara-matkl,
      v_werks  TYPE marc-werks,
      v_ekgrp  TYPE marc-ekgrp,

* 2 – Seleção de dados
      t_waers  TYPE TABLE OF type_waers,
      wa_waers LIKE LINE OF t_waers,

      t_makt   TYPE TABLE OF type_makt,
      wa_makt  LIKE LINE OF t_makt,

      t_serv   TYPE TABLE OF type_serv,
      wa_serv  TYPE type_serv,


* 3 – Output
      t_out    TYPE TABLE OF zsmm_lista_serv00.

INCLUDE zalv_00.


FIELD-SYMBOLS: <lfs_line> TYPE zsmm_lista_serv00.

* 1 – Tela de seleção:
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-s01.
SELECT-OPTIONS: s_matnr  FOR v_matnr,
                s_matkl  FOR v_matkl,
                s_werks  FOR v_werks,
                s_ekgrp  FOR v_ekgrp.
SELECTION-SCREEN END OF BLOCK b0.


START-OF-SELECTION.

  PERFORM f_select_data.
  PERFORM f_show_alv USING 'ZSMM_LISTA_SERV00'.
*&---------------------------------------------------------------------*
*&      Form  F_SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_select_data.

  SELECT  mara~matnr
          mara~mtart
          mara~meins
          mara~matkl
          marc~werks
          marc~ekgrp
          mbew~vprsv
          mbew~verpr
          mbew~stprs
          mbew~peinh
    INTO TABLE t_serv
    FROM mara INNER JOIN marc
    ON mara~matnr EQ marc~matnr
    INNER JOIN mbew
    ON marc~matnr EQ mbew~matnr
   AND marc~werks EQ mbew~bwkey
    WHERE mara~matnr IN s_matnr "WHERE <condição> são as condições da pesquisa do registro
      AND mara~mtart EQ 'DIEN' "Tratar isso com STVARV
      AND mara~matkl IN s_matkl "IN é usado para comparação de igualdade
      AND marc~werks IN s_werks
      AND marc~ekgrp IN s_ekgrp.

  IF t_serv[] IS INITIAL.
    MESSAGE e208(00) WITH 'NENHUM REGISTRO ENCONTRADO!'.
  ENDIF.

  SELECT  matnr
          maktx
   INTO TABLE t_makt
   FROM makt
   FOR ALL ENTRIES IN t_serv  "FOR ALL ENTRIES IN é similar ao INNER JOIN, porém só serve para fazer amarração de tabelas iternas e tem que ser usado antes de um "WHERE"
   WHERE matnr EQ t_serv-matnr
     AND spras EQ sy-langu.

  SELECT  t001w~werks
          t001~waers
    INTO TABLE t_waers
FROM t001w INNER JOIN t001k
ON t001k~bwkey EQ t001w~bwkey
INNER JOIN t001
ON t001~bukrs EQ t001k~bukrs
WHERE t001w~werks IN s_werks.

  SORT t_makt BY matnr.
  SORT t_waers BY werks.

  LOOP AT t_serv INTO wa_serv. "LOOP AT pega o conteúde que está na tabela interna "t_serv" e joga dentro da work area "wa_serv"
    CLEAR: wa_makt,
           wa_waers.

    APPEND INITIAL LINE TO t_out ASSIGNING <lfs_line>.

    MOVE-CORRESPONDING wa_serv TO <lfs_line>.


*    SE O CAMPO MBEW- VPRSV FOR IGUAL A ‘V’
*    TRANSFERIR O VALOR DE MBEW-VERPR/PEINH
*    PARA ZPRECO_00, SENAOMBEW-STPRS/PEINH = ZPRECO_00

    IF wa_serv-vprsv EQ 'V'.
      <lfs_line>-preco = ( wa_serv-verpr / wa_serv-peinh ).
    ELSE. "S
      <lfs_line>-preco = ( wa_serv-stprs / wa_serv-peinh ).
    ENDIF.

    READ TABLE t_makt INTO wa_makt WITH KEY matnr = <lfs_line>-matnr
                                            BINARY SEARCH.
    IF sy-subrc IS INITIAL.
      <lfs_line>-maktx = wa_makt-maktx.
    ENDIF.

    READ TABLE t_waers INTO wa_waers WITH KEY werks = <lfs_line>-werks
                                            BINARY SEARCH.
    IF sy-subrc IS INITIAL.
      <lfs_line>-waers = wa_waers-waers.
    ENDIF.
  ENDLOOP.


ENDFORM.
