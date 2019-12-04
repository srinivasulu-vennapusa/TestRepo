//
//  CreateWareHousePurchaseOrder.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "CreateWareHousePurchaseOrder.h"
#import <QuartzCore/QuartzCore.h>
#import "BarcodeType.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "WHPurchaseOrders.h"
#import "ViewWareHousePurchaseOrder.h"
#import "SupplierServiceSvc.h"
#import "RequestHeader.h"

@interface CreateWareHousePurchaseOrder ()

@end

@implementation CreateWareHousePurchaseOrder
@synthesize customerCode,customerName;
@synthesize phNo;
@synthesize soundFileURLRef,soundFileObject;

UIButton  *dueDateButton;
UIButton *orderDateButton;
UIButton *orderChannnelButton;
UIButton *orderDeliveryTypeButton;
UIButton  *paymentModeButton;
UIButton *paymentTypeButton;
UIButton  *shipoModeButton;
UIDatePicker *myPicker;
BOOL wareNewItem__ = YES;
NSString *warePurchaseOrderID_ = @"";

int warePurchaseCount1_ = 0;
int warePurchaseCount2_ = 1;
int warePurchaseCount3_ = 0;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;

BOOL warePurchaseCountValue_ = YES;
int warePurchaseChangeNum_ = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 700.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0,400.0, 70.0)];
    titleLbl.text = @"Warehouse Purchase Order";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 250.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSArray *segmentLabels;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        segmentLabels = [NSArray arrayWithObjects:@"New Purchase Order",@"View Purchase Orders", nil];
    }
    else {
        
        segmentLabels = [NSArray arrayWithObjects:@"New Order",@"View Orders", nil];
        
    }
    
    mainSegmentedControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
    
    mainSegmentedControl.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    //segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    mainSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    mainSegmentedControl.backgroundColor = [UIColor lightGrayColor];
    
    //UIColor *tintcolor=[UIColor colorWithRed:63.0/255.0 green:127.0/255.0 blue:187.0/255.0 alpha:1.0];
    //[[segmentedControl.subviews objectAtIndex:0] setTintColor:tintcolor];
    mainSegmentedControl.selectedSegmentIndex = 0;
    [mainSegmentedControl addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    
    // assigning a value to check the bill finished ..
    mainSegmentedControl.tag = 0;
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    /** UIScrollView Design */
    orderTableScrollView = [[UIScrollView alloc] init];
    orderTableScrollView.backgroundColor = [UIColor clearColor];
    orderTableScrollView.bounces = FALSE;
    
    
    
    /** Custmor Fields Design*/
    
    customerCode = [[CustomTextField alloc] init];
    customerCode.borderStyle = UITextBorderStyleRoundedRect;
    customerCode.textColor = [UIColor blackColor];
    customerCode.placeholder = @"Supplier ID";
    customerCode.backgroundColor = [UIColor whiteColor];
    customerCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerCode.backgroundColor = [UIColor whiteColor];
    customerCode.autocorrectionType = UITextAutocorrectionTypeNo;
    customerCode.keyboardType = UIKeyboardTypeDefault;
    customerCode.returnKeyType = UIReturnKeyDone;
    customerCode.delegate = self;
    [customerCode awakeFromNib];
    
    
    customerName = [[CustomTextField alloc] init];
    customerName.borderStyle = UITextBorderStyleRoundedRect;
    customerName.textColor = [UIColor blackColor];
    customerName.placeholder = @"Supplier Name";
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.autocorrectionType = UITextAutocorrectionTypeNo;
    customerName.keyboardType = UIKeyboardTypeDefault;
    customerName.returnKeyType = UIReturnKeyDone;
    customerName.delegate = self;
    [customerName awakeFromNib];
    [customerName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    executiveName = [[CustomTextField alloc] init];
    executiveName.borderStyle = UITextBorderStyleRoundedRect;
    executiveName.textColor = [UIColor blackColor];
    executiveName.placeholder = @"Supplier Contact Name";
    executiveName.backgroundColor = [UIColor whiteColor];
    executiveName.clearButtonMode = UITextFieldViewModeWhileEditing;
    executiveName.backgroundColor = [UIColor whiteColor];
    executiveName.autocorrectionType = UITextAutocorrectionTypeNo;
    executiveName.keyboardType = UIKeyboardTypeDefault;
    executiveName.returnKeyType = UIReturnKeyDone;
    executiveName.delegate = self;
    [executiveName awakeFromNib];
    
    /** SearchBarItem*/
    searchItem = [[UITextField alloc] init];
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.placeholder = @"Enter Item";
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.keyboardType = UIKeyboardTypeDefault;
    searchItem.returnKeyType = UIReturnKeyDone;
    [scrollView addSubview:searchItem];
    searchItem.delegate = self;
    [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    supplierTable = [[UITableView alloc] init];
    supplierTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [supplierTable setDataSource:self];
    [supplierTable setDelegate:self];
    [supplierTable.layer setBorderWidth:1.0f];
    supplierTable.layer.cornerRadius = 3;
    supplierTable.layer.borderColor = [UIColor grayColor].CGColor;
    [supplierTable setHidden:YES];

    
    /** Search Button*/
    searchBtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchDown];
    [searchBtton setTitle:@"Search" forState:UIControlStateNormal];
    searchBtton.backgroundColor = [UIColor grayColor];
    
    
    /**table header labels */
    
    UILabel *label1 = [[[UILabel alloc] init] autorelease];
    label1.text = @"Item";
    label1.layer.cornerRadius = 12;
    [label1 setTextAlignment:NSTextAlignmentCenter];
    label1.layer.masksToBounds = YES;
    
    label1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Desc";
    label5.layer.cornerRadius = 12;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.layer.masksToBounds = YES;
    
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Price";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label3 = [[[UILabel alloc] init] autorelease];
    label3.text = @"Qty";
    label3.layer.cornerRadius = 12;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Total";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    
    
    dueDate = [[CustomTextField alloc] init];
    dueDate.borderStyle = UITextBorderStyleRoundedRect;
    dueDate.textColor = [UIColor blackColor];
    dueDate.placeholder = @"Delivery Date";
    dueDate.backgroundColor = [UIColor whiteColor];
    dueDate.keyboardType = UIKeyboardTypeDefault;
    dueDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    dueDate.autocorrectionType = UITextAutocorrectionTypeNo;
    dueDate.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    dueDate.userInteractionEnabled = NO;
    dueDate.delegate = self;
    [dueDate awakeFromNib];
    
    
    dueDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [dueDateButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [dueDateButton addTarget:self
                      action:@selector(dueDateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    dueDateButton.tag = 0;
    //[self.view addSubview:scrollView];
    
    shipment_location = [[CustomTextField alloc] init];
    //    shipment_location.borderStyle = UITextBorderStyleRoundedRect;
    //    shipment_location.textColor = [UIColor blackColor];
    shipment_location.placeholder = @"Shipment Location";
    //    shipment_location.backgroundColor = [UIColor whiteColor];
    //    shipment_location.keyboardType = UIKeyboardTypeDefault;
    //    shipment_location.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    shipment_location.autocorrectionType = UITextAutocorrectionTypeNo;
    //    shipment_location.returnKeyType = UIReturnKeyDone;
    //    //[self.view addSubview:scrollView];
    //    shipment_location.userInteractionEnabled = YES;
    //    shipment_location.delegate = self;
    [shipment_location awakeFromNib];
    
    
    shipment_city = [[CustomTextField alloc] init];
    shipment_city.borderStyle = UITextBorderStyleRoundedRect;
    shipment_city.textColor = [UIColor blackColor];
    shipment_city.placeholder = @"Shipment City";
    //    shipment_city.backgroundColor = [UIColor whiteColor];
    shipment_city.keyboardType = UIKeyboardTypeDefault;
    shipment_city.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipment_city.autocorrectionType = UITextAutocorrectionTypeNo;
    shipment_city.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipment_city.userInteractionEnabled = YES;
    shipment_city.delegate = self;
    [shipment_city awakeFromNib];
    
    
    shipment_street = [[CustomTextField alloc] init];
    shipment_street.borderStyle = UITextBorderStyleRoundedRect;
    shipment_street.textColor = [UIColor blackColor];
    shipment_street.placeholder = @"Shipment Street";
    //    shipment_street.backgroundColor = [UIColor whiteColor];
    shipment_street.keyboardType = UIKeyboardTypeDefault;
    shipment_street.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipment_street.autocorrectionType = UITextAutocorrectionTypeNo;
    shipment_street.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipment_street.userInteractionEnabled = YES;
    shipment_street.delegate = self;
    [shipment_street awakeFromNib];
    
    
    shipmentID = [[CustomTextField alloc] init];
    shipmentID.borderStyle = UITextBorderStyleRoundedRect;
    shipmentID.textColor = [UIColor blackColor];
    shipmentID.placeholder = @"Order Submitted By";
    //    shipmentID.backgroundColor = [UIColor whiteColor];
    shipmentID.keyboardType = UIKeyboardTypeDefault;
    shipmentID.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentID.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentID.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipmentID.userInteractionEnabled = YES;
    shipmentID.delegate = self;
    [shipmentID awakeFromNib];
    
    saleLocation = [[CustomTextField alloc] init];
    saleLocation.borderStyle = UITextBorderStyleRoundedRect;
    saleLocation.textColor = [UIColor blackColor];
    saleLocation.placeholder = @"Order Approved By";
    //    saleLocation.backgroundColor = [UIColor whiteColor];
    saleLocation.keyboardType = UIKeyboardTypeDefault;
    saleLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    saleLocation.autocorrectionType = UITextAutocorrectionTypeNo;
    saleLocation.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    saleLocation.userInteractionEnabled = YES;
    saleLocation.delegate = self;
    [saleLocation awakeFromNib];
    
    time = [[CustomTextField alloc] init];
    time.borderStyle = UITextBorderStyleRoundedRect;
    time.textColor = [UIColor blackColor];
    time.placeholder = @"Time";
    //    time.backgroundColor = [UIColor whiteColor];
    time.keyboardType = UIKeyboardTypeDefault;
    time.clearButtonMode = UITextFieldViewModeWhileEditing;
    time.autocorrectionType = UITextAutocorrectionTypeNo;
    time.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    time.userInteractionEnabled = NO;
    time.delegate = self;
    [time awakeFromNib];
    
    
    
    //    timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *buttonImageT = [UIImage imageNamed:@"combo.png"];
    //    [timeButton setBackgroundImage:buttonImageT forState:UIControlStateNormal];
    //    [timeButton addTarget:self action:@selector(timeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    //[self.view addSubview:scrollView];
    
    
    shipCharges = [[CustomTextField alloc] init];
    shipCharges.borderStyle = UITextBorderStyleRoundedRect;
    shipCharges.textColor = [UIColor blackColor];
    shipCharges.placeholder = @"Shipping Terms";
    shipCharges.keyboardType = UIKeyboardTypeAlphabet;
    shipCharges.backgroundColor = [UIColor whiteColor];
    //shipCharges.keyboardType = UIKeyboardTypeDefault;
    shipCharges.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipCharges.autocorrectionType = UITextAutocorrectionTypeNo;
    shipCharges.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipCharges.userInteractionEnabled = YES;
    shipCharges.delegate = self;
    [shipCharges awakeFromNib];
    
    
    
    paymentMode = [[CustomTextField alloc] init];
    paymentMode.borderStyle = UITextBorderStyleRoundedRect;
    paymentMode.textColor = [UIColor blackColor];
    paymentMode.placeholder = @"Credit Terms";
    paymentMode.backgroundColor = [UIColor whiteColor];
    paymentMode.keyboardType = UIKeyboardTypeDefault;
    paymentMode.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentMode.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentMode.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    paymentMode.delegate = self;
    [paymentMode awakeFromNib];
    
    
    //[self.view addSubview:scrollView];
    
    paymentType = [[CustomTextField alloc] init];
    paymentType.borderStyle = UITextBorderStyleRoundedRect;
    paymentType.textColor = [UIColor blackColor];
    paymentType.placeholder = @"Payment Terms";
    paymentType.backgroundColor = [UIColor whiteColor];
    paymentType.keyboardType = UIKeyboardTypeDefault;
    paymentType.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentType.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentType.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    paymentType.delegate = self;
    [paymentType awakeFromNib];
    
    
    
    shipoMode = [[CustomTextField alloc] init];
    shipoMode.borderStyle = UITextBorderStyleRoundedRect;
    shipoMode.textColor = [UIColor blackColor];
    shipoMode.placeholder = @"SHIP Mode";
    shipoMode.backgroundColor = [UIColor whiteColor];
    shipoMode.keyboardType = UIKeyboardTypeDefault;
    shipoMode.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipoMode.autocorrectionType = UITextAutocorrectionTypeNo;
    shipoMode.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipoMode.userInteractionEnabled = NO;
    shipoMode.delegate = self;
    [shipoMode awakeFromNib];
    
    shipoModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [shipoModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipoModeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    shipoModeButton.tag = 0;
    // [self.view addSubview:scrollView];
    
    
    /** Order Button */
    orderButton = [[UIButton alloc] init];
    [orderButton addTarget:self
                    action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [orderButton setTitle:@"Order" forState:UIControlStateNormal];
    orderButton.layer.cornerRadius = 3.0f;
    orderButton.backgroundColor = [UIColor grayColor];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //[self.view addSubview:orderButton];
    
    
    /** Create CancelButton */
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    //serchOrderItemTable creation...
    serchOrderItemTable = [[UITableView alloc] init];
    serchOrderItemTable.layer.borderWidth = 1.0;
    serchOrderItemTable.layer.cornerRadius = 4.0;
    serchOrderItemTable.layer.borderColor = [UIColor blackColor].CGColor;
    serchOrderItemTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [serchOrderItemTable setDataSource:self];
    [serchOrderItemTable setDelegate:self];
    serchOrderItemTable.bounces = FALSE;
    
    
    
    
    //OrderItemTable creation...
    orderItemsTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 150)];
    ;
    orderItemsTable.backgroundColor  = [UIColor clearColor];
    //orderItemsTable.layer.borderColor = [UIColor grayColor].CGColor;
    //orderItemsTable.layer.borderWidth = 1.0;
    orderItemsTable.layer.cornerRadius = 4.0;
    orderItemsTable.bounces = FALSE;
    [orderItemsTable setDataSource:self];
    [orderItemsTable setDelegate:self];
    //[self.view addSubview:scrollView];
    
    
    
    // PaymentTableview cration....
    paymentTable = [[UITableView alloc]init];
    paymentTable.layer.borderWidth = 1.0;
    paymentTable.bounces = FALSE;
    paymentTable.layer.cornerRadius = 10.0;
    paymentTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    paymentTable.layer.borderColor = [UIColor blackColor].CGColor;
    [paymentTable setDataSource:self];
    [paymentTable setDelegate:self];
    
    
    
    
    // ShipModeTableview cration....
    shipModeTable = [[UITableView alloc]init];
    shipModeTable.layer.borderWidth = 1.0;
    shipModeTable.layer.cornerRadius = 10.0;
    shipModeTable.bounces = FALSE;
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipModeTable setDataSource:self];
    [shipModeTable setDelegate:self];
    
    orderChannelTable = [[UITableView alloc]init];
    orderChannelTable.layer.borderWidth = 1.0;
    orderChannelTable.layer.cornerRadius = 10.0;
    orderChannelTable.bounces = FALSE;
    orderChannelTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    orderChannelTable.layer.borderColor = [UIColor blackColor].CGColor;
    [orderChannelTable setDataSource:self];
    [orderChannelTable setDelegate:self];
    
    orderDeliveryTable = [[UITableView alloc]init];
    orderDeliveryTable.layer.borderWidth = 1.0;
    orderDeliveryTable.layer.cornerRadius = 10.0;
    orderDeliveryTable.bounces = FALSE;
    orderDeliveryTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    orderDeliveryTable.layer.borderColor = [UIColor blackColor].CGColor;
    [orderDeliveryTable setDataSource:self];
    [orderDeliveryTable setDelegate:self];
    
    paymentTypeTable = [[UITableView alloc]init];
    paymentTypeTable.layer.borderWidth = 1.0;
    paymentTypeTable.layer.cornerRadius = 10.0;
    paymentTypeTable.bounces = FALSE;
    paymentTypeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    paymentTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
    [paymentTypeTable setDataSource:self];
    [paymentTypeTable setDelegate:self];
    
    
    
    
    //Followings are SubTotal,Tax,TotalAmount labels creation...
    UILabel *subTotal = [[[UILabel alloc] init] autorelease];
    subTotal.text = @"Sub Total";
    subTotal.textColor = [UIColor whiteColor];
    subTotal.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    UILabel *tax = [[[UILabel alloc] init] autorelease];
    
    
    tax.text = @"Tax 8.25%";
    tax.textColor = [UIColor whiteColor];
    tax.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    UILabel *totAmount = [[[UILabel alloc] init] autorelease];
    totAmount.text = @"Total Bill";
    totAmount.textColor = [UIColor whiteColor];
    totAmount.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    // Disply ActualData of SubTotal,Tax,TotalAmount labels creation...
    subTotalData = [[[UILabel alloc] init] autorelease];
    subTotalData.text = @"0.00";
    subTotalData.textColor = [UIColor whiteColor];
    subTotalData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    taxData = [[[UILabel alloc] init] autorelease];
    taxData.text = @"0.00";
    taxData.textColor = [UIColor whiteColor];
    taxData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    totAmountData = [[[UILabel alloc] init] autorelease];
    totAmountData.text = @"0.00";
    totAmountData.textColor = [UIColor whiteColor];
    totAmountData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    
    // MutabileArray's initialization....
    skuIdArray = [[NSMutableArray alloc] init];
    ItemArray = [[NSMutableArray alloc] init];
    ItemDiscArray = [[NSMutableArray alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    QtyArray = [[NSMutableArray alloc] init];
    totalArray = [[NSMutableArray alloc] init];
    totalQtyArray = [[NSMutableArray alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        //        img.frame = CGRectMake(0, 0, 768, 50);
        //        [self.view addSubview:img];
        //
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        label.frame = CGRectMake(3, 10, 250, 30);
        //        label.font = [UIFont systemFontOfSize:25.0];
        //        [self.view addSubview:label];
        //
        //        backbutton.frame = CGRectMake(710.0, 6.0, 40.0, 40.0);
        //        [self.view addSubview:backbutton];
        
        mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                    nil];
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        [self.view addSubview:mainSegmentedControl];
        
        
        scrollView.frame = CGRectMake(0, 125, 768, 810);
        scrollView.contentSize = CGSizeMake(768, 1350);
        [self.view addSubview:scrollView];
        
        customerName.frame = CGRectMake(10,10, 350.0, 40);
        customerName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:customerCode];
        
        customerCode.frame = CGRectMake(380.0, 10, 350.0, 40);
        customerCode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:customerName];
        
          supplierTable.frame = CGRectMake(10, 60, 360, 200);
        [scrollView addSubview:supplierTable];
        
        executiveName.frame = CGRectMake(10, 70, 350.0, 40);
        executiveName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:executiveName];
        
        dueDate.frame = CGRectMake(380, 70, 350.0, 40);
        dueDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:dueDate];
        
        dueDateButton.frame = CGRectMake(695, 65, 50, 55);//set frame for button
        [scrollView addSubview:dueDateButton];
        
        shipment_location.frame = CGRectMake(10, 130, 350.0, 40);
        shipment_location.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_location];
        
        shipment_city.frame = CGRectMake(380, 130, 350, 40);
        shipment_city.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_city];
        
        shipment_street.frame = CGRectMake(10, 190, 350, 40);
        shipment_street.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_street];
        
        shipoMode.frame = CGRectMake(380, 190, 350.0, 40);
        shipoMode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipoMode];
        
        shipoModeButton.frame = CGRectMake(695, 185, 50, 55);//set frame for button
        [scrollView addSubview:shipoModeButton];
        
        shipmentID.frame = CGRectMake(10, 250, 350.0, 40);
        shipmentID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipmentID];
        
        shipCharges.frame = CGRectMake(10, 310, 500.0, 40);
        shipCharges.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipCharges];
        
        saleLocation.frame = CGRectMake(380, 250, 350.0, 40);
        saleLocation.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:saleLocation];
        
        paymentMode.frame = CGRectMake(10, 370, 500, 40);
        paymentMode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:paymentMode];
        
        paymentType.frame = CGRectMake(10, 430, 500, 40);
        paymentType.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:paymentType];
        
        customerCode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerCode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        customerName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        executiveName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:executiveName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        saleLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:saleLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        // phNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNo.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //  email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:email.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        dueDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dueDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        // orderDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        
        time.attributedPlaceholder = [[NSAttributedString alloc]initWithString:time.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipment_location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipment_street.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_street.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipment_city.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_city.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipCharges.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipCharges.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        paymentMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        paymentType.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentType.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipmentID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        
        
        
        shipoMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipoMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //  billing_city.attributedPlaceholder = [[NSAttributedString alloc]initWithString:billing_city.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //  billing_location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:billing_location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        address.attributedPlaceholder = [[NSAttributedString alloc]initWithString:address.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        phNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNo.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:email.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        dueDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dueDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        orderDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        
        
        searchItem.frame = CGRectMake(10, 490, 400, 40);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        [scrollView addSubview:searchItem];
        
        searchBtton.frame = CGRectMake(420, 490, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        //[scrollView addSubview:searchBtton];
        
        
        label1.frame = CGRectMake(10, 560, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label1];
        
        label5.frame = CGRectMake(161, 560, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        label5.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label5];
        
        label2.frame = CGRectMake(312, 560, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label2];
        
        label3.frame = CGRectMake(463, 560, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        label3.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label3];
        
        label4.frame = CGRectMake(614, 560, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        label4.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label4];
        
        serchOrderItemTable.frame = CGRectMake(10, 530, 400, 300);
        [scrollView addSubview:serchOrderItemTable];
        serchOrderItemTable.hidden = YES;
        
        
        // orderTableScrollView.frame = CGRectMake(0, 262, 770, 380);
        // orderTableScrollView.contentSize = CGSizeMake(320,150);
        // [scrollView addSubview:orderTableScrollView];
        
        
        orderItemsTable.frame = CGRectMake(10, 620, 750, 376);
        [scrollView addSubview:orderItemsTable];
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(10,950,300,50);
        subTotal.font = [UIFont boldSystemFontOfSize:25];
        subTotal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [scrollView addSubview:subTotal];
        
        tax.frame = CGRectMake(10,1010,300,50);
        tax.font = [UIFont boldSystemFontOfSize:25];
        tax.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [scrollView addSubview:tax];
        
        totAmount.frame = CGRectMake(10,1070,300,50);
        totAmount.font = [UIFont boldSystemFontOfSize:25];
        totAmount.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [scrollView addSubview:totAmount];
        
        
        
        subTotalData.frame = CGRectMake(500,950,200,50);
        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        [scrollView addSubview:subTotalData];
        
        taxData.frame = CGRectMake(500,1010,300,50);
        taxData.font = [UIFont boldSystemFontOfSize:25];
        [scrollView addSubview:taxData];
        
        totAmountData.frame = CGRectMake(500,1070,300,50);
        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        [scrollView addSubview:totAmountData];
        
        
        //        address.frame = CGRectMake(5, 750, 760, 50);
        //        address.font = [UIFont systemFontOfSize:25.0];
        //        [scrollView addSubview:address];
        //
        //
        //
        //
        //
        //        time.frame = CGRectMake(385, 870, 370, 50);
        //        time.font = [UIFont systemFontOfSize:25.0];
        //        [scrollView addSubview:time];
        //
        //        // timeButton.frame = CGRectMake(720, 916, 50, 65);//set frame for button
        //        // [scrollView addSubview:timeButton];
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //        //        orderButton.frame = CGRectMake(250, 940, 120, 50);
        //        //        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //        //        [self.view addSubview:orderButton];
        //        //
        //        //        cancelButton.frame = CGRectMake(400, 940, 120, 50);
        //        //        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //        //        [self.view addSubview:cancelButton];
        
        
        orderButton.frame = CGRectMake(30, 960, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [self.view addSubview:orderButton];
        
        cancelButton.frame = CGRectMake(390, 960, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [self.view addSubview:cancelButton];
        
        // label.font = [UIFont boldSystemFontOfSize:25];
        
        
        
        
        paymentTable.frame = CGRectMake(200, 260, 340, 300);
        [self.view addSubview:paymentTable];
        paymentTable.hidden = YES;
        
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:shipModeTable];
        shipModeTable.hidden = YES;
        
        orderChannelTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:orderChannelTable];
        orderChannelTable.hidden = YES;
        
        orderDeliveryTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:orderDeliveryTable];
        orderDeliveryTable.hidden = YES;
        
        paymentTypeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:paymentTypeTable];
        paymentTypeTable.hidden = YES;
        
        
        
        //        subTotal.frame = CGRectMake(10,580,300,50);
        //        subTotal.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:subTotal];
        //
        //        tax.frame = CGRectMake(10,630,300,50);
        //        tax.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:tax];
        //
        //        totAmount.frame = CGRectMake(10,680,300,50);
        //        totAmount.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:totAmount];
        //
        //
        //
        //        subTotalData.frame = CGRectMake(500,580,200,50);
        //        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:subTotalData];
        //
        //        taxData.frame = CGRectMake(500,630,300,50);
        //        taxData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:taxData];
        //
        //        totAmountData.frame = CGRectMake(500,680,300,50);
        //        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:totAmountData];
        
    }
    else{
        
        
        mainSegmentedControl.frame = CGRectMake(-2, 0.0, 324, 42);
        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                    nil];
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        [self.view addSubview:mainSegmentedControl];
        
        
        scrollView.frame = CGRectMake(0, 42, 768, 810);
        scrollView.contentSize = CGSizeMake(768, 1350);
        [self.view addSubview:scrollView];
        
        customerCode.frame = CGRectMake(5,0, 150.0, 30);
        customerCode.font = [UIFont systemFontOfSize:15.0];
        [scrollView addSubview:customerCode];
        
        customerName.frame = CGRectMake(165.0, 0, 150.0, 30);
        customerName.font = [UIFont systemFontOfSize:15.0];
        [scrollView addSubview:customerName];
        
        phNo.frame = CGRectMake(5, 35, 150.0, 30);
        phNo.font = [UIFont systemFontOfSize:15.0];
        [scrollView addSubview:phNo];
        
        email.frame = CGRectMake(165, 35, 150.0, 30);
        email.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:email];
        
        executiveName.frame = CGRectMake(5, 35, 150, 30);
        executiveName.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:executiveName];
        
        orderDate.frame = CGRectMake(165, 70, 150, 30);
        orderDate.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:orderDate];
        
        orderDateButton.frame = CGRectMake(295, 69, 30, 35);//set frame for button
        [scrollView addSubview:orderDateButton];
        
        dueDate.frame = CGRectMake(165, 35, 150, 30);
        dueDate.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:dueDate];
        
        dueDateButton.frame = CGRectMake(135, 33, 30, 35);//set frame for button
        [scrollView addSubview:dueDateButton];
        
        shipment_location.frame = CGRectMake(5, 70, 150, 30);
        shipment_location.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipment_location];
        
        shipment_city.frame = CGRectMake(165, 70, 150, 30);
        shipment_city.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipment_city];
        
        shipment_street.frame = CGRectMake(5, 105, 150, 30);
        shipment_street.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipment_street];
        
        billing_location.frame = CGRectMake(5, 175, 150, 30);
        billing_location.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:billing_location];
        
        billing_city.frame = CGRectMake(165, 175, 150, 30);
        billing_city.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:billing_city];
        
        billing_street.frame = CGRectMake(5, 210, 150, 30);
        billing_street.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:billing_street];
        
        customer_location.frame = CGRectMake(165, 210, 150, 30);
        customer_location.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:customer_location];
        
        customer_city.frame = CGRectMake(5, 245, 150, 30);
        customer_city.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:customer_city];
        
        customer_street.frame = CGRectMake(165, 245, 150, 30);
        customer_street.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:customer_street];
        
        orderChannel.frame = CGRectMake(5, 280, 150, 30);
        orderChannel.font = [UIFont systemFontOfSize:15.0];
        [scrollView addSubview:orderChannel];
        
        orderChannnelButton.frame = CGRectMake(135, 277, 30, 35);//set frame for button
        [scrollView addSubview:orderChannnelButton];
        
        orderDeliveryType.frame = CGRectMake(165, 280, 150, 30);
        orderDeliveryType.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:orderDeliveryType];
        
        orderDeliveryTypeButton.frame = CGRectMake(295, 277, 30, 35);//set frame for button
        [scrollView addSubview:orderDeliveryTypeButton];
        
        shipoMode.frame = CGRectMake(165, 105, 150, 30);
        shipoMode.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipoMode];
        
        shipoModeButton.frame = CGRectMake(295, 104, 30, 35);//set frame for button
        [scrollView addSubview:shipoModeButton];
        
        shipmentID.frame = CGRectMake(5, 140, 150, 30);
        shipmentID.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipmentID];
        
        shipCharges.frame = CGRectMake(165, 140, 150, 30);
        shipCharges.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:shipCharges];
        
        saleLocation.frame = CGRectMake(5, 175, 150, 30);
        saleLocation.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:saleLocation];
        
        paymentMode.frame = CGRectMake(5, 175, 150, 30);
        paymentMode.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:paymentMode];
        
        paymentModeButton.frame = CGRectMake(135, 210, 30, 35); //set frame for button
        [scrollView addSubview:paymentModeButton];
        
        paymentType.frame = CGRectMake(5, 210, 150, 30);
        paymentType.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:paymentType];
        
        paymentTypeButton.frame = CGRectMake(295, 382, 30, 35); //set frame for button
        [scrollView addSubview:paymentTypeButton];
        
        searchItem.frame = CGRectMake(5, 250, 220, 30);
        searchItem.font = [UIFont systemFontOfSize:15];
        [scrollView addSubview:searchItem];
        
        searchBtton.frame = CGRectMake(235, 250, 80, 35);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        searchBtton.layer.cornerRadius = 18.0f;
        [scrollView addSubview:searchBtton];
        
        
        label1.frame = CGRectMake(0, 290, 60, 25);
        label1.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:label1];
        
        label5.frame = CGRectMake(61, 290, 60, 25);
        label5.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:label5];
        
        label2.frame = CGRectMake(122, 290, 60, 25);
        label2.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:label2];
        
        label3.frame = CGRectMake(183, 290, 60, 25);
        label3.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:label3];
        
        label4.frame = CGRectMake(244, 290, 60, 25);
        label4.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:label4];
        
        serchOrderItemTable.frame = CGRectMake(10, 380, 220, 200);
        [scrollView addSubview:serchOrderItemTable];
        serchOrderItemTable.hidden = YES;
        
        
        orderItemsTable.frame = CGRectMake(10, 490, 550, 250);
        [scrollView addSubview:orderItemsTable];
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(5,670,150,30);
        subTotal.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:subTotal];
        
        tax.frame = CGRectMake(10,710,150,30);
        tax.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:tax];
        
        totAmount.frame = CGRectMake(10,750,180,30);
        totAmount.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:totAmount];
        
        
        
        subTotalData.frame = CGRectMake(250,670,150,30);
        subTotalData.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:subTotalData];
        
        taxData.frame = CGRectMake(250,710,150,30);
        taxData.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:taxData];
        
        totAmountData.frame = CGRectMake(250,750,180,30);
        totAmountData.font = [UIFont boldSystemFontOfSize:17];
        [scrollView addSubview:totAmountData];
        
        
        
        orderButton.frame = CGRectMake(15, 370, 130, 30);
        orderButton.layer.cornerRadius = 18.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:orderButton];
        
        cancelButton.frame = CGRectMake(165, 370, 130, 30);
        cancelButton.layer.cornerRadius = 18.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.view addSubview:cancelButton];
        
        // label.font = [UIFont boldSystemFontOfSize:25];
        
        
        
        
        paymentTable.frame = CGRectMake(130, 150, 120, 100);
        [self.view addSubview:paymentTable];
        paymentTable.hidden = YES;
        
        shipModeTable.frame = CGRectMake(130, 150, 120, 100);
        [self.view addSubview:shipModeTable];
        shipModeTable.hidden = YES;
        
        orderChannelTable.frame = CGRectMake(130, 150, 120, 100);
        [self.view addSubview:orderChannelTable];
        orderChannelTable.hidden = YES;
        
        orderDeliveryTable.frame = CGRectMake(130, 150, 120, 100);
        [self.view addSubview:orderDeliveryTable];
        orderDeliveryTable.hidden = YES;
        
        paymentTypeTable.frame = CGRectMake(130, 150, 120, 100);
        [self.view addSubview:paymentTypeTable];
        paymentTypeTable.hidden = YES;
        
    }
    
    //    customerCode.backgroundColor = [UIColor whiteColor];
    //    customerCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Code" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //    customerName.backgroundColor = [UIColor whiteColor];
    //    executiveName.backgroundColor = [UIColor whiteColor];
    //    searchItem.backgroundColor = [UIColor whiteColor];
    //    address.backgroundColor = [UIColor whiteColor];
    //    phNo.backgroundColor = [UIColor whiteColor];
    //    email.backgroundColor = [UIColor whiteColor];
    //    orderDate.backgroundColor = [UIColor whiteColor];
    //    dueDate.backgroundColor = [UIColor whiteColor];
    //    shipment_location.backgroundColor = [UIColor whiteColor];
    //    shipment_city.backgroundColor = [UIColor whiteColor];
    //    shipment_street.backgroundColor = [UIColor whiteColor];
    //    billing_location.backgroundColor = [UIColor whiteColor];
    //    billing_city.backgroundColor = [UIColor whiteColor];
    //    billing_street.backgroundColor = [UIColor whiteColor];
    //    customer_location.backgroundColor = [UIColor whiteColor];
    //    customer_city.backgroundColor = [UIColor whiteColor];
    //    customer_street.backgroundColor = [UIColor whiteColor];
    //    orderChannel.backgroundColor = [UIColor whiteColor];
    //    orderDeliveryType.backgroundColor = [UIColor whiteColor];
    //    shipmentID.backgroundColor = [UIColor whiteColor];
    //    saleLocation.backgroundColor = [UIColor whiteColor];
    //    time.backgroundColor = [UIColor whiteColor];
    //    shipCharges.backgroundColor = [UIColor whiteColor];
    //    paymentMode.backgroundColor = [UIColor whiteColor];
    //    paymentType.backgroundColor = [UIColor whiteColor];
    //    shipoMode.backgroundColor = [UIColor whiteColor];
    
    
    /** SearchBarItem*/
    const NSInteger searchBarHeight = 30;
    searchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        searchBar.frame = CGRectMake(0, 125, 768, 60);
    }
    else {
        searchBar.frame = CGRectMake(0, 35, 320, 30);
    }
    searchBar.delegate = self;
    searchBar.tintColor=[UIColor grayColor];
    orderstockTable.tableHeaderView = searchBar;
    [self.view addSubview:searchBar];
    [searchBar release];
    searchBar.hidden = YES;
    searchBar.delegate = self;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddContact:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    
    // Storing  for searchData
    copyListOfItems = [[NSMutableArray alloc] init];
    
    searching = NO;
    letUserSelectRow = YES;
    
    /** Table Creation*/
    orderstockTable = [[UITableView alloc] init];
    orderstockTable.bounces = TRUE;
    orderstockTable.backgroundColor = [UIColor clearColor];
    orderstockTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [orderstockTable setDataSource:self];
    [orderstockTable setDelegate:self];
    orderstockTable.hidden = YES;
    [self.view addSubview:orderstockTable];
    
    
    
    firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstButton addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [firstButton setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstButton.layer.cornerRadius = 3.0f;
    firstButton.hidden = YES;
    
    lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastButton addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [lastButton setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastButton.layer.cornerRadius = 3.0f;
    lastButton.hidden = YES;
    
    /** Create PreviousButton */
    previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousButton addTarget:self
                       action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [previousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //    [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    //    previousButton.backgroundColor = [UIColor lightGrayColor];
    previousButton.enabled =  NO;
    previousButton.hidden = YES;
    
    
    /** Create NextButton */
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton addTarget:self
                   action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [nextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    nextButton.hidden = YES;
    //    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //    nextButton.backgroundColor = [UIColor grayColor];
    
    //bottom label1...
    recStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recStart.text = @"";
    recStart.textAlignment = NSTextAlignmentLeft;
    recStart.backgroundColor = [UIColor clearColor];
    recStart.textColor = [UIColor whiteColor];
    recStart.hidden = YES;
    
    //bottom label_2...
    label1_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label1_.text = @"-";
    label1_.textAlignment = NSTextAlignmentLeft;
    label1_.backgroundColor = [UIColor clearColor];
    label1_.textColor = [UIColor whiteColor];
    label1_.hidden = YES;
    
    //bottom label2...
    recEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recEnd.text = @"";
    recEnd.textAlignment = NSTextAlignmentLeft;
    recEnd.backgroundColor = [UIColor clearColor];
    recEnd.textColor = [UIColor whiteColor];
    recEnd.hidden = YES;
    
    //bottom label_3...
    label2_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label2_.text = @"of";
    label2_.textAlignment = NSTextAlignmentLeft;
    label2_.backgroundColor = [UIColor clearColor];
    label2_.textColor = [UIColor whiteColor];
    label2_.hidden = YES;
    
    //bottom label3...
    totalRec = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalRec.textAlignment = NSTextAlignmentLeft;
    totalRec.backgroundColor = [UIColor clearColor];
    totalRec.textColor = [UIColor whiteColor];
    totalRec.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(10, 0, 200, 45);
        //        backbutton.frame = CGRectMake(710.0, 3.0, 45.0, 45.0);
        orderstockTable.frame = CGRectMake(0, 190, 778, 780);
        
        firstButton.frame = CGRectMake(80, 970.0, 50, 50);
        firstButton.layer.cornerRadius = 25.0f;
        firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        lastButton.frame = CGRectMake(615, 970.0, 50, 50);
        lastButton.layer.cornerRadius = 25.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        previousButton.frame = CGRectMake(240, 970.0, 50, 50);
        previousButton.layer.cornerRadius = 22.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        nextButton.frame = CGRectMake(470, 970.0, 50, 50);
        nextButton.layer.cornerRadius = 22.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        recStart.frame = CGRectMake(295, 970.0, 30, 50);
        label1_.frame = CGRectMake(338, 970.0, 30, 50);
        recEnd.frame = CGRectMake(365, 970.0, 30, 50);
        label2_.frame = CGRectMake(400, 970.0, 30, 50);
        totalRec.frame = CGRectMake(435, 970.0, 30, 50);
        
        recStart.font = [UIFont systemFontOfSize:25.0];
        label1_.font = [UIFont systemFontOfSize:25.0];
        recEnd.font = [UIFont systemFontOfSize:25.0];
        label2_.font = [UIFont systemFontOfSize:25.0];
        totalRec.font = [UIFont systemFontOfSize:25.0];
        
        
        //         label.font = [UIFont boldSystemFontOfSize:25];
    }
    else {
        //        img.frame = CGRectMake(0, 0, 320, 31);
        //        label.frame = CGRectMake(3, 1, 150, 30);
        //        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
        orderstockTable.frame = CGRectMake(0, 70, 320, 300);
        firstButton.frame = CGRectMake(10, 375, 40, 40);
        firstButton.layer.cornerRadius = 15.0f;
        firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        
        lastButton.frame = CGRectMake(273, 375, 40, 40);
        lastButton.layer.cornerRadius = 15.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        previousButton.frame = CGRectMake(80, 375, 40, 40);
        previousButton.layer.cornerRadius = 15.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        nextButton.frame = CGRectMake(210, 375, 40, 40);
        nextButton.layer.cornerRadius = 15.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        recStart.frame = CGRectMake(122, 375, 20, 30);
        label1_.frame = CGRectMake(140, 375, 20, 30);
        recEnd.frame = CGRectMake(148, 375, 20, 30);
        label2_.frame = CGRectMake(167, 375, 20, 30);
        totalRec.frame = CGRectMake(183, 375, 20, 30);
        
        recStart.font = [UIFont systemFontOfSize:14.0];
        label1_.font = [UIFont systemFontOfSize:14.0];
        recEnd.font = [UIFont systemFontOfSize:14.0];
        label2_.font = [UIFont systemFontOfSize:14.0];
        totalRec.font = [UIFont systemFontOfSize:14.0];
    }
    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    [self.view addSubview:orderstockTable];
    [self.view addSubview:previousButton];
    [self.view addSubview:nextButton];
    [self.view addSubview:firstButton];
    [self.view addSubview:lastButton];
    [self.view addSubview:recStart];
    [self.view addSubview:recEnd];
    [self.view addSubview:label1_];
    [self.view addSubview:label2_];
    [self.view addSubview:totalRec];
    
    
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:NO];
    [HUD setHidden:YES];
    
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
    serchOrderItemArray = [[NSMutableArray alloc] init];
    supplierList = [[NSMutableArray alloc] init];
    supplierCode = [[NSMutableArray alloc] init];
    
}

- (void) getPreviousOrdersHandler: (NSString *) value {
    
    //	// Handle errors
    //	if([value isKindOfClass:[NSError class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    //	// Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    
    [HUD setHidden:YES];
    
    // Do something with the NSString* result
    NSString* result = [value copy];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        // initialize the arrays ..
        itemIdArray = [[NSMutableArray alloc] init];
        orderStatusArray = [[NSMutableArray alloc] init];
        orderAmountArray = [[NSMutableArray alloc] init];
        OrderedOnArray = [[NSMutableArray alloc] init];
        NSArray *listDetails = [JSON1 objectForKey:@"ordersList"];
        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
        
        recStart.text = [NSString stringWithFormat:@"%d",(warePurchaseChangeNum_ * 10) + 1];
        recEnd.text = [NSString stringWithFormat:@"%d",[recStart.text intValue] + 9];
        totalRec.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"totalOrders"]];
        
        if ([[JSON1 objectForKey:@"totalOrders"] intValue] <= 10) {
            recEnd.text = [NSString stringWithFormat:@"%d",[totalRec.text intValue]];
            nextButton.enabled =  NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            lastButton.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
        else{
            
            if (warePurchaseChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([[JSON1 objectForKey:@"totalOrders"] intValue] - (10 * (warePurchaseChangeNum_+1))) <= 0) {
                
                nextButton.enabled = NO;
                lastButton.enabled = NO;
                recEnd.text = totalRec.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        for (int i = 0; i < [listDetails count]; i++) {
            
            NSDictionary *temp2 = [listDetails objectAtIndex:i];
            
            [itemIdArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"PO_Ref"]]];
            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"remarks"]]];
            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"total_po_value"]]];
            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"order_date"]]];
        }
        
        if ([itemIdArray count] < 5) {
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            nextButton.enabled =  NO;
        }
        
        warePurchaseCount3_ = [itemIdArray count];
        
        if ([listDetails count] == 0) {
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        warePurchaseCount2_ = NO;
        warePurchaseChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}


