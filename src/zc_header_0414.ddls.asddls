@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_HEADER_0414 
    provider contract transactional_query
    as projection on ZI_HEADER_0414
{
    key Id,
    Email,
    Firstname,
    Lastname,
    CustomerFullName,
    Country,
    Createon,
    Deliverydate,
    @ObjectModel.text.element: ['OrderStatusDescr']
    @Consumption.valueHelpDefinition: [{
        entity: { name: 'ZC_ORDER_STATUS_0414', element: 'Status' }
    }]
    Orderstatus,
    Imageurl,
    LastChangedAt,
    LocalLastChangeAt,
    _OrderStatus.Description as OrderStatusDescr,
    /* Associations */
    _Items: redirected to composition child zc_items_0414,
    _OrderStatus
}
