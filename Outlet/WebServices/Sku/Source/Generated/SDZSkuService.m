/*
	SDZSkuService.m
	The implementation classes and methods for the SkuService web service.
	Generated by SudzC.com
*/

#import "SDZSkuService.h"
				
#import "Soap.h"
#import "Global.h"
	

/* Implementation of the service */
				
@implementation SDZSkuService

	- (id) init
	{
		if(self = [super init])
		{
			//self.serviceUrl = @"http://10.10.0.17:8080/OmniRetailerServices/services/Sku";
            
           //self.serviceUrl = @"http://technolabssoftware.com:9080/OmniRetailerServices/services/Sku";
            
           // self.serviceUrl = [NSString stringWithFormat:@"%@%@%@", @"http://",host_name,@"/OmniRetailerServices/services/Sku"];
            self.serviceUrl = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://",host_name,@":",port_no,@"/OmniRetailerServices/services/Sku"];
			self.namespace1 = @"http://impl.sku.mobileservices.tlabs.com";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZSkuService*) service {
		return [SDZSkuService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZSkuService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[SDZSkuService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) getSkuDetails: (id <SoapDelegate>) handler skuID: (NSString*) skuID
	{
		return [self getSkuDetails: handler action: nil skuID: skuID];
	}

	- (SoapRequest*) getSkuDetails: (id) _target action: (SEL) _action skuID: (NSString*) skuID
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: skuID forName: @"skuID"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getSkuDetails" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getSkuID: (id <SoapDelegate>) handler
	{
		return [self getSkuID: handler action: nil];
	}

	- (SoapRequest*) getSkuID: (id) _target action: (SEL) _action
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		NSString* _envelope = [Soap createEnvelope: @"getSkuID" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getSkuIDForGivenProductName: (id <SoapDelegate>) handler productName: (NSString*) productName
	{
		return [self getSkuIDForGivenProductName: handler action: nil productName: productName];
	}

	- (SoapRequest*) getSkuIDForGivenProductName: (id) _target action: (SEL) _action productName: (NSString*) productName
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: productName forName: @"productName"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getSkuIDForGivenProductName" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) searchProduct: (id <SoapDelegate>) handler searchCriteria: (NSString*) searchCriteria
	{
		return [self searchProduct: handler action: nil searchCriteria: searchCriteria];
	}

	- (SoapRequest*) searchProduct: (id) _target action: (SEL) _action searchCriteria: (NSString*) searchCriteria
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: searchCriteria forName: @"searchCriteria"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"searchProduct" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	