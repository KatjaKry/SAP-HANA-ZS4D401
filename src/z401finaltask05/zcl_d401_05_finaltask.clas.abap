CLASS zcl_d401_05_finaltask DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d401_05_finaltask IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_rental) = NEW lcl_rental(  ).
     lo_rental->add_vehicle( NEW lcl_truck( iv_make  = 'MAN'
                                            iv_model = 'T1'
                                            iv_price = 5000
                                            iv_color = 'Rot'
                                            iv_cargo = 18700 ) ).   "Up Cast implizit

     lo_rental->add_vehicle( NEW lcl_truck( iv_make  = 'SCANIA'
                                            iv_model = 'T2'
                                            iv_price = 6000
                                            iv_color = 'Blau'
                                            iv_cargo = 19800 ) ).   "Up Cast implizit

     lo_rental->add_vehicle( NEW lcl_truck( iv_make  = 'SCANIA'
                                            iv_model = 'T3'
                                            iv_price = 1500
                                            iv_color = 'Blau'
                                            iv_cargo = 1700 ) ).   "Up Cast implizit

     lo_rental->add_vehicle( NEW lcl_truck( iv_make  = 'SCANIA'
                                            iv_model = 'T4'
                                            iv_price = 7000
                                            iv_color = 'Grün'
                                            iv_cargo = 18000 ) ).   "Up Cast implizit
     lo_rental->add_vehicle( NEW lcl_truck( iv_make  = 'RENAULT'
                                            iv_model = 'T5'
                                            iv_price = 6500
                                            iv_color = 'Grün'
                                            iv_cargo = 20000 ) ).   "Up Cast implizit

      lo_rental->add_vehicle( NEW lcl_bus(  iv_make  = 'Mercedes'
                                            iv_model = 'B1'
                                            iv_price = 4000
                                            iv_color = 'Weiß'
                                            iv_seats = 20 ) ).   "Up Cast implizit

     lo_rental->add_vehicle( NEW lcl_bus(   iv_make  = 'Mercedes'
                                            iv_model = 'B2'
                                            iv_price = 4200
                                            iv_color = 'Weiß'
                                            iv_seats = 25 ) ).   "Up Cast implizit

    lo_rental->add_vehicle( NEW lcl_bus(    iv_make  =  'Mercedes'
                                            iv_model = 'B3'
                                            iv_price = 4500
                                            iv_color = 'Blau'
                                            iv_seats = 40 ) ).   "Up Cast implizit

    lo_rental->add_vehicle( NEW lcl_bus(    iv_make  = 'Mercedes'
                                            iv_model = 'B4'
                                            iv_price = 4700
                                            iv_color = 'Rot'
                                            iv_seats = 20 ) ).   "Up Cast implizit


    lo_rental->add_vehicle( NEW lcl_bus(    iv_make  = 'Mercedes'
                                            iv_model = 'B5'
                                            iv_price = 5000
                                            iv_color = 'Silber'
                                            iv_seats = 50 ) ).   "Up Cast implizit


    lo_rental->display_all( out ).

    DATA(lo_max) = lo_rental->get_max_cargo( ).
    IF lo_max IS BOUND.
      out->write( |MAX CARGO TRUCK:| ).
      lo_max->display_attributes( out ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
