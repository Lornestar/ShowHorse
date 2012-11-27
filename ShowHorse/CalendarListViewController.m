//
//  CalendarListViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "CalendarListViewController.h"
#import "CalendarDates.h"
#import "DataCalendarDates.h"
#import "CalendarAddEventPopup.h"
#import "DataCalendarDates.h"

@interface CalendarListViewController ()
@property (nonatomic,strong) DataCalendarDates *datacalendardates;
@end

@implementation CalendarListViewController
@synthesize tableData, appdel,datacalendardates,tblview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO  animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appdel = [UIApplication sharedApplication].delegate;
    tableData = appdel.listdataCalendarDates;
    datacalendardates = [[DataCalendarDates alloc]init];
    tblview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"App_Background.png"]];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [tableData count];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"mycell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){ cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    CalendarDates *tempdate = [tableData objectAtIndex:indexPath.row];
    UILabel *lbltitle = (UILabel*)[cell.contentView viewWithTag:1];
    lbltitle.text = tempdate.EventTitle;
    UILabel *lbldesc = (UILabel*)[cell.contentView viewWithTag:2];
    lbldesc.text = tempdate.EventDescription;
    UILabel *lbldate = (UILabel*)[cell.contentView viewWithTag:3];
    lbldate.text = [appdel.df stringFromDate:tempdate.EventDate];
    return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CalendarAddEventPopup *cldpopup = [[CalendarAddEventPopup alloc] initWithFrame:self.view.bounds  title:@"Add Event" calendarobj:[tableData objectAtIndex:indexPath.row] currentdateselected:[NSDate date]];
    
    
    cldpopup.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
            [self.navigationController setNavigationBarHidden:NO  animated:YES];
            
        }];
        UADebugLog(@"onClosePressed block called from panel: %@", modalPanel);
    };
    
    ///////////////////////////////////////////
    //   Panel is a reference to the modalPanel
    cldpopup.onActionPressed = ^(UAModalPanel* panel) {
        UADebugLog(@"onActionPressed block called from panel: %@", modalPanel);
        NSLog(@"Button Pressed");
    };
    
    UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
    
    cldpopup.delegate = self;
    
    ///////////////////////////////////
    [self.navigationController setNavigationBarHidden:YES  animated:YES];
    // Add the panel to our view
    [self.view addSubview:cldpopup];
    
    ///////////////////////////////////
    // Show the panel from the center of the button that was pressed
    [cldpopup showFromPoint:CGPointMake(0, 0)];
}


-(void)AddCalendars:(CalendarDates*)caltemp{
    //adding image for Reg Papers
    if (caltemp.CalendarDatesObject){
        //Existing object
        caltemp = [datacalendardates AddCalendarDates:caltemp];
        
    }
    else{
        //New one
        caltemp = [datacalendardates AddCalendarDates:caltemp];
    }
    
    [tblview reloadData];
    [self.navigationController setNavigationBarHidden:NO  animated:YES];
}

-(void)DeleteEvent:(CalendarDates*)caltemp{
    //deleting image for Reg Papers
    [datacalendardates DeleteCalendarDates:caltemp];
    [tblview reloadData];
    [self.navigationController setNavigationBarHidden:NO  animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTblview:nil];
    [super viewDidUnload];
}
@end
