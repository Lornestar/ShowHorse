//
//  DB_Performance.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-17.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DB_Performance : NSManagedObject

@property (nonatomic, retain) NSString * competitors;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * judge;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * perf_description;
@property (nonatomic, retain) NSString * placing;
@property (nonatomic, retain) NSString * score;
@property (nonatomic, retain) NSNumber * listindex;

@end
