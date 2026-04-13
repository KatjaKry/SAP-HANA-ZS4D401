class ltcl_flights definition final for testing
  duration long
  risk level harmless.

  private section.
    methods:
      test_find_cargo_flight for testing raising cx_static_check.

  CLASS-METHODS class_setup.
  CLASS-DATA the_carrier TYPE REF TO lcl_carrier.
  CLASS-DATA some_flight_data TYPE /lrn/cargoflight.

endclass.


class ltcl_flights implementation.

  method test_find_cargo_flight.
*    "Test 1
*    select single from /LRN/CARGOFLIGHT fields carrier_id, connection_id, flight_date, airport_from_id, airport_to_id
*                                 into @data(some_flight_data).
*
*    if sy-subrc <> 0.
*      cl_abap_unit_assert=>fail( 'Keine Daten in der Tabelle:  /lrn/cargoflight' ).
*    endif.
*
*    "Test 2
*     try.
*       data(the_carrier) = new lcl_carrier(  i_carrier_id = some_flight_data-carrier_id ).
*         catch cx_root.
*         cl_abap_unit_assert=>fail( 'Die Klasse: lcl_carrier konnte nicht instanziiert werden' ).
*
*   endtry.

   "Test 3

      the_carrier->find_cargo_flight(
         EXPORTING
           i_airport_from_id = some_flight_data-airport_from_id
           i_airport_to_id   = some_flight_data-airport_to_id
           i_from_date       = some_flight_data-flight_date
           i_cargo           = 1
         IMPORTING
           e_flight =     data(cargo_flight)
           e_days_later = DATA(days_later) ) .

      cl_abap_unit_assert=>assert_bound(   "Check: act ist not INITIAL, oder msg
        EXPORTING
          act   = cargo_flight
          msg = 'Die Metode: find_cargo_flight gibt kein Ergebniss zurück' ).

       cl_abap_unit_assert=>assert_equals(
              act = days_later
              exp = 0
             msg = `Method find_cargo_flight returns wrong result` ).

  endmethod.

  METHOD class_setup.
*    "Test 1
    SELECT SINGLE FROM /lrn/cargoflight FIELDS carrier_id, connection_id,flight_date,
                                        airport_from_id, airport_to_id
                    INTO  CORRESPONDING FIELDS OF @some_flight_data.
    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail( 'Keine Daten in der Tabelle: /lrn/cargoflight' ).
    ENDIF.

    "Test 2
    TRY.
        ltcl_flights=>the_carrier = NEW lcl_carrier( i_carrier_id = some_flight_data-carrier_id  ).
*        DATA(the_carrier) = NEW lcl_carrier( i_carrier_id = some_flight_data-carrier_id  ).  "Falsch

*      ltcl_flights=>the_carrier = the_carrier.

      CATCH cx_root.
        cl_abap_unit_assert=>fail( 'Die Klasse: lcl_carrier konnet nicht instanziiert werden' ).
    ENDTRY.



  ENDMETHOD.

endclass. "* use this source file for your ABAP unit test classes
