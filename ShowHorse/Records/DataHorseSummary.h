//
//  DataHorseSummary.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-28.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//
#import "User.h"
@class Records;
@interface DataHorseSummary : NSObject
- (unsigned)countOfList;
- (Records *)objectInListAtIndex:(unsigned)theIndex;
- (void)updateobjectInListAtIndex:(unsigned)theIndex updatevalue:(NSString*)updatevalue;
- (NSMutableArray *)entirelist;
@property (nonatomic, readwrite) NSMutableArray *list;
-(void)createHorseData;
- (id)initRider;


@property (nonatomic,retain) User *userinfo;
@end
