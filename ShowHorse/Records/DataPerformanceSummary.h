//
//  DataPerformanceSummary.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-01.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Performances.h"

@interface DataPerformanceSummary : NSObject{
    
}
-(void)AddPerformance:(Performances*)PerformanceObject;
- (Performances *)objectInListAtIndex:(unsigned)theIndex;

@end
