//
//  CheckListViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-26.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "CheckListViewController.h"
#import "AppDelegate.h"
#import "CheckList.h"
#import "CheckListAddItemPopup.h"


@interface CheckListViewController (){
   int CurrentSelection;
    AppDelegate *appdel;
}

@end

#define riderposition (CGPoint){160,72.5};
#define saddleryposition (CGPoint){160,162.5};
#define groomingkitposition (CGPoint){160,252.5};
#define stableposition (CGPoint){160,342.5};
#define hidingpoint (CGPoint){160,500};
static const NSTimeInterval animduration = 0.75;
static const NSTimeInterval animdelay = 0.25;

@implementation CheckListViewController
@synthesize btnGroomingKit,btnRider,btnSaddlery,btnStable,vwAddItembackground,tblview, datachecklist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appdel = [UIApplication sharedApplication].delegate;
    tblview.alpha = 0;
    [appdel initChecklist];
    CurrentSelection = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBtnRider:nil];
    [self setBtnSaddlery:nil];
    [self setBtnGroomingKit:nil];
    [self setBtnStable:nil];
    [self setVwAddItembackground:nil];
    [self setTblview:nil];
    [super viewDidUnload];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Only one section, so return the number of items in the list.
    if (CurrentSelection ==1){
        return appdel.listdataChecklistRiders.list.count;
    }
    else if (CurrentSelection ==2){
        return appdel.listdataChecklistSaddlery.list.count;
    }
    else if (CurrentSelection ==3){
        return  appdel.listdataChecklistGrooming.list.count;
    }
    else{
        return appdel.listdataChecklistStable.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"mycell";
    // Dequeue or create a cell of the appropriate type.
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CheckList *chktemp;
    switch (CurrentSelection) {
        case 1:
            chktemp = [appdel.listdataChecklistRiders.list objectAtIndex:indexPath.row];
            break;
        case 2:
            chktemp = [appdel.listdataChecklistSaddlery.list objectAtIndex:indexPath.row];
            break;
        case 3:
            chktemp = [appdel.listdataChecklistGrooming.list objectAtIndex:indexPath.row];
            break;
        case 4:
            chktemp = [appdel.listdataChecklistStable.list objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    UILabel *lblthelabel = (UILabel*)[cell.contentView viewWithTag:2];
    lblthelabel.text = chktemp.theLabel;
    
    UILabel *lblnum = (UILabel*)[cell.contentView viewWithTag:3];
    int currentline = chktemp.listindex + 1;
    lblnum.text = [NSString stringWithFormat:@"%d", currentline];
    
    UIImageView *imgview = (UIImageView*)[cell.contentView viewWithTag:1];
    if (chktemp.ischecked){
        imgview.hidden = NO;
    }
    else{
        imgview.hidden = YES;
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckList *chktemp;
    switch (CurrentSelection) {
        case 1:
            chktemp = [appdel.listdataChecklistRiders.list objectAtIndex:indexPath.row];
            chktemp.ischecked = [self HorseShoeFlip:chktemp.ischecked];
            [appdel.listdataChecklistRiders.list setObject:chktemp atIndexedSubscript:indexPath.row];
            break;
        case 2:
            chktemp = [appdel.listdataChecklistSaddlery.list objectAtIndex:indexPath.row];
            chktemp.ischecked = [self HorseShoeFlip:chktemp.ischecked];
            [appdel.listdataChecklistSaddlery.list setObject:chktemp atIndexedSubscript:indexPath.row];
            break;
        case 3:
            chktemp = [appdel.listdataChecklistGrooming.list objectAtIndex:indexPath.row];
            chktemp.ischecked = [self HorseShoeFlip:chktemp.ischecked];
            [appdel.listdataChecklistGrooming.list setObject:chktemp atIndexedSubscript:indexPath.row];
            break;
        case 4:
            chktemp = [appdel.listdataChecklistStable.list objectAtIndex:indexPath.row];
            chktemp.ischecked = [self HorseShoeFlip:chktemp.ischecked];
            [appdel.listdataChecklistStable.list setObject:chktemp atIndexedSubscript:indexPath.row];
            break;
    }
    UITableViewCell *thecell = [tblview cellForRowAtIndexPath:indexPath];
    UIImageView *imgview = (UIImageView*)[thecell.contentView viewWithTag:1];
    if (chktemp.ischecked){
        imgview.hidden = NO;
    }
    else{
        imgview.hidden = YES;
    }
}

-(BOOL)HorseShoeFlip:(BOOL)currenthorseshoe{
    if (currenthorseshoe == YES){
        return NO;
    }
    else{
        return YES;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1){
        NSMutableArray *temparray;
        temparray = [[NSMutableArray alloc]init];
        switch (CurrentSelection) {
            case 1:
                for (CheckList *chktemp in appdel.listdataChecklistRiders.list){
                    chktemp.ischecked = NO;
                    [temparray addObject:chktemp];
                }
                appdel.listdataChecklistRiders.list = temparray;
                break;
            case 2:
                for (CheckList *chktemp in appdel.listdataChecklistSaddlery.list){
                    chktemp.ischecked = NO;
                    [temparray addObject:chktemp];
                }
                appdel.listdataChecklistSaddlery.list = temparray;
                break;
            case 3:
                for (CheckList *chktemp in appdel.listdataChecklistGrooming.list){
                    chktemp.ischecked = NO;
                    [temparray addObject:chktemp];
                }
                appdel.listdataChecklistGrooming.list = temparray;
                break;
            case 4:
                for (CheckList *chktemp in appdel.listdataChecklistStable.list){
                    chktemp.ischecked = NO;
                    [temparray addObject:chktemp];
                }
                appdel.listdataChecklistStable.list = temparray;
                break;
        }
        [tblview reloadData];
    }
}

- (IBAction)btnresetChecklistClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure your want to reset this list?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
    [alert show];
    
}

- (IBAction)btnRiderClicked:(id)sender {
    CurrentSelection = 1;
    [tblview reloadData];

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animduration];
    [UIView setAnimationDelay:animdelay];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 1;
        
        btnSaddlery.center = hidingpoint;
        btnGroomingKit.center = hidingpoint;
        btnStable.center = hidingpoint;
    }
    
    [UIView commitAnimations];

    datachecklist = [[dataCheckList alloc]init:1];
}

