CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:
      already_saved TYPE abap_boolean.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS validateorderstatus FOR VALIDATE ON SAVE
       keys FOR header~validateorderstatus.
    METHODS setlastchange FOR DETERMINE ON SAVE
       keys FOR header~setlastchange.
    METHODS validateorderemail FOR VALIDATE ON SAVE
      keys FOR header~validateorderemail.
ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_features.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
        ENTITY Header
        FIELDS ( Createon Imageurl LastChangedAt LocalLastChangeAt )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(lt_headers)
        FAILED failed.

    LOOP AT lt_headers INTO DATA(ls_header).
      SELECT SINGLE id
          FROM zc_header_0414
          WHERE Id EQ @ls_header-Id
          INTO @DATA(lv_dummy_id).
      result = VALUE #( BASE result (
          %tky = ls_header-%tky
          %field-Imageurl = COND #( WHEN lv_dummy_id IS INITIAL
                                      THEN if_abap_behv=>fc-f-unrestricted
                                      ELSE if_abap_behv=>fc-f-read_only
                            )
         %field-Createon = COND #( WHEN lv_dummy_id IS INITIAL
                                      THEN if_abap_behv=>fc-f-unrestricted
                                      ELSE if_abap_behv=>fc-f-read_only
                            )
         %field-LastChangedAt = if_abap_behv=>fc-f-read_only
         %field-LocalLastChangeAt = if_abap_behv=>fc-f-read_only
      ) ).
      CLEAR: lv_dummy_id.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateOrderStatus.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
          ENTITY Header
          FIELDS ( Orderstatus )
          WITH CORRESPONDING #(  keys )
          RESULT DATA(lt_headers)
          FAILED DATA(lt_read_failed).

    failed = corresponding #(  DEEP Lt_read_failed ).

    LOOP AT lt_headers INTO DATA(ls_header).
        SELECT SINGLE status
        FROM zordstatus_0414
        WHERE status EQ @ls_header-Orderstatus
        INTO @DATA(lv_status)
        PRIVILEGED ACCESS.

        APPEND VALUE #( %tky = ls_header-%tky
            %state_area = 'VALIDATE_ORDER_STATUS'
        ) TO reported-header.

        IF lv_status IS INITIAL.
            APPEND VALUE #( %tky = ls_header-%tky ) TO failed-header.

            APPEND VALUE #( %tky = ls_header-%tky
                %state_area = 'VALIDATE_ORDER_STATUS'
                %msg = me->new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = |The order status { ls_header-Orderstatus } does not exist|
                )
                %element-orderstatus = if_abap_behv=>mk-on
            ) TO reported-header.
        ENDIF.

    ENDLOOP.



  ENDMETHOD.
  METHOD setLastChange.
    IF lhc_Header=>already_saved EQ abap_false.
      lhc_Header=>already_saved = abap_true.
      READ ENTITIES OF zi_header_0414 IN LOCAL MODE
          ENTITY Header
          FIELDS ( Id LastChangedAt )
          WITH CORRESPONDING #(  keys )
          RESULT DATA(lt_headers).

      MODIFY ENTITIES OF zi_header_0414 IN LOCAL MODE
         ENTITY header
         UPDATE FIELDS (  LastChangedAt )
         WITH VALUE #(  FOR ls_header IN lt_headers (
             %tky = ls_header-%tky
             LastChangedAt = |{ cl_abap_context_info=>get_system_date( ) }|
         ) ).
    ENDIF.
  ENDMETHOD.

  METHOD validateOrderEmail.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
          ENTITY Header
          FIELDS ( Email )
          WITH CORRESPONDING #(  keys )
          RESULT DATA(lt_headers)
          FAILED DATA(lt_read_failed).

    failed = corresponding #(  DEEP Lt_read_failed ).

    LOOP AT lt_headers INTO DATA(ls_header).
        APPEND VALUE #( %tky = ls_header-%tky
            %state_area = 'VALIDATE_ORDER_EMAIL'
        ) TO reported-header.

        IF ls_header-Email IS INITIAL.
            APPEND VALUE #( %tky = ls_header-%tky ) TO failed-header.

            APPEND VALUE #( %tky = ls_header-%tky
                %state_area = 'VALIDATE_ORDER_EMAIL'
                %msg = me->new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = |The order email must not be empty|
                )
                %element-orderstatus = if_abap_behv=>mk-on
            ) TO reported-header.
        ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
