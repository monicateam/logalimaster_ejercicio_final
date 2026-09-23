CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features for Header RESULT result.

    METHODS validateorderstatus FOR VALIDATE ON SAVE
      keys FOR header~validateorderstatus.
    METHODS setlastchange FOR DETERMINE ON MODIFY
      keys FOR header~setlastchange.
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
            INTO @data(lv_dummy_id).
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
  ENDMETHOD.

  METHOD setLastChange.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
        ENTITY Header
        FIELDS ( LastChangedAt )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(lt_headers).

     MODIFY ENTITIES OF zi_header_0414 IN LOCAL MODE
        ENTITY header
        UPDATE FIELDS (  LastChangedAt )
        WITH VALUE #(  FOR ls_header IN lt_headers (
            %tky = ls_header-%tky
            LastChangedAt = |{ cl_abap_context_info=>get_system_date( ) }|
        ) ).
  ENDMETHOD.

ENDCLASS.
