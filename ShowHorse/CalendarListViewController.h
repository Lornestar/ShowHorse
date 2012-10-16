//
//  CalendarListViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-10.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class DataCalendarDates;

@interface CalendarListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *tableData;
@property (strong, nonatomic) AppDelegate *appdel;

@end
