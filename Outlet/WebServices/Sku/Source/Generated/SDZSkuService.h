/*
	SDZSkuService.h
	The interface definition of classes and methods for the SkuService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZSkuService : SoapService
		
	/* Returns NSString*.  */
	- (SoapRequest*) getSkuDetails: (id <SoapDelegate>) handler skuID: (NSString*) skuID;
	- (SoapRequest*) getSkuDetails: (id) target action: (SEL) action skuID: (NSString*) skuID;

	/* Returns NSString*.  */
	- (SoapRequest*) getSkuID: (id <SoapDelegate>) handler;
	- (SoapRequest*) getSkuID: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) getSkuIDForGivenProductName: (id <SoapDelegate>) handler productName: (NSString*) productName;
	- (SoapRequest*) getSkuIDForGivenProductName: (id) target action: (SEL) action productName: (NSString*) productName;

	/* Returns NSString*.  */
	- (SoapRequest*) searchProduct: (id <SoapDelegate>) handler searchCriteria: (NSString*) searchCriteria;
	- (SoapRequest*) searchProduct: (id) target action: (SEL) action searchCriteria: (NSString*) searchCriteria;

		
	+ (SDZSkuService*) service;
	+ (SDZSkuService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	