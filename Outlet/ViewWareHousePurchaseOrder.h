//
//  ViewWareHousePurchaseOrder.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>

@interface ViewWareHousePurchaseOrder : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate>{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITableView* orderstockTable;
    UISearchBar *searchBar;
    NSMutableArray *Items;
    NSMutableArray *copyListOfItems;
    NSString *searchString;
    
    BOOL searching;
    BOOL letUserSelectRow;
    
    NSMutableArray *itemIdArray;
    NSMutableArray *orderStatusArray;
    NSMutableArray *orderAmountArray;
    NSMutableArray *OrderedOnArray;
    
    MBProgressHUD *HUD;
    
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *firstButton;
    UIButton *lastButton;
    
    UILabel *receiptRefNoValue;
    UILabel *supplierIDValue;
    UILabel *supplierNameValue;
    UILabel *locationValue;
    UILabel *deliveredBYValue;
    UILabel *inspectedBYValue;
    UILabel *dateValue;
    UILabel *poRefValue;
    UILabel *shipmentValue;
    UILabel *statusValue;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UIScrollView *createReceiptView;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UILabel *status;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UILabel *orderSubmittedByValue;
    UILabel *shippingTermsValue;
    UILabel *orderAppBy;
    UILabel *creditTermsValue;
    UILabel *payTermsValue;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
- (void) searchTableView;
-(id) initWithorderID:(NSString *)orderID;

@end