-(IBAction) dueDateButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    shipoModeButton.enabled = NO;
    //pickerview creation....
    
    if (dueDateButton.tag == 0) {
    
        dueDateButton.tag = 1;

    
    pickView = [[UIView alloc] init];
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(220, 200, 320, 400);
    }
    else{
        pickView.frame = CGRectMake(0, 0, 320, 460);
    }
    
    pickView.backgroundColor = [UIColor blackColor];
    pickView.layer.cornerRadius = 5.0f;
    
    //pickerframe creation...
    CGRect pickerFrame = CGRectMake(0,50,0,0);
    myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    myPicker.backgroundColor = [UIColor whiteColor];
    //Current Date...
    NSDate *now = [NSDate date];
    [myPicker setDate:now animated:YES];
    
    UIButton  *pickButton = [[UIButton alloc] init];
    [pickButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    pickButton.frame = CGRectMake(105, 327, 120, 35);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    //[pickButton setTitle:@"OK" forState:UIControlStateNormal];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [pickView addSubview:myPicker];
    [pickView addSubview:pickButton];
    [self.view addSubview:pickView];
    
    [pickView release];
    }
    else {
        
        [pickView removeFromSuperview];
        
        scrollView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        shipoModeButton.enabled = YES;
        
        dueDateButton.tag = 0;
    }
    
}

