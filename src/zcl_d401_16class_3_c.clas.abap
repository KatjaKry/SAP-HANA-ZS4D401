CLASS zcl_d401_16class_3_c DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d401_16class_3_c IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lo_plane TYPE REF TO lcl_super.
    DATA lt_collection TYPE TABLE OF REF TO lcl_super.





    DATA(lo_cargo_plane) = NEW lcl_cargo_plane( ).
    APPEND lo_cargo_plane TO lt_collection.                   "Up Cast
    lo_cargo_plane = NEW lcl_cargo_plane( ).
    APPEND lo_cargo_plane TO lt_collection.                   "Up Cast


    DATA(lo_passenger_plane) = NEW lcl_passenger_plane( ).
    APPEND lo_passenger_plane TO lt_collection.               "Up Cast
    lo_passenger_plane = NEW lcl_passenger_plane( ).
    APPEND lo_passenger_plane TO lt_collection.                "Up Cast

    DATA(lo_banane) = NEW lcl_banane( ).
    APPEND lo_banane TO lt_collection.  "Up Cast

    CLEAR lo_passenger_plane.
    CLEAR lo_cargo_plane.
*    LOOP AT lt_collection INTO lo_plane WHERE table_line->mv_demo_01 = 100.
    LOOP AT lt_collection INTO lo_plane WHERE table_line IS INSTANCE OF lcl_passenger_plane.
      out->write( lo_plane->mv_demo_01 ).
      out->write( lo_plane->mv_demo_02 ).



      IF lo_plane IS INSTANCE OF lcl_passenger_plane.
        lo_passenger_plane ?= lo_plane.                            "Down Cast Variante 1.1
        lo_passenger_plane = CAST lcl_passenger_plane( lo_plane ). "Down Cast Variante 1.2

        out->write( lo_passenger_plane->mv_seats_max ). "Nach Down Cast können wir unique atribut mv_seats_max lesen
      ENDIF.


*
*      TRY.
*          lo_passenger_plane ?= lo_plane.      "Down Cast Variante 2
*          out->write( lo_passenger_plane->mv_seats_max ).
*        CATCH cx_root into data(lo_exc).
**          out->write(  lo_exc->get_text(  ) ).
*      ENDTRY.





    ENDLOOP.



  ENDMETHOD.
ENDCLASS.
