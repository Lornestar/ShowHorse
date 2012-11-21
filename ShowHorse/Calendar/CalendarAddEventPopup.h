//
//  CalendarAddEventPopup.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "OverlayViewController.h"
#import "DataCalendarDates.h"
#import "TDDatePickerController.h"

@interface CalendarAddEventPopup : UATitledModalPanel<OverlayViewControllerDelegate> {
    
}
@property (strong, nonatomic) IBOutlet UIView *vwCalendarAddEvent;
@property (weak, nonatomic) IBOutlet UITextField *txtEventTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtEventDate;
@property (weak, nonatomic) IBOutlet UITextView *txtEventDescription;
@property (strong, nonatomic) CalendarDates *globaldatacalendar;
- (IBAction)btnCreateEvent_Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateEvent;
@property (strong, nonatomic) IBOutlet TDDatePickerController *vwdatepicker;
- (IBAction)txtEventDateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *thedatepicker;
@property (strong, nonatomic) IBOutlet UIView *vwthedatepicker;

- (IBAction)btnDateCancelClicked:(id)sender;
- (IBAction)btnSelectDateClicked:(id)sender;


- (id)initWithFrame:(CGRect)frame title:(NSString *)title calendarobj:(CalendarDates*)calendarobj currentdateselected:(NSDate*)currentdateselected;

@property (strong,nonatomic) NSDate *chosendate;
@property (strong,nonatomic) NSDateFormatter *df;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
- (IBAction)btnDeleteClicked:(id)sender;
@property (strong, nonatomic) NSDate *globalcurrentdateselected;
@end
