//
//  CalendarAddEventPopup.m
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "CalendarAddEventPopup.h"
#import "CalendarDates.h"
#import "CalendarViewController.h"

#define BLACK_BAR_COMPONENTS		{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }



@implementation CalendarAddEventPopup
@synthesize vwCalendarAddEvent,txtEventDate,txtEventDescription,txtEventTitle,globaldatacalendar,btnCreateEvent,vwdatepicker,chosendate;


- (id)initWithFrame:(CGRect)frame title:(NSString *)title calendarobj:(CalendarDates*)calendarobj
{
    if ((self = [super initWithFrame:frame])) {
		
		CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
		self.headerLabel.text = title;
        [self setTitleBarHeight:15];
        [self headerLabel].font = [UIFont boldSystemFontOfSize:20];
        self.margin = UIEdgeInsetsMake(15, 15, 0, 15);
        self.padding = UIEdgeInsetsMake(5, 5, 5, 5);
        
        //Reg Papers
        [[NSBundle mainBundle]  loadNibNamed:@"CalendarAddEvent" owner:self options:nil];
        [self.contentView addSubview:vwCalendarAddEvent];
        [txtEventTitle becomeFirstResponder];
        chosendate = [NSDate date];
        
        if (calendarobj){
            globaldatacalendar = calendarobj;
            txtEventTitle.text = calendarobj.EventTitle;
            txtEventDescription.text = calendarobj.EventDescription;
            txtEventDate.text = [NSString stringWithFormat:@"%@", calendarobj.EventDate];
            btnCreateEvent.titleLabel.text = @"Save Event";
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

- (IBAction)btnCreateEvent_Clicked:(id)sender {
    CalendarDates *tempcal;
    if (globaldatacalendar){
        //existing one
        tempcal = globaldatacalendar;
    }
    else{
        tempcal = [[CalendarDates alloc]init];
    }
    
    tempcal.EventTitle = txtEventTitle.text;
    tempcal.EventDescription = txtEventDescription.text;
    tempcal.EventDate = chosendate;
    
    if ([delegate respondsToSelector:@selector(AddCalendars:)]) {
        [delegate performSelector:@selector(AddCalendars:) withObject:tempcal];
        [self hide];
        // Or perhaps someone is listening for notifications
    }
}

- (IBAction)txtEventDateClicked:(id)sender {
    [vwCalendarAddEvent endEditing:YES];
    [sender resignFirstResponder];
    CalendarViewController *cvc = (CalendarViewController*)delegate;
    [cvc presentSemiModalViewController:vwdatepicker];
}

#pragma mark -
#pragma mark Date Picker Delegate

-(void)datePickerSetDate:(TDDatePickerController*)viewController {
    CalendarViewController *cvc = (CalendarViewController*)delegate;
	[cvc dismissSemiModalViewController:vwdatepicker];
    
    NSDate *d = viewController.datePicker.date;
    //TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	txtEventDate.text = [NSString stringWithFormat:@"%@",d];
    chosendate = d;
}

-(void)datePickerClearDate:(TDDatePickerController*)viewController {
    CalendarViewController *cvc = (CalendarViewController*)delegate;
	[cvc dismissSemiModalViewController:vwdatepicker];
    
	//selectedDate = nil;
}

-(void)datePickerCancel:(TDDatePickerController*)viewController {
    CalendarViewController *cvc = (CalendarViewController*)delegate;
	[cvc dismissSemiModalViewController:vwdatepicker];
}

@end
