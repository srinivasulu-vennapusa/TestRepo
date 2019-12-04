//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "WebServiceController.h"

@interface ViewReceiptGoodsProcurement : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate, StockReceiptServiceDelegate>
{
    MBProgressHUD *HUD;
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
    
    NSMutableArray *itemDetails;
    
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UILabel *status;
    UIActionSheet *action;
}

-(id) initWithReceiptID:(NSString *)receiptID;
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@end