-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"yyyy/MM/dd hh:mmaa"];
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSComparisonResult result = [myPicker.date compare:[NSDate date]];
    
    if(result==NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid Date Selectione" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else {
        
        NSArray *temp =[dateString componentsSeparatedByString:@" "];
        NSLog(@" %@",temp);
        
        [dueDate setText:[temp objectAtIndex:0]];
        [time setText:[temp objectAtIndex:1]];
        [pickView removeFromSuperview];
        
        scrollView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        shipoModeButton.enabled = YES;
    }
}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (shipoModeButton.tag == 0) {
      
        shipoModeButton.tag = 1;
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    paymentModeButton.enabled = NO;
    dueDateButton.enabled = NO;
    
    shipmodeList = [[NSMutableArray alloc] init];
    [shipmodeList addObject:@"Rail"];
    [shipmodeList addObject:@"Flight"];
    [shipmodeList addObject:@"Express"];
    [shipmodeList addObject:@"Ordinary"];
    
    shipModeTable.hidden = NO;
    [self.view bringSubviewToFront:shipModeTable];
    [shipModeTable reloadData];
    }
    else {
        
        shipoModeButton.tag = 0;
        shipModeTable.hidden = YES;
        scrollView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        //timeButton.enabled = NO;
        paymentModeButton.enabled = YES;
        dueDateButton.enabled = YES;

        
    }
    
}

