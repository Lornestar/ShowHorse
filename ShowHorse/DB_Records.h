//
//  DB_Records.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-15.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DB_Records : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * recordid;

@end
