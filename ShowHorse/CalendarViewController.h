//
//  CalendarViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
/*#import "TKCalendarMonthView.h"

@interface CalendarViewController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource> {
	TKCalendarMonthView *calendar;
}

@property (nonatomic, retain) TKCalendarMonthView *calendar;
*/

#import "TapkuLibrary.h"
#import "AppDelegate.h"
@class DataCalendarDates;

@interface CalendarViewController : UIViewController <TKCalendarMonthViewDataSource, TKCalendarMonthViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) TKCalendarMonthView *calendar;

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (weak, nonatomic) IBOutlet UITableView *tblview;
@property (strong, nonatomic) DataCalendarDates *datacalendardates;
@property (strong, nonatomic) AppDelegate *appdel;
@property (nonatomic, retain) NSArray *tableData;

- (IBAction)AddEvent_Clicked:(id)sender;

@end
