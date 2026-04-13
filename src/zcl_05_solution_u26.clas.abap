CLASS zcl_05_solution_u26 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_05_SOLUTION_U26 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
     CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'UA'.    "Übung 24  Prüfen

    TRY.
        DATA(carrier) = lcl_carrier=>get_instance(  i_carrier_id = c_carrier_id ).   "Übung 23

        out->write(  name = `Carrier Overview`
                     data = carrier->get_output(  ) ).

      CATCH zcx_05_failed INTO DATA(exc_fail).              "Übung 24   Übung 25
         out->write(  exc_fail->get_text(  ) ).
*        out->write( | Carrier { c_carrier_id } does not exist | ).
      catch cx_abap_auth_check_exception  INTO data(exc_auth).    "Übung 24
       data(text) = exc_auth->get_text(  ).
       out->write(  text ).
*        " out->write( lx_excp->get_text(  ) ).       "Übung 18    Übung 24
*        out->write( 'Keine Berechtigung für die Fluggesellschaft:  '  && c_carrier_id ).       "Übung 18
    ENDTRY.

    IF carrier IS BOUND.

      out->write(  `--------------------------------------------------` ).

* Find a passenger flight from Frankfurt to New York
* starting as soon as possible after tomorrow
* with at least 5 free seats

      DATA(today) = cl_abap_context_info=>get_system_date(  ).

      carrier->find_passenger_flight(
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_seats           = 5
         IMPORTING
           e_flight =     DATA(pass_flight)
           e_days_later = DATA(days_later)
                         ).

      IF pass_flight IS BOUND.
        out->write( name = |Found a suitable passenger flight in { days_later } days:|
*                    data = pass_flight->lif_output~get_output(  ) ).       "Übung 22
                     data = pass_flight->get_output(  ) ).                   "Übung 22  Mit Alias
      ELSE.
        out->write( data = `No Passenger Flight found` ).
      ENDIF.

      out->write(  `--------------------------------------------------` ).

** Find a cargo flight from Frankfurt to New York
** starting as soon as possible but earliest in 7 days
** with at least 1200 KG free capacity
*
      carrier->find_cargo_flight(
         EXPORTING
           i_airport_from_id = 'FRA'
           i_airport_to_id   = 'JFK'
           i_from_date       = today
           i_cargo           = 1200
         IMPORTING
           e_flight =     DATA(cargo_flight)
           e_days_later = DATA(days_later2)
                         ).

      IF cargo_flight IS BOUND.
        out->write( name = |Found a suitable cargo flight in { days_later2 } days:|
*                    data = cargo_flight->lif_output~get_output(  ) ).    "Übung 22
                     data = cargo_flight->get_output(  ) ).                "Übung 22   Mit Alias
      ELSE.
        out->write( data = `No cargo flight found` ).
      ENDIF.



    ENDIF.

  ENDMETHOD.
ENDCLASS.