- (void) getSkuIDForGivenProductNameHandler: (id) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //    if([value isKindOfClass:[SoapFault class]]) {
    //        NSLog(@"%@", value);
    //        return;
    //    }
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@" %@",result);
    
    if([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *temp = [JSON1 objectForKey:@"skuIds"];
        if ([temp count] > 0) {
            NSDictionary *json =  [temp objectAtIndex:0];
            result = [NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]];
            
            if ([skuIdArray count] == 0) {
                [skuIdArray addObject:result];
            }
            else{
                
                for (int i=0; i<=[skuIdArray count]-1; i++) {
                    NSString *str1  = [skuIdArray objectAtIndex:i];
                    if ([str1 isEqualToString:result]) {
                        wareNewItem__ = NO;
                    }
                }
                if (wareNewItem__ == YES) {
                    
                    [skuIdArray addObject:result];
                }
                else{
                    
                    wareNewItem__ = YES;
                }
            }
            
            // Create the service
            //            SDZSkuService* service = [SDZSkuService service];
            //            service.logging = YES;
            //
            //            // Returns NSString*.
            //            [service getSkuDetails:self action:@selector(getSkuDetailsHandler:) skuID: result];
            
            SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
            SkuServiceSvc_getSkuDetails *aparams = [[SkuServiceSvc_getSkuDetails alloc] init];
            
            NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
            NSArray *objects = [NSArray arrayWithObjects:result,[RequestHeader getRequestHeader], nil];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            aparams.skuID = salesReportJsonString;
            
            SkuServiceSoapBindingResponse *response = [service getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)aparams];
            
            NSArray *responseBodyParts =  response.bodyParts;
            
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                    //printf("\nresponse=%s",body.return_);
                    [self getSkuDetailsHandler:body.return_];
                }
            }
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Product Not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
    }
}


