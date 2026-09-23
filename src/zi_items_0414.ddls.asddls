@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items view entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ITEMS_0414 as select from zitems_0414
    association to parent ZI_HEADER_0414 as _Header on $projection.Id = _Header.Id
    association [0..1] to I_Currency as _Currency on $projection.Waers = _Currency.Currency
{
    key id as Id,
    key item_uuid as UUID,
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
    last_change_at as LastChangedAt,
    local_last_changed_at as LocalLastChangeAt,
    _Header,
    _Currency
}
