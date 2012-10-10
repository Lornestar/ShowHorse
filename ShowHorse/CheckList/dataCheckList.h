//
//  dataCheckList.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CheckList;
@interface dataCheckList : NSObject

-(id)init:(int)type;
@property (nonatomic, strong) NSMutableArray *list;
@end
