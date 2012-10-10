//
//  CheckList.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-09.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject
@property (nonatomic, strong) NSString *theLabel;
@property (nonatomic) int listindex;
@property (nonatomic) BOOL ischecked;
@end