// Handle the response from getSkuDetails.
- (void) getSkuDetailsHandler: (NSDictionary *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    NSError *e;
    
    
    //  NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
    //                                                          options: NSJSONReadingMutableContainers
    //                                                            error: &e];
    //  NSDictionary *JSON2 = [JSON1 objectForKey:@"responseHeader"];
    //
    //  if ([[JSON2 objectForKey:@"responseMessage"] isEqualToString:@"SUCCESS"] && [[JSON2 objectForKey:@"responseCode"] isEqualToString:@"0"]) {
    
    //       NSArray *temp = [NSArray arrayWithObjects:[JSON_1 objectForKey:@"productName"],[JSON_1 objectForKey:@"description"],[JSON_1 objectForKey:@"price"],@"1",[JSON_1 objectForKey:@"price"],@"N/A",@"1",@"1",@"0", nil];
    
    // NSString *itemStr = [value objectForKey:@"productName"];
    
    //        NSArray *tempItems = [result componentsSeparatedByString:@"#"];
    
    // if ([ItemArray count] == 0) {
    
    //            for (int i=0; i<[tempItems count]/4; i++) {
    
    [ItemArray addObject:[value objectForKey:@"productName"]];
    [ItemDiscArray addObject:[value objectForKey:@"description"]];
    [totalQtyArray addObject:[value objectForKey:@"quantity"]];
    [priceArray addObject:[value objectForKey:@"price"]];
    [QtyArray addObject:@"1"];
    [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[value objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
    //            }
    // }
    //  else
    //        {
    //            for (int i=0; i<=[ItemArray count]-1; i++) {
    //
    //                //NSString *str1  = [tempItems objectAtIndex:0];
    //                NSString *str2  = [ItemArray objectAtIndex:i];
    //
    //                if ([str2 isEqualToString:itemStr]) {
    //                    newItem__ = NO;
    //
    //                }
    //            }
    //
    //            if (newItem__ == YES) {
    //
    //                //                for (int i=0; i<[tempItems count]/4; i++) {
    //
    //                [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
    //                [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
    //                [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
    //                [priceArray addObject:[JSON1 objectForKey:@"price"]];
    //                [QtyArray addObject:@"1"];
    //                [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
    //                //                }
    //            }
    //            else{
    //
    //                for (int i=0; i<=[ItemArray count]-1; i++) {
    //
    //                    //                       NSString *str1  = [tempItems objectAtIndex:0];
    //                    NSString *str2  = [ItemArray objectAtIndex:i];
    //
    //                    if ([str2 isEqualToString:itemStr]) {
    //
    //                        NSLog(@"%@",[QtyArray objectAtIndex:i]);
    //
    //                        NSLog(@" %d",[[QtyArray objectAtIndex:i] intValue] + 1);
    //
    //                        if ([[QtyArray objectAtIndex:i] intValue] + 1 > [[totalQtyArray objectAtIndex:i] intValue]) {
    //
    //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                            [alert show];
    //                            [alert release];
    //
    //                            qtyFeild.text = nil;
    //                        }
    //                        else{
    //
    //                            [QtyArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[QtyArray objectAtIndex:i] intValue] + 1]];
    //
    //                            newItem__ = YES;
    //                            [self displayOrdersData];
    //                        }
    //                    }
    //                }
    //            }
    //        }
    
    
    
    totalAmount = 0.0;
    
    for (int i=0; i<[totalArray count]; i++) {
        totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
    taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
    totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
    
    orderItemsTable.hidden = NO;
    //[self.view bringSubviewToFront:orderItemsTable];
    [orderItemsTable reloadData];
    
    //    }
    //    else{
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    
}

//DisplayOrdersData handler
-(void)displayOrdersData{
    
    totalAmount = 0.0;
    
    for (int i=0; i<[ItemArray count]; i++) {
        
        [totalArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d", [[priceArray objectAtIndex:i] intValue]*[[QtyArray objectAtIndex:i] intValue]]];
        // qtyChangeDisplyView.hidden = YES;
        
        totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
        [orderItemsTable reloadData];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
    taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
    totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
}

// qtyChangeClick handler...
- (IBAction)qtyChangePressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    paymentModeButton.enabled= NO;
    customerCode.enabled = NO;
    customerName.enabled = NO;
    searchItem.enabled = NO;
//    searchBtton.enabled = NO;
    address.enabled =NO;
    phNo.enabled = NO;
    email.enabled = NO;
    dueDate.enabled = NO;
    dueDateButton.enabled = NO;
    time.enabled = NO;
    shipCharges.enabled = NO;
    //timeButton.enabled = NO;
    shipoMode.enabled = NO;
    shipoModeButton.enabled = NO;
    paymentMode.enabled = NO;
    paymentModeButton.enabled = NO;
    orderItemsTable.userInteractionEnabled = FALSE;
    
    qtyOrderPosition = [sender tag];
    
    qtyChangeDisplyView = [[[UIView alloc]init] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(200, 300, 375, 300);
    }
    else{
        qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplyView.layer.borderWidth = 2.0;
    qtyChangeDisplyView.layer.cornerRadius = 10.0;
    qtyChangeDisplyView.layer.masksToBounds = YES;
    qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index29" ofType:@"jpg"];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        img.frame = CGRectMake(0, 0, 375, 300);
    //    }
    //    else{
    //        img.frame = CGRectMake(0, 0, 175, 200);
    //    }
    //    [qtyChangeDisplyView addSubview:img];
    qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:qtyChangeDisplyView];
    
    
    // a label on top of the view ..
    UILabel *topbar = [[[UILabel alloc] init] autorelease];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor blackColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *availQty = [[[UILabel alloc] init] autorelease];
    availQty.text = @"Available Qty :";
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    
    
    UILabel *unitPrice = [[[UILabel alloc] init] autorelease];
    unitPrice.text = @"Unit Price       :";
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    
    UILabel *availQtyData = [[[UILabel alloc] init] autorelease];
    availQtyData.text = [totalQtyArray objectAtIndex:[sender tag]];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    
    
    UILabel *unitPriceData = [[[UILabel alloc] init] autorelease];
    unitPriceData.text = [priceArray objectAtIndex:[sender tag]];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    
    qtyFeild = [[UITextField alloc] init];
    qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
    qtyFeild.textColor = [UIColor blackColor];
    qtyFeild.placeholder = @"Enter Qty";
    qtyFeild.backgroundColor = [UIColor whiteColor];
    qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyFeild.returnKeyType = UIReturnKeyDone;
    qtyFeild.delegate = self;
    [qtyFeild becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.backgroundColor = [UIColor grayColor];
    
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        topbar.frame = CGRectMake(0, 0, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,50,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,100,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,50,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,100,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyFeild.frame = CGRectMake(110, 160, 150, 40);
        qtyFeild.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(20, 230, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 230, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
    }
    else{
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        availQty.frame = CGRectMake(10,40,100,30);
        availQty.font = [UIFont boldSystemFontOfSize:14];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        availQtyData.frame = CGRectMake(115,40,60,30);
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,70,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        qtyFeild.frame = CGRectMake(36, 107, 100, 30);
        qtyFeild.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:qtyFeild];
    [qtyChangeDisplyView addSubview:okButton];
    [qtyChangeDisplyView addSubview:qtyCancelButton];
}



// okButtonPressed handler for quantity changed..
- (IBAction)okButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *str = qtyFeild.text;
    //NSString *candidate = qtyFeild.text;
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //BOOL isNumber = [decimalTest evaluateWithObject:[qtyFeild text]];
    BOOL isNumber = [decimalTest evaluateWithObject:qtyFeild.text];
    
    int qty = [str intValue];
    
    if (qty >= [[totalQtyArray objectAtIndex:qtyOrderPosition] intValue]+1 ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = nil;
        qtyChangeDisplyView.hidden = NO;
        
    }
    else if([value isEqualToString:@"0"] || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = NO;
    }
    //    else if(!isNumber){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        [QtyArray replaceObjectAtIndex:qtyOrderPosition withObject:qtyFeild.text];
        //[qtyChangeDisplyView removeFromSuperview];
        qtyChangeDisplyView.hidden = YES;
        
        
        
        [self displayOrdersData];
    }
    
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    shipCharges.enabled = YES;
    //timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled = YES;
    paymentMode.enabled = YES;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}





// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    qtyChangeDisplyView.hidden = YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    // timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled =YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    shipCharges.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled =YES;
    paymentMode.enabled = YES;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}


- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    NSInteger index = mainSegmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            orderstockTable.hidden = YES;
            nextButton.hidden = YES;
            lastButton.hidden = YES;
            firstButton.hidden = YES;
            previousButton.hidden = YES;
            searchBar.hidden = YES;
            recStart.hidden = YES;
            recEnd.hidden = YES;
            totalRec.hidden = YES;
            label1_.hidden = YES;
            label2_.hidden = YES;
            scrollView.hidden = NO;
            orderButton.hidden = NO;
            cancelButton.hidden = NO;
            break;
        case 1:
            orderstockTable.hidden = NO;
            nextButton.hidden = NO;
            lastButton.hidden = NO;
            firstButton.hidden = NO;
            previousButton.hidden = NO;
            searchBar.hidden = NO;
            recStart.hidden = NO;
            recEnd.hidden = NO;
            totalRec.hidden = NO;
            label1_.hidden = NO;
            label2_.hidden = NO;
            scrollView.hidden = YES;
            orderButton.hidden = YES;
            cancelButton.hidden = YES;
            [orderstockTable reloadData];
            break;
        default:
            break;
    }
    
}

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // PhoNumber validation...
    //    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    //    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //    BOOL isNumber = [decimalTest evaluateWithObject:[phNo text]];
    //
    //
    //    // email validation...
    //    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //    BOOL isMail = [emailTest evaluateWithObject:[email text]];
    
    NSString *locationValue = [customerCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *customerNameValue = [customerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *executiveNameValue = [executiveName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dueDateValue = [dueDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_locationValue = [shipment_location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_cityValue = [shipment_city.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_streetValue = [shipment_street.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipoModeValue = [shipoMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentIDValue = [shipmentID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipChargesValue = [shipCharges.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *saleLocationValue = [saleLocation.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentModeValue = [paymentMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentTypeValue = [paymentType.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if([locationValue length] == 0 || [customerNameValue length] == 0 || [executiveNameValue length] == 0 || [dueDateValue length] == 0 ||     [shipment_locationValue length] == 0 || [shipment_cityValue length] == 0 || [shipment_streetValue length] == 0  || [shipoModeValue length] == 0 ||            [shipmentIDValue length] == 0 || [shipChargesValue length] == 0 || [saleLocationValue length] == 0 ||            [paymentModeValue length] == 0 || [paymentTypeValue length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //    else if (!isNumber){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    //    else if (!isMail){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter valid mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        HUD.labelText = @" Placing the order..";
        [HUD setHidden:NO];
        
        
        //        SDZOrderService* service = [SDZOrderService service];
        //        service.logging = YES;
        //
        //        // Returns BOOL.
        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"item_id", @"item_price",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemDiscArray objectAtIndex:i]],@"1000 ",@"1234", nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            [items addObject:itemsDic];
        }
        
        WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
        WHPurchaseOrders_createPurchaseOrder *aparams = [[WHPurchaseOrders_createPurchaseOrder alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        //        {"supplier_Id":"123456","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"Order_submitted_by",@"Order_approved_by",@"shipping_address",@"shipement_address_street",@"shipement_address_location",@"shipement_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_tax",@"total_po_value",@"remarks",@"whPurchaseItems",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:customerCode.text,customerName.text,executiveName.text,shipmentID.text,saleLocation.text,shipment_location.text,shipment_street.text,shipment_location.text,shipment_city.text,shipoMode.text,@"200.0",shipCharges.text,dueDate.text,paymentMode.text,paymentType.text,subTotalData.text,taxData.text,totAmountData.text,@"",items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        //        aparams.userID = user_name;
        //        aparams.orderDateTime = dateString;
        //        aparams.deliveryDate = dueDate.text;
        //        aparams.deliveryTime = time.text;
        //        aparams.ordererEmail = email.text;
        //        aparams.ordererMobile = phNo.text;
        //        aparams.ordererAddress = address.text;
        //        aparams.orderTotalPrice = totAmountData.text;
        //        aparams.shipmentCharge = shipCharges.text;
        //        aparams.shipmentMode = shipoMode.text;
        //        aparams.paymentMode = paymentMode.text;
        //        aparams.orderItems = str;
        aparams.orderDetails = normalStockString;
        WHPurchaseOrdersSoapBindingResponse *response = [service createPurchaseOrderUsingParameters:(WHPurchaseOrders_createPurchaseOrder *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHPurchaseOrders_createPurchaseOrderResponse class]]) {
                WHPurchaseOrders_createPurchaseOrderResponse *body = (WHPurchaseOrders_createPurchaseOrderResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self createOrderHandler:body.return_];
            }
        }
        
    }
    // Show the HUD
    
    //    }
}

// Handle the response from createOrder.
- (void) createOrderHandler: (NSString *) value {
    
    // Do something with the BOOL result
    NSString *result = [value copy];
    
    // hiding the HUD ..
    [HUD setHidden:YES];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Order Created Succesfully"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Placed Ordered",@"\n",@"Order ID :",[JSON1 objectForKey:@"orderId"]];
        warePurchaseOrderID_ = [[JSON1 objectForKey:@"orderId"] copy];
        SystemSoundID	soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //        receipt = [receiptID copy];
        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        [successAlertView setDelegate:self];
        [successAlertView setTitle:@"Success"];
        [successAlertView setMessage:status];
        [successAlertView addButtonWithTitle:@"OPEN ORDER"];
        [successAlertView addButtonWithTitle:@"NEW ORDER"];
        
        [successAlertView show];
        
        
        customerCode.text = nil;
        customerName.text = nil;
        address.text = nil;
        customerName.text = nil;
        address.text= nil;
        phNo.text = nil;
        email.text = nil;
        dueDate.text= nil;
        time.text = nil;
        shipCharges.text = nil;
        paymentMode.text = nil;
        shipoMode.text = nil;
        executiveName.text = nil;
        orderDate.text = nil;
        shipment_city.text = nil;
        shipment_location.text = nil;
        shipment_street.text = nil;
        billing_city.text = nil;
        billing_location.text = nil;
        billing_street.text = nil;
        customer_city.text = nil;
        customer_location.text = nil;
        customer_street.text = nil;
        orderChannel.text = nil;
        orderDeliveryType.text = nil;
        shipmentID.text = nil;
        shipCharges.text = nil;
        saleLocation.text = nil;
        paymentType.text  = nil;
        
        [skuIdArray removeAllObjects];
        [ItemDiscArray removeAllObjects];
        [totalArray removeAllObjects];
        [QtyArray removeAllObjects];
        [ItemArray removeAllObjects];
        [totalQtyArray removeAllObjects];
        
        subTotalData.text = @"0.00";
        taxData.text = @"0.00";
        totAmountData.text = @"0.00";
        
        [orderItemsTable reloadData];
        
    }
    else{
        SystemSoundID	soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Placing Order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Success"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHousePurchaseOrder *vpo = [[ViewWareHousePurchaseOrder alloc] initWithorderID:warePurchaseOrderID_];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if (alertView == warning) {
        
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
}

- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) firstButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    warePurchaseChangeNum_ = 0;
    //    cellcount = 10;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    //    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
    //    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
    //
    //    //    aParameters.userID = user_name;
    //    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
    //
    //    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    //    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    //    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    //    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    //
    //    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    //    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    //    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    //
    //    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",changeNum_],dictionary, nil];
    //    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    //
    //    NSError * err_;
    //    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    //    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //    aParameters.orderDetails = normalStockString;
    //
    //    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
    //    NSArray *responseBodyParts = response.bodyParts;
    //    for (id bodyPart in responseBodyParts) {
    //        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
    //            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
    //            //printf("\nresponse",body.getPreviousOrdersReturn);
    //            NSLog(@"%@",body.return_);
    //
    //            if (body.return_ == NULL) {
    //
    //                [HUD setHidden:YES];
    //                //nextButton.backgroundColor = [UIColor lightGrayColor];
    //                firstButton.enabled = NO;
    //                lastButton.enabled = NO;
    //                nextButton.enabled = NO;
    //                recStart.text  = @"0";
    //                recEnd.text  = @"0";
    //                totalRec.text  = @"0";
    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                [alert show];
    //            }
    //            else{
    //
    //                [self getPreviousOrdersHandler:body.return_];
    //            }
    //        }
    //    }
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrders *aparams = [[WHPurchaseOrders_getPurchaseOrders alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",warePurchaseChangeNum_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrdersResponse class]]) {
            WHPurchaseOrders_getPurchaseOrdersResponse *body = (WHPurchaseOrders_getPurchaseOrdersResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
    
}
// last button pressed....
-(void) lastButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //float a = [rec_total.text intValue]/5;
    //float t = ([rec_total.text floatValue]/5);
    
    if ([totalRec.text intValue]/10 == ([totalRec.text floatValue]/10)) {
        
        warePurchaseChangeNum_ = [totalRec.text intValue]/10 - 1;
    }
    else{
        warePurchaseChangeNum_ =[totalRec.text intValue]/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    warePurchaseCount1_ = (warePurchaseChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    previousButton.enabled = YES;
    
    
    //frstButton.backgroundColor = [UIColor grayColor];
    firstButton.enabled = YES;
    nextButton.enabled = NO;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    //    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
    //    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
    //
    //    //    aParameters.userID = user_name;
    //    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
    //
    //    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    //    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    //    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    //    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    //
    //    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    //    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    //    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    //
    //    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
    //    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    //
    //    NSError * err_;
    //    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    //    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //    aParameters.orderDetails = normalStockString;
    //
    //    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
    //    NSArray *responseBodyParts = response.bodyParts;
    //    for (id bodyPart in responseBodyParts) {
    //        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
    //            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
    //            //printf("\nresponse",body.getPreviousOrdersReturn);
    //            NSLog(@"%@",body.return_);
    //
    //            if (body.return_ == NULL) {
    //
    //                [HUD setHidden:YES];
    //                //nextButton.backgroundColor = [UIColor lightGrayColor];
    //                firstButton.enabled = NO;
    //                lastButton.enabled = NO;
    //                nextButton.enabled = NO;
    //                recStart.text  = @"0";
    //                recEnd.text  = @"0";
    //                totalRec.text  = @"0";
    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                [alert show];
    //            }
    //            else{
    //
    //                [self getPreviousOrdersHandler:body.return_];
    //            }
    //        }
    //    }
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrders *aparams = [[WHPurchaseOrders_getPurchaseOrders alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",warePurchaseCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrdersResponse class]]) {
            WHPurchaseOrders_getPurchaseOrdersResponse *body = (WHPurchaseOrders_getPurchaseOrdersResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
}


// previousButtonPressed handing...

- (void) previousButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (warePurchaseChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        warePurchaseChangeNum_--;
        warePurchaseCount1_ = (warePurchaseChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        warePurchaseCountValue_ = NO;
        
        [HUD setHidden:NO];
        
        //        OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
        //        OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
        //
        //        //    aParameters.userID = user_name;
        //        //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
        //
        //        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        //        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        //        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        //        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        //
        //        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        //        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
        //
        //        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
        //        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        //
        //        NSError * err_;
        //        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        //        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        //        aParameters.orderDetails = normalStockString;
        //
        //        OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
        //        NSArray *responseBodyParts = response.bodyParts;
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
        //                OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
        //                //printf("\nresponse",body.getPreviousOrdersReturn);
        //                NSLog(@"%@",body.return_);
        //
        //                if (body.return_ == NULL) {
        //
        //                    [HUD setHidden:YES];
        //                    //nextButton.backgroundColor = [UIColor lightGrayColor];
        //                    firstButton.enabled = NO;
        //                    lastButton.enabled = NO;
        //                    nextButton.enabled = NO;
        //                    recStart.text  = @"0";
        //                    recEnd.text  = @"0";
        //                    totalRec.text  = @"0";
        //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                    [alert show];
        //                }
        //                else{
        //
        //                    [self getPreviousOrdersHandler:body.return_];
        //                }
        //            }
        //        }
        WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
        WHPurchaseOrders_getPurchaseOrders *aparams = [[WHPurchaseOrders_getPurchaseOrders alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",warePurchaseCount1_],dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        //        aparams.userID = user_name;
        //        aparams.orderDateTime = dateString;
        //        aparams.deliveryDate = dueDate.text;
        //        aparams.deliveryTime = time.text;
        //        aparams.ordererEmail = email.text;
        //        aparams.ordererMobile = phNo.text;
        //        aparams.ordererAddress = address.text;
        //        aparams.orderTotalPrice = totAmountData.text;
        //        aparams.shipmentCharge = shipCharges.text;
        //        aparams.shipmentMode = shipoMode.text;
        //        aparams.paymentMode = paymentMode.text;
        //        aparams.orderItems = str;
        aparams.orderDetails = normalStockString;
        WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrdersResponse class]]) {
                WHPurchaseOrders_getPurchaseOrdersResponse *body = (WHPurchaseOrders_getPurchaseOrdersResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                if (body.return_ == NULL) {
                    
                    [HUD setHidden:YES];
                    //nextButton.backgroundColor = [UIColor lightGrayColor];
                    firstButton.enabled = NO;
                    lastButton.enabled = NO;
                    nextButton.enabled = NO;
                    recStart.text  = @"0";
                    recEnd.text  = @"0";
                    totalRec.text  = @"0";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    
                    [self getPreviousOrdersHandler:body.return_];
                }
                
            }
        }
        
        
        if ([recEnd.text isEqualToString:totalRec.text]) {
            
            lastButton.enabled = NO;
        }
        else {
            lastButton.enabled = YES;
        }
        
        // count1 = [itemIdArray count];
    }
    else{
        //previousButton.backgroundColor = [UIColor lightGrayColor];
        previousButton.enabled =  NO;
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
    }
    
}


// NextButtonPressed handing...

- (void) nextButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    warePurchaseChangeNum_++;
    
    warePurchaseCount1_ = (warePurchaseChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    warePurchaseCountValue_ = YES;
    
    [HUD setHidden:NO];
    
    //    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
    //    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
    //
    //    //    aParameters.userID = user_name;
    //    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
    //
    //    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    //    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    //    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    //    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    //
    //    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    //    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    //    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    //
    //    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
    //    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    //
    //    NSError * err_;
    //    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    //    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //    aParameters.orderDetails = normalStockString;
    //
    //    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
    //    NSArray *responseBodyParts = response.bodyParts;
    //    for (id bodyPart in responseBodyParts) {
    //        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
    //            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
    //            //printf("\nresponse",body.getPreviousOrdersReturn);
    //            NSLog(@"%@",body.return_);
    //
    //            if (body.return_ == NULL) {
    //
    //                [HUD setHidden:YES];
    //                //nextButton.backgroundColor = [UIColor lightGrayColor];
    //                firstButton.enabled = NO;
    //                lastButton.enabled = NO;
    //                nextButton.enabled = NO;
    //                recStart.text  = @"0";
    //                recEnd.text  = @"0";
    //                totalRec.text  = @"0";
    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                [alert show];
    //            }
    //            else{
    //
    //                [self getPreviousOrdersHandler:body.return_];
    //            }
    //        }
    //    }
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrders *aparams = [[WHPurchaseOrders_getPurchaseOrders alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",warePurchaseCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrdersResponse class]]) {
            WHPurchaseOrders_getPurchaseOrdersResponse *body = (WHPurchaseOrders_getPurchaseOrdersResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
}



/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    if (tableView == paymentTable) {
    //
    //        return [listOfItems count];
    //    }
    //    else if(tableView == serchOrderItemTable){
    //
    //        return [serchOrderItemArray count];
    //    }
    //    else if(tableView == orderItemsTable){
    //
    //        return [ItemArray count];
    //    }
    //    else if(tableView == orderChannelTable){
    //
    //        return [shipmodeList count];
    //    }
    //    else if(tableView == orderDeliveryTable){
    //
    //        return [shipmodeList count];
    //    }
    //    else if(tableView == paymentTypeTable){
    //
    //        return [listOfItems count];
    //    }
    //    else if (searching)
    //        return [copyListOfItems count];                           //copyItems
    //    else if(tableView == orderstockTable){
    //        return [itemIdArray count];
    //    }
    //    else{
    //        return [shipmodeList count];
    //    }
    if (tableView == shipModeTable) {
        return [shipmodeList count];
    }
    else if(tableView == serchOrderItemTable){
        
        return [serchOrderItemArray count];
    }
    else if(tableView == orderItemsTable){
        
        return [ItemArray count];
    }
    else if (tableView == supplierTable) {
        return [supplierList count];
    }
    else if (searching){
        return [copyListOfItems count];
    }
    else if(tableView == orderstockTable){
        return [itemIdArray count];
    }
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == shipModeTable){
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 255, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:22.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(300, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 175, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
            
        }
        
    }
    else if (tableView == serchOrderItemTable) {
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 400, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:25.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(350, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 150, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        
    }
    
    else{
        return  NO;
    }
}

//Customize HeightForHeaderInSection ...
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == shipModeTable){
        
        return 35.0;
    }
    else if (tableView == serchOrderItemTable) {
        return 35.0;
    }
    else{
        return 0;
    }
    
    
}

//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == orderstockTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 140.0;
        }
        else {
            return 98.0;
        }
        
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 52;
        }
        else{
            
            return 33;
            
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectZero;
    }
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    if (tableView == shipModeTable){
        
        cell.textLabel.text = [shipmodeList objectAtIndex:indexPath.row];
    }
    else if(tableView == serchOrderItemTable){
        
//        NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [serchOrderItemArray objectAtIndex:indexPath.row];
    }
    else if(tableView == orderItemsTable){
        
        if ([ItemArray count] >= 1) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(3, 0, 151, 50)] autorelease];
                label1.font = [UIFont systemFontOfSize:22.0];
                label1.layer.borderWidth = 1.5;
                label1.backgroundColor = [UIColor clearColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 50)] autorelease];
                label5.font = [UIFont systemFontOfSize:22.0];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [ItemArray objectAtIndex:(indexPath.row)];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(305, 0, 150, 50)] autorelease];
                label2.font = [UIFont systemFontOfSize:22.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(456, 0, 151, 50);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:22.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(607, 0, 150, 50)] autorelease];
                label4.font = [UIFont systemFontOfSize:22.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor clearColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                label4.textColor = [UIColor whiteColor];
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = str;
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(767, 2, 45, 45);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:label5];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
                
            }
            else{
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 68, 34)] autorelease];
                label1.font = [UIFont systemFontOfSize:13.0];
                label1.backgroundColor = [UIColor whiteColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)] autorelease];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:14.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(202, 0, 70, 34)] autorelease];
                label4.font = [UIFont systemFontOfSize:13.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor whiteColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(274, 7, 22, 22);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
            }
            
        }
        cell.backgroundColor = [UIColor clearColor];
        
        [cell setTag:indexPath.row];
    }
    else if (tableView == supplierTable) {
        
        
        if ([cell.contentView subviews]){
            for (UIView *subview in [cell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(cell == nil) {
            cell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        // NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        cell.textLabel.text = [supplierList objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        
        return cell;
    }
    else if (tableView == orderstockTable){
        
        if (warePurchaseCountValue_ == YES) {
            
            warePurchaseCount2_ = warePurchaseCount2_ + warePurchaseCount1_;
            warePurchaseCount1_ = 0;
        }
        else{
            
            warePurchaseCount2_ = warePurchaseCount2_ - warePurchaseCount3_;
            warePurchaseCount3_ = 0;
        }
        
        if(searching)
        {
            int x = [[copyListOfItems objectAtIndex:indexPath.row] intValue];
            
            //NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", [itemIdArray objectAtIndex:x]];
            
        }
        else{
            
            // NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", [itemIdArray objectAtIndex:indexPath.row]];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 55)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:30.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.textAlignment = NSTextAlignmentLeft;
            label1.numberOfLines = 2;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.text = itemNameString;
            label1.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            
            UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 55)] autorelease];
            label2.font = [UIFont boldSystemFontOfSize:20.0];
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentLeft;
            label2.numberOfLines = 2;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.text = [orderStatusArray objectAtIndex:(indexPath.row)];
            label2.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(400, 10, 400, 55)] autorelease];
            label3.font = [UIFont boldSystemFontOfSize:20.0];
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentLeft;
            label3.numberOfLines = 2;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.text = [OrderedOnArray objectAtIndex:(indexPath.row)];
            label3.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(400, 90, 200, 55)] autorelease];
            label4.font = [UIFont boldSystemFontOfSize:20.0];
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentLeft;
            label4.numberOfLines = 2;
            label4.lineBreakMode = NSLineBreakByWordWrapping;
            label4.text = [orderAmountArray objectAtIndex:(indexPath.row)];
            label4.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                label1.frame = CGRectMake(5, 10, 150, 30);
                label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label2.frame = CGRectMake(5, 60, 150, 30);
                label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label3.frame = CGRectMake(160, 10, 150, 30);
                label3.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label4.frame = CGRectMake(160, 60, 150, 30);
                label4.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                
            }

            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:label2];
            [cell.contentView addSubview:label3];
            [cell.contentView addSubview:label4];
            
            [cell setBackgroundColor:[UIColor blackColor]];
            
            return cell;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
        }
        else{
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == shipModeTable) {
        shipoMode.text = [shipmodeList objectAtIndex:indexPath.row];
        shipModeTable.hidden = YES;
        dueDateButton.enabled = YES;
    }
    else if(tableView == serchOrderItemTable){
        
        searchItem.text = @"";
        serchOrderItemTable.hidden = YES;
        NSDictionary *json = [skuArrayList objectAtIndex:indexPath.row];
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service getSkuIDForGivenProductName:self action:@selector(getSkuIDForGivenProductNameHandler:) productName: [serchOrderItemArray objectAtIndex:indexPath.row]];
        SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        
        SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
        NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[json objectForKey:@"skuID"]],dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        getSkuid.skuID = salesReportJsonString;
        SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                if ([[JSON objectForKey:@"quantity"] floatValue] > 0) {
                    // NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[JSON objectForKey:@"productName"],@"#",[JSON objectForKey:@"description"],@"#",[JSON objectForKey:@"quantity"],@"#",[JSON objectForKey:@"price"]];
                    //  [unitOfMeasurement addObject:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"sell_UOM"]]];
                    [self getSkuDetailsHandler:JSON];
                }
                else{
                    [HUD setHidden:YES];
                    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Stock Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                
            }
        }
    }
    
    else if (tableView == orderstockTable){
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        ViewWareHousePurchaseOrder *vpo = [[ViewWareHousePurchaseOrder alloc] initWithorderID:[NSString stringWithFormat:@"%@",[itemIdArray objectAtIndex:indexPath.row]]];
        [self.navigationController pushViewController:vpo animated:YES];
    }
    else if (tableView == supplierTable) {
        [supplierTable setHidden:YES];
        customerName.text = [supplierList objectAtIndex:indexPath.row];
        customerCode.text = [supplierCode objectAtIndex:indexPath.row];
        
        
    }

    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    shipCharges.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled = YES;
    paymentMode.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == orderstockTable) {
        //1. Setup the CATransform3D structure
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
        rotation.m34 = 1.0/ -600;
        
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        //!!!FIX for issue #1 Cell position wrong------------
        if(cell.layer.position.x != 0){
            cell.layer.position = CGPointMake(0, cell.layer.position.y);
        }
        
        //4. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.8];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
}

