//
//  Records.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-09-28.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Records : NSObject
@property (nonatomic, strong) NSString *Question;
@property (nonatomic, strong) NSString *Answer;
@property (nonatomic) int Section;
@property (nonatomic) int RecordID;
@property (nonatomic, strong) NSString *RecordObjectID;
@end
