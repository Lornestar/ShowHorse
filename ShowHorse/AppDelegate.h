//
//  AppDelegate.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-16.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataHorseSummary.h"
#import "User.h"
#import "dataCheckList.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) DataHorseSummary *dataHorseSummary;
@property (nonatomic, strong) DataHorseSummary *dataRiderSummary;
@property (nonatomic, strong) User *userinfo;
@property (nonatomic, strong) NSMutableArray *listdataPerformances;
@property (nonatomic, strong) NSMutableArray *listdataPapers;
@property (nonatomic, strong) dataCheckList *listdataChecklistRiders;
@property (nonatomic, strong) dataCheckList *listdataChecklistSaddlery;
@property (nonatomic, strong) dataCheckList *listdataChecklistGrooming;
@property (nonatomic, strong) dataCheckList *listdataChecklistStable;
@property (nonatomic, strong) NSMutableArray *listdataCalendarDates;
@property (strong,nonatomic) NSDateFormatter *df;
@property (strong,nonatomic) NSDate *calendarmonth;
@property (nonatomic, strong) UIManagedDocument *ShowHorseDatabase;  // Model is a Core Data database


-(void) initRecords;
-(void) initPerformances;
-(void) initPapers;
-(void) initChecklist;
-(void)logoutVariables;
-(void) initUser:(NSString*)username userid:(NSString*)userid;
-(void) initCalendarDates;
-(void)SaveDatabase;
@end
