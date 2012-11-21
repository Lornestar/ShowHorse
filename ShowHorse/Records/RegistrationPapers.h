//
//  RegistrationPapers.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-10-05.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "DB_Registration_Papers.h"

@interface RegistrationPapers : NSObject
@property (nonatomic, strong) UIImage *Papers;
@property (nonatomic, strong) DB_Registration_Papers *PapersObject;
@property (nonatomic) int listindex;



@end
