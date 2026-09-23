@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items root entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_items_0414 as projection on ZI_ITEMS_0414
{
    key Id,
    key UUID,
    Name,
    Description,
    Releasedate,
    Discontinueddate,
    @Semantics.amount.currencyCode: 'Waers'
    Price,
    @Consumption.valueHelpDefinition: [{
        entity: { name: 'I_Currency', element: 'Currency' },
        useForValidation: true
    }]
    Waers,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    Height,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    Width,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    Depth,
    DimensionsUom,
    Quantity,
    Unitofmeasure,
    LastChangedAt,
    LocalLastChangeAt,
    /* Associations */
    _Header: redirected to parent ZC_HEADER_0414,
    _Currency
}
