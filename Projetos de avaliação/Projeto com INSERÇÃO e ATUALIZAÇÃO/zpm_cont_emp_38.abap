REPORT zpm_cont_emp_38.

"Esses sao os campos da minha tabela ztpm001_38 no banco de dados
*MANDT
*ZZNUM
*MATNR
*MENGE
*PARNR
*WERKS
*DATA_EMP
*
*



*ztpm001_38 é o nome da minha tabela física no banco de dados
DATA: wa_001    TYPE ztpm001_38,
      lv_number TYPE num10.

CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr             = '38'
    object                  = 'ZNUMPM0001' "=> USAR ESSE OBJETO!
  IMPORTING
    number                  = lv_number "NUMERO GERADO PARA O CONTROLE
  EXCEPTIONS
    interval_not_found      = 1
    number_range_not_intern = 2
    object_not_found        = 3
    quantity_is_0           = 4
    quantity_is_not_1       = 5
    interval_overflow       = 6
    buffer_overflow         = 7.

"tb0 é o título que definimos em elemento de texto -> Símbolos de texto 
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_data  TYPE ztpm001_38-data_emp DEFAULT sy-datum,
            p_hora  TYPE ztpm001_38-hora_emp DEFAULT sy-uzeit,
            p_matnr TYPE ztpm001_38-matnr,
            p_menge TYPE ztpm001_38-menge,
            p_parnr TYPE ztpm001_38-parnr,
            p_stt   TYPE ztpm001_38-zzstatus,
            p_werks TYPE ztpm001_38-werks,
            p_num   TYPE ztpm001_38-zznum OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b0.

INITIALIZATION.
  p_num = lv_number.

AT SELECTION-SCREEN.

  IF p_num IS NOT INITIAL
    AND p_num NE wa_001-zznum.
    SELECT SINGLE data_emp
                  hora_emp
                  matnr
                  menge
                  parnr
                  zzstatus
                  werks
                  zznum
          INTO (p_data, p_hora, p_matnr, p_menge, p_parnr, p_stt, p_werks, p_num )
          FROM ztpm001_38
          WHERE zznum  EQ p_num.

    IF sy-subrc IS NOT INITIAL.
      CLEAR:  p_data,
              p_hora,
              p_matnr,
              p_menge,
              p_parnr,
              p_stt,
              p_werks.
    ELSE.
      wa_001-zznum = p_num.
    ENDIF.
  ENDIF.



AT SELECTION-SCREEN OUTPUT.


AT SELECTION-SCREEN ON EXIT-COMMAND.


START-OF-SELECTION.

  CLEAR: wa_001.

  wa_001-data_emp    = p_data.
  wa_001-hora_emp   = p_hora.
  wa_001-matnr     = p_matnr.
  wa_001-menge = p_menge.
  wa_001-parnr   = p_parnr.
  wa_001-zzstatus   = p_stt.
  wa_001-werks   = p_werks.
  wa_001-zznum   = p_num.


  SELECT COUNT(*)
    FROM ztpm001_38 UP TO 1 ROWS
  WHERE zznum  EQ p_num.

  IF sy-dbcnt GT 0.
    PERFORM f_update.
    PERFORM f_commit.
  ELSE.
    PERFORM f_insert.
    PERFORM f_commit.
  ENDIF.



*&---------------------------------------------------------------------*
*&      Form  F_INSERT
*&---------------------------------------------------------------------*
*       Inserir colaborador na tabela zhr001_00
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_insert.

*  MODIFY zhr001_38 FROM wa_001. "
  INSERT ztpm001_38 FROM wa_001. "ok


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_UPDATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_update .
  MODIFY ztpm001_38 FROM wa_001.
ENDFORM.

FORM f_commit.
  IF sy-subrc EQ 0.
    COMMIT WORK AND WAIT.
    MESSAGE s208(00) WITH 'SALVO COM SUCESSO!'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s001(z00) WITH 'ERRO AO GRAVAR!' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
