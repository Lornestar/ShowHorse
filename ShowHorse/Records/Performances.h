//
//  Performances.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-01.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Performances : NSObject
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *Date;
@property  (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Placing;
@property (nonatomic, strong) NSString *Judge;
@property (nonatomic, strong) NSString *Competitors;
@property (nonatomic, strong) NSString  *Score;
@property (nonatomic, strong) PFObject *PerformanceObject;
@property (nonatomic) int listindex;
@end
