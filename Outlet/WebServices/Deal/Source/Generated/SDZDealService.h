/*
	SDZDealService.h
	The interface definition of classes and methods for the DealService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZDealService : SoapService
		
	/* Returns NSString*.  */
	- (SoapRequest*) getCurrentDealDetails: (id <SoapDelegate>) handler;
	- (SoapRequest*) getCurrentDealDetails: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) getDealDetails: (id <SoapDelegate>) handler dealType: (NSString*) dealType pageNumber: (NSString*) pageNumber;
	- (SoapRequest*) getDealDetails: (id) target action: (SEL) action dealType: (NSString*) dealType pageNumber: (NSString*) pageNumber;

	/* Returns NSString*.  */
	- (SoapRequest*) getDealDetailsBySKU: (id <SoapDelegate>) handler skuID: (NSString*) skuID dealType: (NSString*) dealType;
	- (SoapRequest*) getDealDetailsBySKU: (id) target action: (SEL) action skuID: (NSString*) skuID dealType: (NSString*) dealType;

		
	+ (SDZDealService*) service;
	+ (SDZDealService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	