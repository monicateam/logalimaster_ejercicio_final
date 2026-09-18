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
    Orderstatus,
    Imageurl,
    /* Associations */
    _Items: redirected to composition child zc_items_0414
}
