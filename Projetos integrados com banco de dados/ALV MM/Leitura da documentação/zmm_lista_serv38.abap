REPORT zmm_lista_serv38.

"1 – Tela de seleção:
*Campos
*S_MATNR	Material	SELECT-OPTION
*S_MATKL	Grupo de mercadorias	SELECT-OPTION
*S_WERKS	Centro	SELECT-OPTION
*S_EKGRP	Grupo de compradores	SELECT-OPTION

*TELA DE SELEÇÃO especificada no documento:
SELECT-OPTIONS: S_MATNR FOR MARA-MATNR,
                S_MATKL FOR MARA-MATKL,
                "S_WERKS FOR MARC-WERKS,
                "S_EKGRP FOR MARC-EKGRP.

*Buscar campos ( MATNR, MTART, MEINS e MATKL) da tabela MARA(...) em código fica:

SELECT MARA~MATNR
       MARA~MTART
       MARA~MEINS
       MARA~MATKL
*é necessário depois com o desenrolar do código inserir isto em uma tabela com INTO TABLE
FROM MARA 

*(...) com as seguintes condições:
*                        MARA-MATNR = S_MATNR E 
*                        MTART = ‘DIEN’ 
*                       E MATKL = S_ MATKL, (...)
*em código fica:
 
WHERE MARA~MATNR IN S_MATNR  "MARA-MATNR = S_MATNR
AND MTART EQ 'DIEN'  "E MTART = ‘DIEN’ 
AND MATKL IN S_ MATKL,  "E MATKL = S_ MATKL