- (IBAction)btnSaddleryClicked:(id)sender {
    CurrentSelection = 2;
    [tblview reloadData];

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animduration];
    [UIView setAnimationDelay:animdelay];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 1;
        
        btnSaddlery.center = riderposition;
        btnRider.center = hidingpoint;
        btnGroomingKit.center = hidingpoint;
        btnStable.center = hidingpoint;
    }
    
    [UIView commitAnimations];
    datachecklist = [[dataCheckList alloc]init:2];
}

- (IBAction)btnGroomingClicked:(id)sender {
    CurrentSelection = 3;
    [tblview reloadData];

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animduration];
    [UIView setAnimationDelay:animdelay];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 1;
        
        btnRider.center = hidingpoint;
        btnSaddlery.center = hidingpoint;
        btnGroomingKit.center = riderposition;
        btnStable.center = hidingpoint;
    }
    
    [UIView commitAnimations];
    datachecklist = [[dataCheckList alloc]init:3];
}

- (IBAction)btnStableClicked:(id)sender {
    CurrentSelection = 4;
    [tblview reloadData];

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animduration];
    [UIView setAnimationDelay:animdelay];
    
    if (tblview.alpha == 1){
        //then return to normal
        
        [self ReturnState];
    }
    else{
        tblview.alpha = 1;
        
        btnRider.center = hidingpoint;
        btnSaddlery.center = hidingpoint;
        btnGroomingKit.center = hidingpoint;
        btnStable.center = riderposition;
    }
    
    [UIView commitAnimations];
    datachecklist = [[dataCheckList alloc]init:4];
}

- (IBAction)btnAddItemClicked:(id)sender {
    CheckListAddItemPopup *chkpopup = [[CheckListAddItemPopup alloc] initWithFrame:self.view.bounds  title:@"Add Item" checklistobj:nil];
    
    
    chkpopup.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
        }];
        UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
    };
    
    ///////////////////////////////////////////
    //   Panel is a reference to the modalPanel
    chkpopup.onActionPressed = ^(UAModalPanel* panel) {
        UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
        NSLog(@"Button Pressed");
    };
    
    UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
    
    chkpopup.delegate = self;
    
    ///////////////////////////////////
    // Add the panel to our view
    [self.view addSubview:chkpopup];
    
    ///////////////////////////////////
    // Show the panel from the center of the button that was pressed
    UIButton *btntemp = (UIButton*)sender;
    [chkpopup showFromPoint:btntemp.center];
}

-(void)ReturnState{
    btnRider.alpha = 1;
    btnGroomingKit.alpha = 1;
    btnSaddlery.alpha = 1;
    btnStable.alpha = 1;
    tblview.alpha = 0;
    
    btnRider.center = riderposition;
    btnSaddlery.center = saddleryposition;
    btnGroomingKit.center = groomingkitposition;
    btnStable.center = stableposition;
    [tblview setContentOffset:CGPointZero];
}

-(void)AddCheckList:(CheckList*)chktemp{
    chktemp = [datachecklist AddCheckListItems:chktemp CurrentSelection:CurrentSelection];
    switch (CurrentSelection) {
        case 1:
            [appdel.listdataChecklistRiders.list setObject:chktemp atIndexedSubscript:chktemp.listindex];
            break;
        case 2:
            [appdel.listdataChecklistSaddlery.list setObject:chktemp atIndexedSubscript:chktemp.listindex];
            break;
        case 3:
            [appdel.listdataChecklistGrooming.list setObject:chktemp atIndexedSubscript:chktemp.listindex];
            break;
        case 4:
            [appdel.listdataChecklistStable.list setObject:chktemp atIndexedSubscript:chktemp.listindex];
            break;
    }
    [tblview reloadData];
}

@end
