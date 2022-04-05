*&---------------------------------------------------------------------*
*& Report ZALV_INTERACTIVE_YBC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV_INTERACTIVE_YBC.

types: begin of SFLIGHT,
       carrid type s_carr_id,
       connid type s_conn_id,
       price type s_price,
       end of SFLIGHT.

Data: it_SFLIGHT type STANDARD TABLE OF SFLIGHT.
data: it_fcat type slis_t_fieldcat_Alv,
      wa_fcat like line of it_fcat.

START-OF-SELECTION.
SELECT carrid connid price from SFLIGHT into table it_SFLIGHT up to 100 rows.

"añade columna CARRID
wa_fcat-fieldname = 'CARRID'."campo
wa_fcat-seltext_m = 'Airline Code'."Titulo columna
wa_fcat-key       = 'X'."pinta columna de color azul
wa_fcat-hotspot   = 'X'. "sibralla contenido del campo
append wa_fcat to it_fcat.
clear wa_fcat.

wa_fcat-fieldname = 'CONNID'.
wa_fcat-seltext_m = 'Flight Number'.
append wa_fcat to it_fcat.
clear wa_fcat.

wa_fcat-fieldname = 'PRICE'.
wa_fcat-seltext_m = 'Airfare'.
append wa_fcat to it_fcat.
clear wa_fcat.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   IT_FIELDCAT                       = it_fcat
  TABLES
    t_outtab                          = it_SFLIGHT
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.