//
//  CalendarViewController.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarAddEventPopup.h"
#import "CalendarDates.h"
#import "DataCalendarDates.h"

@implementation CalendarViewController
@synthesize dataArray, dataDictionary,calendar, datacalendardates, appdel,tblview,tableData;



- (void) viewDidLoad{
	[super viewDidLoad];
	//[self.monthView selectDate:[NSDate month]];
    calendar = 	[[TKCalendarMonthView alloc] init];
    calendar.delegate = self;
    calendar.dataSource = self;
    
    // Add Calendar to just off the top of the screen so it can later slide down
	calendar.frame = CGRectMake(0, 38, calendar.frame.size.width, calendar.frame.size.height);
    //int tempy= calendar.frame.size.height;
	// Ensure this is the last "addSubview" because the calendar must be the top most view layer
	[self.view addSubview:calendar];
	[calendar reload];
    
    datacalendardates = [[DataCalendarDates alloc]init];
}
- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"dd.MM.yy"];
    //NSDate *d = [dateFormatter dateFromString:@"02.05.11"];
    //[dateFormatter release];
    //[self.monthView selectDate:d];
	
    [self.navigationController setNavigationBarHidden:YES  animated:YES];
	
}

-(void)updatetableData:(NSDate*)currentdate{
    NSDateComponents *comp1 = [[NSCalendar currentCalendar]components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:currentdate];
    NSInteger *d1 = [comp1 day];
    NSInteger *d2 = [comp1 month];
    NSInteger *d3 = [comp1 year];
    NSInteger *d4;
    NSInteger *d5;
    NSInteger *d6;
    NSDateComponents *comp2;
    NSMutableArray *temparray = [[NSMutableArray alloc]init];
    for (CalendarDates* tempcal in appdel.listdataCalendarDates){
        comp2 = [[NSCalendar currentCalendar]components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:tempcal.EventDate];
        d4 = [comp2 day];
        d5 = [comp2 month];
        d6 = [comp2 year];
        if (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year])){
            //Same day
            [temparray addObject:tempcal];
        }
    }
    tableData = temparray;
}

- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
    /*
     appdel = [UIApplication sharedApplication].delegate;
     for (CalendarDates* tempcal in appdel.listdataCalendarDates){
     //[dataDictionary setObject:[NSArray arrayWithObjects:tempcal.EventTitle,nil] forKey:tempcal.EventDate];
     //[self.dataArray addObject:[NSNumber numberWithBool:YES]];
     }*/
	return dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
	// CHANGE THE DATE TO YOUR TIMEZONE
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
	NSLog(@"Date Selected: %@",myTimeZoneDay);
    
    [self updatetableData:date];
    
	[tblview reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	//[super calendarMonthView:mv monthDidChange:d animated:animated];
	[tblview reloadData];
    
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
	
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	/*NSArray *ar = [dataDictionary objectForKey:[calendar dateSelected]];
     if(ar == nil) return 0;*/
    
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
    return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CalendarAddEventPopup *cldpopup = [[CalendarAddEventPopup alloc] initWithFrame:self.view.bounds  title:@"Add Event" calendarobj:[tableData objectAtIndex:indexPath.row]];
    
    
    cldpopup.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
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
    // Add the panel to our view
    [self.view addSubview:cldpopup];
    
    ///////////////////////////////////
    // Show the panel from the center of the button that was pressed
    [cldpopup showFromPoint:tblview.center];
}


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
	
	NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
	
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	appdel = [UIApplication sharedApplication].delegate;
    
	NSDate *d = start;
    int counter = 1;
	while(YES){
        
        /*	int r = arc4random();
         if(r % 3==1){
         [self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",@"Item two",nil] forKey:d];
         [self.dataArray addObject:[NSNumber numberWithBool:YES]];
         
         }else if(r%4==1){
         [self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",nil] forKey:d];
         [self.dataArray addObject:[NSNumber numberWithBool:YES]];
         
         }else*/
        [self.dataArray addObject:[NSNumber numberWithBool:NO]];
		
		
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        counter +=1;
		if([d compare:end]==NSOrderedDescending) break;
	}
	for (CalendarDates* tempcal in appdel.listdataCalendarDates){
        if (([tempcal.EventDate timeIntervalSinceDate:start] > 0) && ([tempcal.EventDate timeIntervalSinceDate:end] < 0)){
            
            [dataDictionary setObject:[NSArray arrayWithObjects:tempcal.EventTitle,nil] forKey:tempcal.EventDate];
            //[self.dataArray addObject:[NSNumber numberWithBool:YES]];
            //find index to put it on
            double timediff = [tempcal.EventDate timeIntervalSinceDate:start];
            timediff = fabs(timediff/86400);
            int theindex = (int)timediff;
            if (theindex < dataArray.count) {
                //add item to the day view
                [dataArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:theindex];
            }
            
            
            
        }
    }
}

