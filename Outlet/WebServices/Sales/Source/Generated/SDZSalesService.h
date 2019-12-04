/*
	SDZSalesService.h
	The interface definition of classes and methods for the SalesService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZSalesService : SoapService
		
	/* Returns NSString*.  */
	- (SoapRequest*) createBilling: (id <SoapDelegate>) handler dateAndTimeOfOrder: (NSString*) dateAndTimeOfOrder cashierID: (NSString*) cashierID modeOfPayment: (NSString*) modeOfPayment totalPrice: (NSString*) totalPrice billDueAmount: (NSString*) billDueAmount transactionID: (NSString*) transactionID saleItems: (NSString*) saleItems dealnoffer: (NSString*) dealnoffer type: (NSString*) type cardnumber: (NSString*) cardnumber cash: (NSString*) cash tax: (NSString*) tax;
	- (SoapRequest*) createBilling: (id) target action: (SEL) action dateAndTimeOfOrder: (NSString*) dateAndTimeOfOrder cashierID: (NSString*) cashierID modeOfPayment: (NSString*) modeOfPayment totalPrice: (NSString*) totalPrice billDueAmount: (NSString*) billDueAmount transactionID: (NSString*) transactionID saleItems: (NSString*) saleItems dealnoffer: (NSString*) dealnoffer type: (NSString*) type cardnumber: (NSString*) cardnumber cash: (NSString*) cash tax: (NSString*) tax;

	/* Returns NSString*.  */
	- (SoapRequest*) getBillingDetails: (id <SoapDelegate>) handler saleID: (NSString*) saleID;
	- (SoapRequest*) getBillingDetails: (id) target action: (SEL) action saleID: (NSString*) saleID;

	/* Returns NSString*.  */
	- (SoapRequest*) getAvailableStock: (id <SoapDelegate>) handler;
	- (SoapRequest*) getAvailableStock: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) getStockDetailsByStockType: (id <SoapDelegate>) handler stockType: (NSString*) stockType pageNumber: (NSString*) pageNumber;
	- (SoapRequest*) getStockDetailsByStockType: (id) target action: (SEL) action stockType: (NSString*) stockType pageNumber: (NSString*) pageNumber;

	/* Returns NSString*.  */
	- (SoapRequest*) getSalesReport: (id <SoapDelegate>) handler reportByDate: (NSString*) reportByDate;
	- (SoapRequest*) getSalesReport: (id) target action: (SEL) action reportByDate: (NSString*) reportByDate;

	/* Returns NSString*.  */
	- (SoapRequest*) getExistedSaleID: (id <SoapDelegate>) handler saleID: (NSString*) saleID;
	- (SoapRequest*) getExistedSaleID: (id) target action: (SEL) action saleID: (NSString*) saleID;

	/* Returns NSString*.  */
	- (SoapRequest*) searchSalesReportWithPagination: (id <SoapDelegate>) handler searchCriteria: (NSString*) searchCriteria pageNumber: (NSString*) pageNumber;
	- (SoapRequest*) searchSalesReportWithPagination: (id) target action: (SEL) action searchCriteria: (NSString*) searchCriteria pageNumber: (NSString*) pageNumber;

		
	+ (SDZSalesService*) service;
	+ (SDZSalesService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	