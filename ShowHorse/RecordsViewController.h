//
//  RecordsViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-27.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UAModalPanel.h"
#import "Performances.h"
@class DataHorseSummary, DataPerformanceSummary, DataRegPapers , MGScrollView, MGBox;;


@interface RecordsViewController : UIViewController< UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UAModalPanelDelegate>{

    
}
@property (weak, nonatomic) IBOutlet UIButton *btnHorseSummary;
@property (weak, nonatomic) IBOutlet UIButton *btnRiderSummary;
@property (weak, nonatomic) IBOutlet UIButton *btnPerformanceSummary;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistrationPapers;
@property (weak, nonatomic) IBOutlet UITableView *tblview;
@property (weak, nonatomic) IBOutlet UITextField *txtEditField;
@property (weak, nonatomic) IBOutlet UITableView *tblviewperformance;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPerformance;


- (IBAction)btnHorseSummary:(id)sender;
- (IBAction)btnRiderSummary:(id)sender;
- (IBAction)btnPerformanceSummary:(id)sender;
- (IBAction)btnRegistrationPapers:(id)sender;


@property (nonatomic, strong) DataHorseSummary *dataHorseSummary;
@property (nonatomic, strong) DataPerformanceSummary *dataPerformanceSummary;
@property (nonatomic, strong) DataRegPapers *dataRegPapers;
@property (nonatomic, retain) NSArray *tableData;
@property (nonatomic, retain) NSDictionary *tblresult;
@property (nonatomic) CGPoint hidingpoint;
@property (nonatomic) CGPoint horsepoint;
@property (nonatomic) CGPoint riderpoint;
@property (nonatomic) CGPoint performpoint;
@property (nonatomic) CGPoint registerpoint;
@property (nonatomic) int CurrentSelection;

- (IBAction)btnEditDone:(id)sender;
- (IBAction)txtEditFieldDone:(id)sender;
- (IBAction)btnPerformanceClicked:(id)sender;

@property (nonatomic, retain) AppDelegate *appdelegate;
-(void)AddPerformance:(Performances*)PerformanceObject;
@property (weak, nonatomic) IBOutlet MGScrollView *scrollPapers;
@property (weak, nonatomic) IBOutlet UIView *vwRegPapers;


@end
