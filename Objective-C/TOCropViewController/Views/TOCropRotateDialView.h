//
//  TOCropRotateDialView.h
//  TOCropViewControllerExample
//
//  Created by Chris Johnson on 7/27/18.
//  Copyright © 2018 Photage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOCropRotateDialView;

@protocol TOCropRotateDialViewDelegate

- (void)cropRotateDialView:(TOCropRotateDialView *)view didRotate:(CGFloat)angle;
- (void)cropRotateDialViewDidRotateStart:(TOCropRotateDialView *)view;
- (void)cropRotateDialViewDidRotateEnd:(TOCropRotateDialView *)view;

@end

@interface TOCropRotateDialView : UIView

/**
 Base degree in radians. Starting from 0, in range of -pi/4 ~ pi/4, 0 for reset
 */
@property (nonatomic, readwrite) CGFloat baseDegree;

@property (weak, nonatomic) id<TOCropRotateDialViewDelegate> delegate;

@end