//SearchItem TextFieldDidChange handler....

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItem) {
        
        if ([textField.text length] >= 3) {
            
            [serchOrderItemArray removeAllObjects];   // First clear the filtered array.
            [skuArrayList removeAllObjects];
            
            [self callSkuIdService:textField.text];
            
            // NSLog(@"%@",textField.text);
            
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                if (!([[product objectForKey:@"productId"] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location == NSNotFound))
                {
                    result = [[product objectForKey:@"productId"] compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
                    if (result == NSOrderedSame)
                    {
                        [serchOrderItemArray addObject:[product objectForKey:@"productId"]];
                        [skuArrayList addObject:product];
                        
                    }
                }
                if (!([[product objectForKey:@"description"] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [serchOrderItemArray addObject:[product objectForKey:@"description"]];
                    [skuArrayList addObject:product];
                    
                    
                    
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [[product objectForKey:@"skuID"] compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
                    
                    if (result == NSOrderedSame)
                    {
                        [serchOrderItemArray addObject:[product objectForKey:@"skuID"]];
                        [skuArrayList addObject:product];
                        
                    }
                }
                
                
            }
            
            //[newBillField setEnabled:FALSE];
            
            if ([serchOrderItemArray count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    serchOrderItemTable.frame = CGRectMake(10, 530, 420,240);
                }
                //                else {
                //                    if (version >= 8.0) {
                //                        serchOrderItemTable.frame = CGRectMake(10, 100, 213,100);
                //                    }
                //                    else{
                //                        serchOrderItemTable.frame = CGRectMake(10, 75, 213,100);
                //                    }
                //                }
                
                if ([serchOrderItemArray count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        serchOrderItemTable.frame = CGRectMake(10, 530, 420,450);
                    }
                    //                    else {
                    //                        if (version >= 8.0) {
                    //                            skListTable.frame = CGRectMake(10, 100, 213,100);
                    //                        }
                    //                        else{
                    //                            skListTable.frame = CGRectMake(10, 75, 213,100);
                    //                        }
                    //                    }
                }
                [scrollView bringSubviewToFront:serchOrderItemTable];
                [serchOrderItemTable reloadData];
                serchOrderItemTable.hidden = NO;
            }
            else {
                
                serchOrderItemTable.hidden = YES;
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //                [alert show];
                
            }
            
            
        }
        else if ([textField.text length] == 0) {
            serchOrderItemTable.hidden = YES;
        }
        
    }
    else if (textField == customerName) {
        if ([textField.text length] >= 3) {
            
            [self getSuppliers:textField.text];
            
            if ([supplierList count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    supplierTable.frame = CGRectMake(10, 60, 360,240);
                }
//                else {
//                    if (version >= 8.0) {
//                        supplierTable.frame = CGRectMake(60, 35, 180,130);
//                    }
//                    else{
//                        supplierTable.frame = CGRectMake(60, 35, 180,150);
//                    }
//                }
                
                if ([supplierList count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        supplierTable.frame = CGRectMake(10, 60, 360,450);
                    }
//                    else {
//                        if (version >= 8.0) {
//                            supplierTable.frame = CGRectMake(60, 35, 180,130);
//                        }
//                        else{
//                            supplierTable.frame = CGRectMake(60, 35, 180,150);
//                        }
//                    }
                }
                [scrollView bringSubviewToFront:supplierTable];
                [supplierTable reloadData];
                supplierTable.hidden = NO;
            }
            else {
                supplierTable.hidden = YES;
            }
        }
    }
}
-(void)callSkuIdService:(NSString *)searchString {
    
    [HUD setHidden:NO];
    
    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    
    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:dictionary_,@"0",searchString, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    getSkuid.searchCriteria = salesReportJsonString;
    //
    if ([tempSkuArrayList count]!=0) {
        [tempSkuArrayList removeAllObjects];
    }
    //
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService searchProductsUsingParameters:getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_searchProductsResponse class]]) {
                SkuServiceSvc_searchProductsResponse *body = (SkuServiceSvc_searchProductsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                [HUD setHidden:YES];
                
                NSArray *list = [JSON objectForKey:@"productsList"];
                
                [tempSkuArrayList addObjectsFromArray:list];
            }
        }
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
    }
    
    
    //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    //
    //    SkuServiceSvc_getSkuID *getSkuid = [[SkuServiceSvc_getSkuID alloc] init];
    //    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    //    NSArray *str = [time componentsSeparatedByString:@" "];
    //    NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    //    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    //
    //    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
    //    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    //    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",nil];
    //    NSArray *objects = [NSArray arrayWithObjects:dictionary_, nil];
    //
    //    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    //
    //    NSError * err;
    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    //    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    getSkuid.requestHeader = salesReportJsonString;
    //
    //    if ([skuArrayList count]!=0) {
    //        [skuArrayList removeAllObjects];
    //    }
    //
    //    @try {
    //
    //
    //        SkuServiceSoapBindingResponse *response = [skuService getSkuIDUsingParameters:(SkuServiceSvc_getSkuID *)getSkuid];
    //        NSArray *responseBodyParts = response.bodyParts;
    //        for (id bodyPart in responseBodyParts) {
    //            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDResponse class]]) {
    //                SkuServiceSvc_getSkuIDResponse *body = (SkuServiceSvc_getSkuIDResponse *)bodyPart;
    //                printf("\nresponse=%s",[body.return_ UTF8String]);
    //                NSError *e;
    //                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
    //                                                                     options: NSJSONReadingMutableContainers
    //                                                                       error: &e];
    //                NSArray *list = [JSON objectForKey:@"skuIds"];
    //
    //                [skuArrayList addObjectsFromArray:list];
    //            }
    //        }
    //    }
    //    @catch (NSException *exception) {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //
    //    }
    
}


