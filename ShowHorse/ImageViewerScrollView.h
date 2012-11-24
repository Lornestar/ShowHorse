//
//  ImageViewerScrollView.h
//  ShowHorse
//
//  Created by Lorne Lantz on 2012-11-21.
//  Copyright (c) 2012 ShowHorse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerScrollView : UIScrollView <UIScrollViewDelegate> {
    UIImageView *imageView;
}

@property (nonatomic, retain)   UIImageView     *imageView;

#pragma mark Initialisation
- (id)initWithImageNamed:(UIImage *)theimage atLocation:(CGPoint)location;

@end
