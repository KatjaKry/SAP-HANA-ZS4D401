*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_vehicle DEFINITION.

  PUBLIC SECTION.

    TYPES ty_price TYPE p LENGTH 8 DECIMALS 2.

    METHODS: constructor
            IMPORTING
              iv_make  TYPE string
              iv_model TYPE string
              iv_price TYPE ty_price
              iv_color TYPE string.


    METHODS: display_attributes
         IMPORTING out TYPE REF TO if_oo_adt_classrun_out.


  PRIVATE SECTION.

    DATA mv_make  TYPE string.
    DATA mv_model TYPE string.
    DATA mv_price TYPE ty_price.
    DATA mv_color TYPE string.

ENDCLASS.


 CLASS lcl_vehicle IMPLEMENTATION.

    METHOD constructor.
       mv_make  = iv_make.
       mv_model = iv_model.
       mv_price = iv_price.
       mv_color = iv_color.

    ENDMETHOD.


    METHOD display_attributes.
*          rv_text =  |{ mv_make } { mv_model } { mv_price } { mv_color }|.
          out->write( |{ mv_make } { mv_model } { mv_price } { mv_color }| ).
    ENDMETHOD.

ENDCLASS.


 CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.

   PUBLIC SECTION.

      METHODS: constructor
            IMPORTING
              iv_make  TYPE string
              iv_model TYPE string
              iv_price TYPE ty_price
              iv_color TYPE string
              iv_cargo TYPE i.

      METHODS get_cargo RETURNING VALUE(r_result) TYPE i.

      METHODS display_attributes REDEFINITION.

    PRIVATE SECTION.

      DATA mv_cargo TYPE i.

  ENDCLASS.




  CLASS lcl_truck IMPLEMENTATION.

      METHOD constructor.
            super->constructor(
                             iv_make  = iv_make
                             iv_model = iv_model
                             iv_price = iv_price
                             iv_color = iv_color ).

                             mv_cargo = iv_cargo.
      ENDMETHOD.

      METHOD get_cargo.
            r_result = mv_cargo.
      ENDMETHOD.


      METHOD display_attributes.

         TRY.
           IF mv_cargo < 2000.
                 RAISE EXCEPTION TYPE zcx_d401_05_failed.   " Variable "text" -> INITIAL (leer)

           ENDIF.
*           super->display_attributes( out ).
*           out->write( |Cargo: { mv_cargo }| ).
         CATCH zcx_d401_05_failed INTO DATA(lo_exc).
            out->write( lo_exc->get_my_text( ) ).

         ENDTRY.

         super->display_attributes( out ).
         out->write( |Cargo: { mv_cargo }| ).
         out->write( |--------------------------------| ).


      ENDMETHOD.


  ENDCLASS.

 CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.

   PUBLIC SECTION.

       METHODS: constructor
            IMPORTING
              iv_make  TYPE string
              iv_model TYPE string
              iv_price TYPE ty_price
              iv_color TYPE string
              iv_seats TYPE i.

       METHODS get_seats RETURNING VALUE(r_result) TYPE i.

       METHODS display_attributes REDEFINITION.

     PRIVATE SECTION.

       DATA mv_seats TYPE i.

 ENDCLASS.

 CLASS lcl_bus IMPLEMENTATION.

       METHOD constructor.
             super->constructor(
                               iv_make  = iv_make
                               iv_model = iv_model
                               iv_price = iv_price
                               iv_color = iv_color ).

                               mv_seats = iv_seats.
       ENDMETHOD.

      METHOD get_seats.
            r_result = mv_seats.
      ENDMETHOD.


      METHOD display_attributes.
             super->display_attributes( out ).
             out->write( |Seats: { mv_seats }| ).
             out->write( |--------------------------------| ).
      ENDMETHOD.


 ENDCLASS.

 CLASS lcl_rental DEFINITION.
    PUBLIC SECTION.

        METHODS: add_vehicle IMPORTING io_vehicle TYPE REF TO lcl_vehicle.

        METHODS: display_all IMPORTING out TYPE REF TO if_oo_adt_classrun_out.

        METHODS get_max_cargo RETURNING VALUE(max_truck) TYPE REF TO lcl_truck.

    PRIVATE SECTION.

         TYPES tt_collection TYPE STANDARD TABLE OF REF TO lcl_vehicle WITH DEFAULT KEY.
         DATA collection TYPE tt_collection.

  ENDCLASS.

 CLASS lcl_rental IMPLEMENTATION.

     METHOD add_vehicle.
            APPEND io_vehicle TO collection.

     ENDMETHOD.

     METHOD display_all.
           LOOP AT collection INTO DATA(lo_vehicle).
                   lo_vehicle->display_attributes( out ).  "Polymorphism
           ENDLOOP.

     ENDMETHOD.

     METHOD get_max_cargo.

        DATA max TYPE i VALUE 0.

        LOOP AT collection INTO DATA(lo_vehicle).

           IF lo_vehicle IS INSTANCE OF lcl_truck.

              DATA(lo_truck) = CAST lcl_truck( lo_vehicle ).  "Down Cast

              IF lo_truck->get_cargo( ) > max.
                 max = lo_truck->get_cargo( ).
                 max_truck = lo_truck.
           ENDIF.

         ENDIF.
       ENDLOOP.
     ENDMETHOD.

ENDCLASS.
