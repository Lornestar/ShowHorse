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
@synthesize dataArray, dataDictionary,calendar, datacalendardates, appdel,tblview,tableData,currentdateselected;



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
    currentdateselected = [NSDate date];
    datacalendardates = [[DataCalendarDates alloc]init];
    }
- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
    [calendar reload];
    [self updatetableData:[NSDate date]];
    [tblview reloadData];
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"dd.MM.yy"];
    //NSDate *d = [dateFormatter dateFromString:@"02.05.11"];
    //[dateFormatter release];
    //[self.monthView selectDate:d];
	
    [self.navigationController setNavigationBarHidden:YES  animated:YES];
	
}

-(void)updatetableData:(NSDate*)currentdate{
    NSDateComponents *comp1 = [[NSCalendar currentCalendar]components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:currentdate];
        NSDateComponents *comp2;
    NSMutableArray *temparray = [[NSMutableArray alloc]init];
    
    for (CalendarDates* tempcal in appdel.listdataCalendarDates){
        
        comp2 = [[NSCalendar currentCalendar]components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:tempcal.EventDate];
        
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
	TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone systemTimeZone]];
	NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	
	NSLog(@"Date Selected: %@",myTimeZoneDay);
    currentdateselected = date;
    [self updatetableData:date];
    
	[tblview reloadData];
    [self adjusttable];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	//[super calendarMonthView:mv monthDidChange:d animated:animated];
	[tblview reloadData];
    [self adjusttable];
}

-(void) adjusttable{
    if (calendar.frame.size.height > 266){
        //large size
        tblview.center = CGPointMake(160, 400);
    }
    else{
        //smaller size
        tblview.center = CGPointMake(160, 356);
    }
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
    UILabel *lbldate = (UILabel*)[cell.contentView viewWithTag:3];
    lbldate.text = [appdel.df stringFromDate:tempdate.EventDate];
    return cell;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CalendarAddEventPopup *cldpopup = [[CalendarAddEventPopup alloc] initWithFrame:self.view.bounds  title:@"Add Event" calendarobj:[tableData objectAtIndex:indexPath.row] currentdateselected:currentdateselected];
    
    
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
		
		
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone systemTimeZone]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
        //d = [d addTimeInterval:60*60*24];
        
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


- (IBAction)AddEvent_Clicked:(id)sender {
    CalendarAddEventPopup *cldpopup = [[CalendarAddEventPopup alloc] initWithFrame:self.view.bounds  title:@"Add Event" calendarobj:nil currentdateselected:currentdateselected];
    
    
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
    
    [calendar reload];
    [self updatetableData:[NSDate date]];
    [tblview reloadData];
}

-(void)DeleteEvent:(CalendarDates*)caltemp{
    //deleting image for Reg Papers
    [datacalendardates DeleteCalendarDates:caltemp];
    [calendar reload];
    [self updatetableData:[NSDate date]];
    [tblview reloadData];
}

- (void)viewDidUnload {
    [self setTblview:nil];
    [super viewDidUnload];
}
@end
