@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header view entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_HEADER_0414 as select from zheader_0414
    composition [0..*] of ZI_ITEMS_0414 as _Items
    association [0..1] to ZC_ORDER_STATUS_0414 as _OrderStatus on $projection.Orderstatus = _OrderStatus.Status
{
    key id as Id,
    email as Email,
    firstname as Firstname,
    lastname as Lastname,
    concat_with_space( firstname, lastname, 1) as CustomerFullName,
    country as Country,
    createon as Createon,
    deliverydate as Deliverydate,
    orderstatus as Orderstatus,
    imageurl as Imageurl,
    last_change_at as LastChangedAt,
    local_last_changed_at as LocalLastChangeAt,
    _Items,
    _OrderStatus
}