/*
 @interface CalendarViewController ()
 
 @end
 
 @implementation CalendarViewController
 @synthesize calendar;
 
 -(void)viewDidAppear:(BOOL)animated{
 [self.navigationController setNavigationBarHidden:YES  animated:YES];
 }
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 
 calendar = 	[[TKCalendarMonthView alloc] init];
 calendar.delegate = self;
 calendar.dataSource = self;
 
 // Add Calendar to just off the top of the screen so it can later slide down
 calendar.frame = CGRectMake(0, 38, calendar.frame.size.width, calendar.frame.size.height);
 int tempy= calendar.frame.size.height;
 // Ensure this is the last "addSubview" because the calendar must be the top most view layer
 [self.view addSubview:calendar];
 [calendar reload];
 
 }
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 #pragma mark -
 #pragma mark TKCalendarMonthViewDelegate methods
 
 - (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
 NSLog(@"calendarMonthView didSelectDate");
 }
 
 - (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
 NSLog(@"calendarMonthView monthDidChange");
 }
 
 #pragma mark -
 #pragma mark TKCalendarMonthViewDataSource methods
 
 - (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
 NSLog(@"calendarMonthView marksFromDate toDate");
 NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
 // When testing initially you will have to update the dates in this array so they are visible at the
 // time frame you are testing the code.
 NSArray *data = [NSArray arrayWithObjects:
 @"2011-01-01 00:00:00 +0000", @"2011-01-09 00:00:00 +0000", @"2011-01-22 00:00:00 +0000",
 @"2011-01-10 00:00:00 +0000", @"2011-01-11 00:00:00 +0000", @"2011-01-12 00:00:00 +0000",
 @"2011-01-15 00:00:00 +0000", @"2011-01-28 00:00:00 +0000", @"2011-01-04 00:00:00 +0000",
 @"2011-01-16 00:00:00 +0000", @"2011-01-18 00:00:00 +0000", @"2011-01-19 00:00:00 +0000",
 @"2011-01-23 00:00:00 +0000", @"2011-01-24 00:00:00 +0000", @"2011-01-25 00:00:00 +0000",
 @"2011-02-01 00:00:00 +0000", @"2011-03-01 00:00:00 +0000", @"2011-04-01 00:00:00 +0000",
 @"2011-05-01 00:00:00 +0000", @"2011-06-01 00:00:00 +0000", @"2011-07-01 00:00:00 +0000",
 @"2011-08-01 00:00:00 +0000", @"2011-09-01 00:00:00 +0000", @"2011-10-01 00:00:00 +0000",
 @"2011-11-01 00:00:00 +0000", @"2011-12-01 00:00:00 +0000", nil];
 
 
 // Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
 NSMutableArray *marks = [NSMutableArray array];
 
 // Initialise calendar to current type and set the timezone to never have daylight saving
 NSCalendar *cal = [NSCalendar currentCalendar];
 [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
 
 // Construct DateComponents based on startDate so the iterating date can be created.
 // Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed
 // with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first
 // iterating date then times would go up and down based on daylight savings.
 NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
 NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
 fromDate:startDate];
 NSDate *d = [cal dateFromComponents:comp];
 
 // Init offset components to increment days in the loop by one each time
 NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
 [offsetComponents setDay:1];
 
 
 // for each date between start date and end date check if they exist in the data array
 while (YES) {
 // Is the date beyond the last date? If so, exit the loop.
 // NSOrderedDescending = the left value is greater than the right
 if ([d compare:lastDate] == NSOrderedDescending) {
 break;
 }
 
 // If the date is in the data array, add it to the marks array, else don't
 if ([data containsObject:[d description]]) {
 [marks addObject:[NSNumber numberWithBool:YES]];
 } else {
 [marks addObject:[NSNumber numberWithBool:NO]];
 }
 
 // Increment day using offset components (ie, 1 day in this instance)
 d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
 }
 
 
 return [NSArray arrayWithArray:marks];
 }*/


- (IBAction)AddEvent_Clicked:(id)sender {
    CalendarAddEventPopup *cldpopup = [[CalendarAddEventPopup alloc] initWithFrame:self.view.bounds  title:@"Add Event" calendarobj:nil];
    
    
    cldpopup.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
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
    // Add the panel to our view
    [self.view addSubview:cldpopup];
    
    ///////////////////////////////////
    // Show the panel from the center of the button that was pressed
    UIButton *btntemp = (UIButton*)sender;
    [cldpopup showFromPoint:btntemp.center];
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
    [appdel.listdataCalendarDates setObject:caltemp atIndexedSubscript:caltemp.listindex-1];
    
}

- (void)viewDidUnload {
    [self setTblview:nil];
    [super viewDidUnload];
}
@end
