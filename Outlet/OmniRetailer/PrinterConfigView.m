//
//  PrinterConfigView.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "PrinterConfigView.h"

#import <QuartzCore/QuartzCore.h>
#import "DataBaseConnection.h"
#import "sqlite3.h"


static sqlite3 *database = nil;
static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;

@implementation PrinterConfigView

@synthesize ipTxt, portTxt;
@synthesize soundFileURLRef,soundFileObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
       
    }

    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //Get data from database
    // getting the present value's from database ..
    NSString *portIp = NULL;
    NSString *portNumber = NULL;
    
    NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from PrinterConfigCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {  
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {  
                
                portIp = @((char *)sqlite3_column_text(selectStmt, 0));
                portNumber = @((char *)sqlite3_column_text(selectStmt, 1));                   
            }
            sqlite3_finalize(selectStmt); 
        }
    }     
    
    selectStmt = nil;
    sqlite3_close(database);
    
   // labels ..
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"Printer Configuration";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
 
    
    UILabel *ip    = [[UILabel alloc] init];
    UILabel *port  = [[UILabel alloc] init];
    
    ip.text    = @"Printer IP";
    port.text  = @"Port Number";
    
    ip.textColor = [UIColor whiteColor];
    port.textColor = [UIColor whiteColor];
    
    ip.backgroundColor    = [UIColor clearColor];
    port.backgroundColor  = [UIColor clearColor];

    // Text Fields ..
    self.ipTxt   = [[UITextField alloc] init];
    self.portTxt = [[UITextField alloc] init];
    
    ipTxt.layer.masksToBounds=YES;
    ipTxt.layer.borderColor=[UIColor grayColor].CGColor;
    ipTxt.layer.borderWidth= 1.0f;
    
    portTxt.layer.masksToBounds=YES;
    portTxt.layer.borderColor=[UIColor grayColor].CGColor;
    portTxt.layer.borderWidth= 1.0f;
    
    self.ipTxt.backgroundColor   = [UIColor whiteColor];
    self.portTxt.backgroundColor = [UIColor whiteColor];
    
    if (portNumber != NULL || portIp != NULL) {
        ipTxt.text = portIp;
        portTxt.text = portNumber;
    }
    
    self.ipTxt.layer.cornerRadius   = 5;
    self.portTxt.layer.cornerRadius = 5;
    
    // button to Ok and save the payment credentials ..
    UIButton *submitBtn = [[UIButton alloc] init] ;
    [submitBtn addTarget:self action:@selector(closePrinterConfigView:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.tag = 0;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.cornerRadius = 3.0f;
    
    // button to cancel with out saving the changes ..
    UIButton *cancelBtn = [[UIButton alloc] init] ;
    [cancelBtn addTarget:self action:@selector(closePrinterConfigView:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 3.0f;
 
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        headerimg.frame = CGRectMake(0, 0, 668, 80);
        title.frame = CGRectMake(200, 15, 400, 50);
        title.font = [UIFont boldSystemFontOfSize:30];

        ip.font = [UIFont systemFontOfSize:25];
        ip.frame = CGRectMake(40, 140, 200, 50);
        port.font = [UIFont systemFontOfSize:25];
        port.frame = CGRectMake(40, 260, 200, 50);
        ipTxt.font = [UIFont systemFontOfSize:25];
        ipTxt.frame = CGRectMake(250, 140, 350, 60);
        portTxt.font = [UIFont systemFontOfSize:25];
        portTxt.frame = CGRectMake(250, 260, 350, 60);
        
        submitBtn.frame = CGRectMake(50, 380, 275, 60);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        submitBtn.layer.cornerRadius = 25.0f;
        
        cancelBtn.frame = CGRectMake(335, 380, 275, 60);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelBtn.layer.cornerRadius = 25.0f;
    }
    else {
        headerimg.frame = CGRectMake(0, 0, 280, 38);
        title.frame = CGRectMake(60, 5, 200, 30);
        title.font = [UIFont boldSystemFontOfSize:15];

        ip.frame = CGRectMake(10, 50, 100, 30);
        port.frame = CGRectMake(10, 110, 100, 30);
        ipTxt.frame = CGRectMake(110, 50, 130, 30);
        portTxt.frame = CGRectMake(110, 110, 130, 30);
       
        submitBtn.frame = CGRectMake(10, 170, 115, 30);
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        submitBtn.layer.cornerRadius = 15.0f;
        
        cancelBtn.frame = CGRectMake(132, 170, 120, 30);
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cancelBtn.layer.cornerRadius = 15.0f;
    }
    
    ipTxt.delegate = self;
    portTxt.delegate = self;
    
    [self addSubview:headerimg];
    [self addSubview:title];
    [self addSubview:ip];
    [self addSubview:port];
    [self addSubview:self.ipTxt];
    [self addSubview:self.portTxt];
    [self addSubview:submitBtn];
    [self addSubview:cancelBtn];
    
    return self;
}


- (void) closePrinterConfigView:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([sender tag] == 0) {
        
        
        NSString *value1 = [ipTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value2 = [portTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Store the Values in Database After Validating ..
        if (value1.length==0 || value2.length==0){
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Printer IP and Port Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [ip show];
        }
        else {
            
            NSString* dbPath = [DataBaseConnection connection:@"RetailerConfigDataBase.sqlite"];
            
            // delete all rows when u r inserting new things..
            if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                
                if (deleteStmt == nil) {
                    const char *sqlStatement = "delete from PrinterConfigCredentials";
                    
                    if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                        
                        if(SQLITE_DONE != sqlite3_step(deleteStmt)) 
                            NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                        
                        sqlite3_reset(deleteStmt);
                    }
                    
                }
                
            }
            deleteStmt = nil;
            
            
            // inserting ftp details into database
            
            if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                
                if (insertStmt == nil) {        
                    const char *sqlStatement = "insert into PrinterConfigCredentials(printerip, portnumber) Values(?, ?)";
                    
                    if(sqlite3_prepare_v2(database, sqlStatement, -1, &insertStmt, NULL) == SQLITE_OK) {
                        
                        
                        sqlite3_bind_text(insertStmt, 1, (ipTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                        sqlite3_bind_text(insertStmt, 2, (portTxt.text).UTF8String, -1, SQLITE_TRANSIENT);
                        
                        //  sqlite3_bind_int(insertStmt, 1, [ipTxt.text intValue]);

                        //sqlite3_bind_int(insertStmt, 2, [portTxt.text intValue]);
                        
                        if(SQLITE_DONE != sqlite3_step(insertStmt)) 
                            NSAssert1(0, @"Error While Inserting. '%s'",sqlite3_errmsg(database));
                        
                        sqlite3_reset(insertStmt);    
                        
                    }
                    
                }
                insertStmt = nil;
            }
            sqlite3_close(database);
            
            StatusView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            StatusView.opaque = NO;
            StatusView.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:0.8];
            StatusView.layer.cornerRadius = 15;
            
            UILabel *created = [[UILabel alloc] init] ;
            created.text = @"Successfully Configured"; 
            created.backgroundColor = [UIColor clearColor];
            created.textAlignment = NSTextAlignmentCenter;
            
            // button to cancel with out saving the changes ..
            UIButton *cancelBtn = [[UIButton alloc] init] ;
            [cancelBtn setTitle:@"OK" forState:UIControlStateNormal];
            cancelBtn.layer.cornerRadius = 3.0f;
            cancelBtn.tag = 1;
            //cancelBtn.backgroundColor = [UIColor grayColor];
            cancelBtn.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:0.8];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  {
                StatusView.frame = CGRectMake(20, 20, 628, 450);
                created.font = [UIFont systemFontOfSize:30];
                created.frame = CGRectMake(20, 120, 580, 40);
                
                cancelBtn.frame = CGRectMake(160, 220, 320, 60);
                cancelBtn.layer.cornerRadius = 25.0f;
                cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
       
            }
            else {
                StatusView.frame = CGRectMake(10, 10, 240, 200);
                created.frame = CGRectMake(10, 80, 220, 20);
                
                cancelBtn.frame = CGRectMake(10, 120, 220, 32);
                cancelBtn.layer.cornerRadius = 15.0f;
                cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            }
            
            [StatusView addSubview:created];
            [StatusView addSubview:cancelBtn];
            [self addSubview:StatusView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.cancelsTouchesInView = NO; 
            [self addGestureRecognizer:tapGesture];
        }
        
    }
    else {
        
        (self.superview.subviews)[0].alpha = 1.0f;
        [(self.superview.subviews)[0] setEnabled:YES];
        
        [self removeFromSuperview];
        
    }    
    
}


- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    StatusView.hidden = YES;
    
    (self.superview.subviews)[0].alpha = 1.0f;
    [(self.superview.subviews)[0] setEnabled:YES];
    
    [self removeFromSuperview];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [ipTxt resignFirstResponder];
    [portTxt  resignFirstResponder];
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}


@end
