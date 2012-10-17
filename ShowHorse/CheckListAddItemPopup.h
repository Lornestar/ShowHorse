//
//  CheckListAddItemPopup.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-16.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "OverlayViewController.h"
#import "CheckList.h"

@interface CheckListAddItemPopup : UATitledModalPanel<OverlayViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtItemName;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateItem;
- (IBAction)btnCreateItemClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vwAddCheckList;

@property(strong,nonatomic) CheckList *globaldatachecklist;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title checklistobj:(CheckList*)checklistobj;
@end
