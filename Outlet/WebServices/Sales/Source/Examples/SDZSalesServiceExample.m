/*
	SDZSalesServiceExample.m
	Provides example and test runs the service's proxy methods.
	Generated by SudzC.com
*/
#import "SDZSalesServiceExample.h"
#import "SDZSalesService.h"

@implementation SDZSalesServiceExample

- (void)run {
	// Create the service
	SDZSalesService* service = [SDZSalesService service];
	service.logging = YES;
	// service.username = @"username";
	// service.password = @"password";
	

	// Returns NSString*. 
	[service createBilling:self action:@selector(createBillingHandler:) dateAndTimeOfOrder: @"" cashierID: @"" modeOfPayment: @"" totalPrice: @"" billDueAmount: @"" transactionID: @"" saleItems: @"" dealnoffer: @"" type: @"" cardnumber: @"" cash: @"" tax: @""];

	// Returns NSString*. 
	[service getAvailableStock:self action:@selector(getAvailableStockHandler:)];

	// Returns NSString*. 
	[service getBillingDetails:self action:@selector(getBillingDetailsHandler:) saleID: @""];

	// Returns NSString*. 
	[service getExistedSaleID:self action:@selector(getExistedSaleIDHandler:) saleID: @""];

	// Returns NSString*. 
	[service getSalesReport:self action:@selector(getSalesReportHandler:) reportByDate: @""];

	// Returns NSString*. 
	[service getStockDetailsByStockType:self action:@selector(getStockDetailsByStockTypeHandler:) stockType: @"" pageNumber: @""];

	// Returns NSString*. 
	[service searchSalesReportWithPagination:self action:@selector(searchSalesReportWithPaginationHandler:) searchCriteria: @"" pageNumber: @""];
}

	

// Handle the response from createBilling.
		
- (void) createBillingHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"createBilling returned the value: %@", result);
			
}
	

// Handle the response from getAvailableStock.
		
- (void) getAvailableStockHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getAvailableStock returned the value: %@", result);
			
}
	

// Handle the response from getBillingDetails.
		
- (void) getBillingDetailsHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getBillingDetails returned the value: %@", result);
			
}
	

// Handle the response from getExistedSaleID.
		
- (void) getExistedSaleIDHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getExistedSaleID returned the value: %@", result);
			
}
	

// Handle the response from getSalesReport.
		
- (void) getSalesReportHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getSalesReport returned the value: %@", result);
			
}
	

// Handle the response from getStockDetailsByStockType.
		
- (void) getStockDetailsByStockTypeHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getStockDetailsByStockType returned the value: %@", result);
			
}
	

// Handle the response from searchSalesReportWithPagination.
		
- (void) searchSalesReportWithPaginationHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"searchSalesReportWithPagination returned the value: %@", result);
			
}
	

@end
		