// Handle the response from searchProduct.
- (void) searchProductHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@"%@",result);
    
    if ([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *tempItems = [JSON1 objectForKey:@"skuIds"];
        
        // serchOrderItemArray initialization...
        serchOrderItemArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[tempItems count]; i++) {
            
            [serchOrderItemArray addObject:[tempItems objectAtIndex:i]];
        }
        
        scrollView.scrollEnabled = NO;
        orderButton.enabled = NO;
        cancelButton.enabled = NO;
        //timeButton.enabled = NO;
        paymentModeButton.enabled= NO;
        customerCode.enabled = NO;
        customerName.enabled = NO;
        searchItem.enabled = NO;
        searchBtton.enabled = NO;
        address.enabled =NO;
        phNo.enabled = NO;
        email.enabled = NO;
        dueDate.enabled = NO;
        dueDateButton.enabled = NO;
        time.enabled = NO;
        shipCharges.enabled = NO;
        //timeButton.enabled = NO;
        shipoMode.enabled = NO;
        shipoModeButton.enabled = NO;
        paymentMode.enabled = NO;
        paymentModeButton.enabled = NO;
        orderItemsTable.userInteractionEnabled = FALSE;
        
        serchOrderItemTable.hidden = NO;
        [self.view bringSubviewToFront:serchOrderItemTable];
        
        [serchOrderItemTable reloadData];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Order Items found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
    }
}
// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    searchItem.text = nil;
    serchOrderItemTable.hidden = YES;
    shipModeTable.hidden = YES;
    paymentTable.hidden= YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    shipCharges.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled = YES;
    paymentMode.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
    
}

