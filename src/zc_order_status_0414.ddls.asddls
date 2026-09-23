@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view order status description'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_ORDER_STATUS_0414 
    provider contract transactional_query
    as projection on ZI_ORDER_STATUS_0414
{
    key Status,
    Description
}
