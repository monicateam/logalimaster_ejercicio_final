@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items view entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ITEMS_0414 as select from zitems_0414
    association to parent ZI_HEADER_0414 as _Header on $projection.Id = _Header.Id
{
    key id as Id,
    name as Name,
    description as Description,
    releasedate as Releasedate,
    discontinueddate as Discontinueddate,
    @Semantics.amount.currencyCode: 'Waers'
    price as Price,
    waers as Waers,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    height as Height,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    width as Width,
    @Semantics.quantity.unitOfMeasure: 'DimensionsUom'
    depth as Depth,
    dimensions_uom as DimensionsUom,
    quantity as Quantity,
    unitofmeasure as Unitofmeasure,
    _Header
}