// DelButton handler...
- (IBAction)delButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
       
      //  [skuIdArray removeObjectAtIndex:[sender tag]];
        [ItemDiscArray removeObjectAtIndex:[sender tag]];
        [ItemArray removeObjectAtIndex:[sender tag]];
        [priceArray removeObjectAtIndex:[sender tag]];
        [QtyArray removeObjectAtIndex:[sender tag]];
        [totalArray removeObjectAtIndex:[sender tag]];
        [totalQtyArray removeObjectAtIndex:[sender tag]];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
   
    //delButton.tag
  
    [orderItemsTable reloadData];
    
    [self displayOrdersData];
}
-(void)getPurchaseOrders {
    
    [HUD setHidden:NO];
    
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrders *aparams = [[WHPurchaseOrders_getPurchaseOrders alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",warePurchaseChangeNum_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrdersResponse class]]) {
            WHPurchaseOrders_getPurchaseOrdersResponse *body = (WHPurchaseOrders_getPurchaseOrdersResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
}

-(void)getSuppliers:(NSString *)supplierNameStr {
    // BOOL status = FALSE;
    
    [HUD setHidden:NO];
    
    SupplierServiceSoapBinding *skuService = [[SupplierServiceSvc SupplierServiceSoapBinding] retain];
    
    SupplierServiceSvc_getSuppliers *getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date1, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"pageNo",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:dictionary_,@"-1",supplierNameStr, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    getSkuid.supplierDetails = salesReportJsonString;
    //
    if ([supplierList count]!=0) {
        [supplierList removeAllObjects];
        [supplierCode removeAllObjects];
        
    }
    //
    @try {
        
        SupplierServiceSoapBindingResponse *response = [skuService getSuppliersUsingParameters:getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SupplierServiceSvc_getSuppliersResponse class]]) {
                SupplierServiceSvc_getSuppliersResponse *body = (SupplierServiceSvc_getSuppliersResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                [HUD setHidden:YES];
                
                NSArray *list = [JSON objectForKey:@"suppliers"];
                for (int i=0; i<[list count]; i++) {
                    
                    NSDictionary *dic = [list objectAtIndex:i];
                    [supplierCode addObject:[dic objectForKey:@"supplierCode"]];
                    [supplierList addObject:[dic objectForKey:@"firmName"]];
                    
                    
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
    }
    
    
    
    //[skListTable reloadData];
    
}

-(void)backAction {
    if ([ItemArray count]>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
