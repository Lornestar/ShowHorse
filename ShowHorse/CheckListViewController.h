//
//  CheckListViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-26.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckListViewController : UIViewController< UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnRider;
@property (weak, nonatomic) IBOutlet UIButton *btnSaddlery;
@property (weak, nonatomic) IBOutlet UIButton *btnGroomingKit;
@property (weak, nonatomic) IBOutlet UIButton *btnStable;
@property (weak, nonatomic) IBOutlet UIView *vwAddItembackground;
@property (weak, nonatomic) IBOutlet UITableView *tblview;

- (IBAction)btnRiderClicked:(id)sender;
- (IBAction)btnSaddleryClicked:(id)sender;
- (IBAction)btnGroomingClicked:(id)sender;
- (IBAction)btnStableClicked:(id)sender;
- (IBAction)btnAddItemClicked:(id)sender;

@end
