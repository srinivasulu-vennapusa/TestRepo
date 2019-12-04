/*
	SDZOrderServiceExample.m
	Provides example and test runs the service's proxy methods.
	Generated by SudzC.com
*/
#import "SDZOrderServiceExample.h"
#import "SDZOrderService.h"

@implementation SDZOrderServiceExample

- (void)run {
	// Create the service
	SDZOrderService* service = [SDZOrderService service];
	service.logging = YES;
	// service.username = @"username";
	// service.password = @"password";
	

	// Returns BOOL. 
	[service createOrder:self action:@selector(createOrderHandler:) userID: @"" orderDateTime: @"" deliveryDate: @"" deliveryTime: @"" ordererEmail: @"" ordererMobile: @"" ordererAddress: @"" orderTotalPrice: @"" shipmentCharge: @"" shipmentMode: @"" paymentMode: @"" orderItems: @""];

	// Returns NSString*. 
	[service getOrderDetailsByOrderID:self action:@selector(getOrderDetailsByOrderIDHandler:) orderID: @""];

	// Returns NSString*. 
	[service getOrdersReport:self action:@selector(getOrdersReportHandler:) reportByDate: @""];

	// Returns NSString*. 
	[service getPreviousOrders:self action:@selector(getPreviousOrdersHandler:) userID: @"" pageNumber: @""];

	// Returns NSString*. 
	[service searchOrdersReportWithPagination:self action:@selector(searchOrdersReportWithPaginationHandler:) searchCriteria: @"" pageNumber: @""];
}

	

// Handle the response from createOrder.
		
- (void) createOrderHandler: (BOOL) value {
			

	// Do something with the BOOL result
		
	//NSLog(@"createOrder returned the value: %@", [NSNumber numberWithBool:value]);
			
}
	

// Handle the response from getOrderDetailsByOrderID.
		
- (void) getOrderDetailsByOrderIDHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getOrderDetailsByOrderID returned the value: %@", result);
			
}
	

// Handle the response from getOrdersReport.
		
- (void) getOrdersReportHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getOrdersReport returned the value: %@", result);
			
}
	

// Handle the response from getPreviousOrders.
		
- (void) getPreviousOrdersHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"getPreviousOrders returned the value: %@", result);
			
}
	

// Handle the response from searchOrdersReportWithPagination.
		
- (void) searchOrdersReportWithPaginationHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		//NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		//NSString* result = (NSString*)value;
	//NSLog(@"searchOrdersReportWithPagination returned the value: %@", result);
			
}
	

@end
		