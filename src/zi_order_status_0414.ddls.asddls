@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order status view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ORDER_STATUS_0414 as select from zordstatus_0414
{
    key status as Status,
    description as Description
}
