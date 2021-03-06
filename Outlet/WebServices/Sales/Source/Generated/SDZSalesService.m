/*
	SDZSalesService.m
	The implementation classes and methods for the SalesService web service.
	Generated by SudzC.com
*/

#import "SDZSalesService.h"
#import "Global.h"				
#import "Soap.h"
	

/* Implementation of the service */
				
@implementation SDZSalesService

	- (id) init
	{
		if(self = [super init])
		{
            NSLog(@" %@",host_name);
            NSLog(@" %@",port_no);   
            
			//self.serviceUrl = @"http://localhost:8080/OmniRetailerServices/services/Sales";
            
            //self.serviceUrl = [NSString stringWithFormat:@"%@%@%@", @"http://",host_name,@"/OmniRetailerServices/services/Sales"];
            self.serviceUrl = [NSString stringWithFormat:@"%@%@%@%@%@", @"http://",host_name,@":",port_no,@"/OmniRetailerServices/services/Sales"];
			self.namespace1 = @"http://impl.sales.mobileservices.tlabs.com";
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
	
	+ (SDZSalesService*) service {
		return [SDZSalesService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZSalesService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[SDZSalesService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) createBilling: (id <SoapDelegate>) handler dateAndTimeOfOrder: (NSString*) dateAndTimeOfOrder cashierID: (NSString*) cashierID modeOfPayment: (NSString*) modeOfPayment totalPrice: (NSString*) totalPrice billDueAmount: (NSString*) billDueAmount transactionID: (NSString*) transactionID saleItems: (NSString*) saleItems dealnoffer: (NSString*) dealnoffer type: (NSString*) type cardnumber: (NSString*) cardnumber cash: (NSString*) cash tax: (NSString*) tax
	{
		return [self createBilling: handler action: nil dateAndTimeOfOrder: dateAndTimeOfOrder cashierID: cashierID modeOfPayment: modeOfPayment totalPrice: totalPrice billDueAmount: billDueAmount transactionID: transactionID saleItems: saleItems dealnoffer: dealnoffer type: type cardnumber: cardnumber cash: cash tax: tax];
	}

	- (SoapRequest*) createBilling: (id) _target action: (SEL) _action dateAndTimeOfOrder: (NSString*) dateAndTimeOfOrder cashierID: (NSString*) cashierID modeOfPayment: (NSString*) modeOfPayment totalPrice: (NSString*) totalPrice billDueAmount: (NSString*) billDueAmount transactionID: (NSString*) transactionID saleItems: (NSString*) saleItems dealnoffer: (NSString*) dealnoffer type: (NSString*) type cardnumber: (NSString*) cardnumber cash: (NSString*) cash tax: (NSString*) tax
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: dateAndTimeOfOrder forName: @"dateAndTimeOfOrder"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: cashierID forName: @"cashierID"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: modeOfPayment forName: @"modeOfPayment"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: totalPrice forName: @"totalPrice"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: billDueAmount forName: @"billDueAmount"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: transactionID forName: @"transactionID"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: saleItems forName: @"saleItems"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: dealnoffer forName: @"dealnoffer"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: type forName: @"type"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: cardnumber forName: @"cardnumber"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: cash forName: @"cash"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: tax forName: @"tax"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"createBilling" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getBillingDetails: (id <SoapDelegate>) handler saleID: (NSString*) saleID
	{
		return [self getBillingDetails: handler action: nil saleID: saleID];
	}

	- (SoapRequest*) getBillingDetails: (id) _target action: (SEL) _action saleID: (NSString*) saleID
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: saleID forName: @"saleID"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getBillingDetails" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getAvailableStock: (id <SoapDelegate>) handler
	{
		return [self getAvailableStock: handler action: nil];
	}

	- (SoapRequest*) getAvailableStock: (id) _target action: (SEL) _action
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		NSString* _envelope = [Soap createEnvelope: @"getAvailableStock" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getStockDetailsByStockType: (id <SoapDelegate>) handler stockType: (NSString*) stockType pageNumber: (NSString*) pageNumber
	{
		return [self getStockDetailsByStockType: handler action: nil stockType: stockType pageNumber: pageNumber];
	}

	- (SoapRequest*) getStockDetailsByStockType: (id) _target action: (SEL) _action stockType: (NSString*) stockType pageNumber: (NSString*) pageNumber
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: stockType forName: @"stockType"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: pageNumber forName: @"pageNumber"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getStockDetailsByStockType" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getSalesReport: (id <SoapDelegate>) handler reportByDate: (NSString*) reportByDate
	{
		return [self getSalesReport: handler action: nil reportByDate: reportByDate];
	}

	- (SoapRequest*) getSalesReport: (id) _target action: (SEL) _action reportByDate: (NSString*) reportByDate
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: reportByDate forName: @"reportByDate"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getSalesReport" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) getExistedSaleID: (id <SoapDelegate>) handler saleID: (NSString*) saleID
	{
		return [self getExistedSaleID: handler action: nil saleID: saleID];
	}

	- (SoapRequest*) getExistedSaleID: (id) _target action: (SEL) _action saleID: (NSString*) saleID
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: saleID forName: @"saleID"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"getExistedSaleID" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) searchSalesReportWithPagination: (id <SoapDelegate>) handler searchCriteria: (NSString*) searchCriteria pageNumber: (NSString*) pageNumber
	{
		return [self searchSalesReportWithPagination: handler action: nil searchCriteria: searchCriteria pageNumber: pageNumber];
	}

	- (SoapRequest*) searchSalesReportWithPagination: (id) _target action: (SEL) _action searchCriteria: (NSString*) searchCriteria pageNumber: (NSString*) pageNumber
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: searchCriteria forName: @"searchCriteria"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: pageNumber forName: @"pageNumber"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"searchSalesReportWithPagination" forNamespace: self.namespace1 withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	