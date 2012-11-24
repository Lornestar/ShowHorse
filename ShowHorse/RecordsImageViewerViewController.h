//
//  RecordsImageViewerViewController.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-20.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsImageViewerViewController : UIViewController  <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imgRecords;
@property (strong, nonatomic) UIImage *globalImgRecords;
- (IBAction)btnBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *imgviewscroller;

@end
