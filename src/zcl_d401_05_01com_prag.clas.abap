CLASS zcl_d401_05_01com_prag DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d401_05_01com_prag IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

     SELECT FROM /dmo/connection FIELDS * INTO TABLE @DATA(lt_result).  "#EC CI_NOWHERE

     out->write(   EXPORTING data = lt_result name = 'Connection-1' ) ##NO_TEXT.

  ENDMETHOD.
ENDCLASS.
