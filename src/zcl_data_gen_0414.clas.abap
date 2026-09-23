CLASS zcl_data_gen_0414 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF mtyp_s_status,
            status TYPE zheader_0414-orderstatus,
           END OF mtyp_s_status,
           mtyp_t_status TYPE STANDARD TABLE OF mtyp_s_status
                           WITH NON-UNIQUE DEFAULT KEY,
           mtyp_t_zordstatus_0414 TYPE STANDARD TABLE OF zordstatus_0414,
           BEGIN OF mtyp_s_items,
             name TYPE zde_name_0414,
             description TYPE zde_description_0414,
             price TYPE zde_price_0414,
             waers TYPE waers,
             height TYPE zde_height_0414,
             width TYPE zde_width_0414,
             depth TYPE zde_depth_0414,
             dimensions_uom TYPE meins,
             unitofmeasure TYPE meins,
           END OF mtyp_s_items,
           mtyp_t_items TYPE STANDARD TABLE OF mtyp_s_items
                            WITH NON-UNIQUE DEFAULT KEY.

  PROTECTED SECTION.


     CLASS-METHODS: get_order_status
              EXPORTING
              et_status TYPE mtyp_t_status
              et_status_descr TYPE mtyp_t_zordstatus_0414,
                    get_items
                        RETURNING VALUE(rt_items) TYPE mtyp_t_items.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_gen_0414 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    DATA: lt_header       TYPE STANDARD TABLE OF zheader_0414,
          lt_items        TYPE STANDARD TABLE OF zitems_0414,
          lt_status_descr TYPE STANDARD TABLE OF zordstatus_0414,
          lt_order_status TYPE mtyp_t_status,
          lv_count_header TYPE i,
          lv_count_item   TYPE i,
          lv_id_header TYPE zheader_0414-id,
          lv_id_item TYPE zitems_0414-item_uuid,
          lv_quantity TYPE i.

    get_order_status(
        IMPORTING
        et_status = lt_order_status
        et_status_descr = lt_status_descr
    ).
    DATA(lt_items_random) = get_items( ).

    out->write( 'Deleting previous data' ).

    DELETE FROM zheader_0414.
    DELETE FROM zitems_0414.
    DELETE FROM zordstatus_0414.

    DATA(lo_rand) = cl_abap_random=>create( ).

    lv_count_header = 1.
    DO 30 TIMES.
      FINAL(lv_total_items) = lo_rand->intinrange( low = 1 high = 4 ).
      lv_id_header = |H-{ lv_count_header }|.

        DATA(lv_items_status) = lines(  lt_order_status ).
        DATA(lv_num) = lo_rand->intinrange( low = 1 high = lv_items_status ).
        READ TABLE lt_order_status INTO DATA(ls_order_status) INDEX lv_num.


      lt_header = VALUE #( BASE lt_header (
        id = |{ lv_id_header }|
        email = 'monica.sanchez@viseo.com'
        firstname = 'Monica'
        lastname = 'Sanchez'
        country = 'Spain'
        createon = |{ cl_abap_context_info=>get_system_date( ) }|
        deliverydate = |{ cl_abap_context_info=>get_system_date( ) }|
        orderstatus = |{ ls_order_status-status }|
        imageurl = ''
      ) ).

    lv_count_item = 1.
     DO lv_total_items TIMES.
        DATA(lv_num_random_item) = lo_rand->intinrange( low = 1 high = lines(  lt_items_random ) ).
        READ TABLE lt_items_random INTO DATA(ls_item_random) INDEX lv_num_random_item.

        lv_id_item = |I-{ lv_count_header }-{ lv_count_item }|.
        lv_quantity = lo_rand->intinrange( low = 1 high = 6 ).
        lt_items = VALUE  #(  BASE lt_items (
          id = |{ lv_id_header }|
          item_uuid = |{ lv_id_item }|
          name = ls_item_random-name
          description = ls_item_random-description
          releasedate = |{ cl_abap_context_info=>get_system_date( ) }|
          price = ls_item_random-price * lv_quantity
          waers = ls_item_random-waers
          height = ls_item_random-height
          width = ls_item_random-width
          depth = ls_item_random-depth
          dimensions_uom = ls_item_random-dimensions_uom
          quantity = lv_quantity
          unitofmeasure = ls_item_random-unitofmeasure
        ) ).
    lv_count_item = lv_count_item + 1.

     ENDDO.

      lv_count_header = lv_count_header + 1.
    ENDDO.

    INSERT zheader_0414 FROM TABLE @lt_header.
    INSERT zitems_0414 FROM TABLE @lt_items.
    INSERT zordstatus_0414 FROM TABLE @lt_status_descr.

  ENDMETHOD.

  method get_order_status.
    et_status = VALUE #( ( status = 1 )  ( status = 2 )
        ( status = 3 )  ( status = 4 ) ( status = 5 )
    ).

    et_status_descr = VALUE #( ( status = 1 description = 'New' )  ( status = 2 description = 'Processing' )
        ( status = 3 description = 'Cancelled' )  ( status = 4 description = 'Shipped' ) ( status = 5 description = 'Received' )
    ).
  ENDMETHOD.

  METHOD get_items.
    rt_items = VALUE #(
        (
           name = 'FF13 Magic TCG Pack' description = 'Set of FF13 TCG' price = 40
           waers = 'EUR' height = 30 width = 55 depth = 50 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'FF14 Magic TCG Pack' description = 'Set of FF14 TCG' price = 33
           waers = 'EUR' height = 30 width = 55 depth = 50 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Lightning Keychain' description = 'Keychain of Lightning FFXIII' price = 7
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Snow Keychain' description = 'Keychain of Snow FFXIII' price = 8
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Hope Keychain' description = 'Keychain of Hope FFXIII' price = 7
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Sazh Keychain' description = 'Keychain of Sazh FFXIII' price = 9
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Vanille Keychain' description = 'Keychain of Vanille FFXIII' price = 10
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
        (
           name = 'Fang Keychain' description = 'Keychain of Fang FFXIII' price = 6
           waers = 'EUR' height = 14 width = 10 depth = 2 dimensions_uom = 'CM'
           unitofmeasure = 'ST'
        )
    ).
  ENDMETHOD.

ENDCLASS.
