CLASS lhc_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Items RESULT result.

    METHODS validateName FOR VALIDATE ON SAVE
      keys FOR Items~validateName.
    METHODS validateDescription FOR VALIDATE ON SAVE
      keys FOR Items~validateDescription.

ENDCLASS.

CLASS lhc_items IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateName.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
          ENTITY Items
          FIELDS ( Name )
          WITH CORRESPONDING #(  keys )
          RESULT DATA(lt_items)
          FAILED DATA(lt_read_failed).

    failed = corresponding #(  DEEP Lt_read_failed ).

    LOOP AT lt_items INTO DATA(ls_item).


        APPEND VALUE #( %tky = ls_item-%tky
            %state_area = 'VALIDATE_NAME'
        ) TO reported-header.

        IF ls_item-Name IS INITIAL.
            APPEND VALUE #( %tky = ls_item-%tky ) TO failed-header.

            APPEND VALUE #( %tky = ls_item-%tky
                %state_area = 'VALIDATE_NAME'
                %msg = me->new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = |The name must not be empty|
                )
                %element-orderstatus = if_abap_behv=>mk-on
            ) TO reported-header.
        ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateDescription.
    READ ENTITIES OF zi_header_0414 IN LOCAL MODE
          ENTITY Items
          FIELDS ( Description )
          WITH CORRESPONDING #(  keys )
          RESULT DATA(lt_items)
          FAILED DATA(lt_read_failed).

    failed = corresponding #(  DEEP Lt_read_failed ).

    LOOP AT lt_items INTO DATA(ls_item).


        APPEND VALUE #( %tky = ls_item-%tky
            %state_area = 'VALIDATE_DESCRIPTION'
        ) TO reported-header.

        IF ls_item-Description IS INITIAL.
            APPEND VALUE #( %tky = ls_item-%tky ) TO failed-header.

            APPEND VALUE #( %tky = ls_item-%tky
                %state_area = 'VALIDATE_DESCRIPTION'
                %msg = me->new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = |The description must not be empty|
                )
                %element-orderstatus = if_abap_behv=>mk-on
            ) TO reported-header.
        ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

