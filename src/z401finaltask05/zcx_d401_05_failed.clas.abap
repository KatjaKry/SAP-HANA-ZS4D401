CLASS zcx_d401_05_failed DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
          text TYPE string OPTIONAL.

    METHODS get_my_text RETURNING VALUE(rv_text) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
        DATA mv_text TYPE string.

ENDCLASS.



CLASS zcx_d401_05_failed IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( ).
    mv_text = COND #( WHEN text IS INITIAL THEN 'LOW CARGO TRUCK!' ).
  ENDMETHOD.

  METHOD get_my_text.
    rv_text = mv_text.
  ENDMETHOD.


ENDCLASS.
