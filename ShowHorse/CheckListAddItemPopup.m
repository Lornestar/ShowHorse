//
//  CheckListAddItemPopup.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-16.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "CheckListAddItemPopup.h"
#import "OverlayViewController.h"

#define BLACK_BAR_COMPONENTS				{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }

@implementation CheckListAddItemPopup
@synthesize  globaldatachecklist, txtItemName, btnCreateItem, vwAddCheckList;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title checklistobj:(CheckList*)checklistobj
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
		self.headerLabel.text = title;
        [self setTitleBarHeight:15];
        [self headerLabel].font = [UIFont boldSystemFontOfSize:20];
        self.margin = UIEdgeInsetsMake(15, 15, 0, 15);
        self.padding = UIEdgeInsetsMake(5, 5, 5, 5);
        
        //Reg Papers
        [[NSBundle mainBundle]  loadNibNamed:@"AddCheckListItem" owner:self options:nil];
        [self.contentView addSubview:vwAddCheckList];
        [txtItemName becomeFirstResponder];
        
        if (checklistobj){
            globaldatachecklist = checklistobj;
            txtItemName.text = checklistobj.theLabel;
            
            btnCreateItem.titleLabel.text = @"Save Item";
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)btnCreateItemClicked:(id)sender {
    CheckList *tempcal;
    if (globaldatachecklist){
        //existing one
        tempcal = globaldatachecklist;
    }
    else{
        tempcal = [[CheckList alloc]init];
    }
    
    tempcal.theLabel = txtItemName.text;
    
    if ([delegate respondsToSelector:@selector(AddCheckList:)]) {
        [delegate performSelector:@selector(AddCheckList:) withObject:tempcal];
        [self hide];
        // Or perhaps someone is listening for notifications
    }

}
@end
