//
//  TOCropRotateDialView.m
//  TOCropViewControllerExample
//
//  Created by Chris Johnson on 7/27/18.
//  Copyright © 2018 Photage. All rights reserved.
//

#import "TOCropRotateDialView.h"

static const CGFloat kTOCropRotateViewSmallDotSize = 2;
static const CGFloat kTOCropRotateViewLargeDotSize = 4;

static const CGFloat kTOCropRotateViewTextRadiusDiff = 10;

@interface TOCropRotateDialView () {
    CGFloat touchStartPoint;
}

@end

@implementation TOCropRotateDialView

-(void)drawRect:(CGRect)rect {
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    UIColor *kTOCropRotateViewColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    
    // see reference image for calculation
    CGFloat r = (w * w + h * h) / (4 * h);
    CGFloat alpha = atan(w / (2 * r - h));
    CGFloat textRadius = r - kTOCropRotateViewTextRadiusDiff;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName: kTOCropRotateViewColor, NSParagraphStyleAttributeName: style};
    int idx = 0;
    self.baseDegree = M_PI / 6;
    for (CGFloat angle = 0; angle < self.baseDegree + alpha; angle += 2 * M_PI / 180) {
        // draw in angle and in -angel
        int mul = 1;
        while (mul != 0) {
            CGFloat drawAngle = mul * angle;
            CGPoint dotPt = CGPointMake(w / 2 - r * sin(drawAngle), r * cos(drawAngle) - r * cos(alpha));
            CGFloat size = (idx % 5 == 0) ? kTOCropRotateViewLargeDotSize : kTOCropRotateViewSmallDotSize;
            CGRect dotRect = CGRectMake(dotPt.x - size / 2, dotPt.y - size / 2, size, size);
            CGContextFillEllipseInRect(context, dotRect);
            CGContextFillPath(context);
            
            if (idx % 5 == 0) {
                NSString *angleString = [NSString stringWithFormat:@"%d", idx * 2 * mul];
                CGPoint textDrawingCenterPoint = CGPointMake(w / 2 - textRadius * sin(drawAngle), textRadius * cos(drawAngle) - r * cos(alpha));
                CGRect textDrawingRect = CGRectMake(textDrawingCenterPoint.x - 20 / 2, textDrawingCenterPoint.y - 20 / 2, 20, 20);
                [angleString drawInRect:textDrawingRect withAttributes:textAttributes];
            }
            if (mul == 1) {
                mul = -1;
            } else if (mul == -1) {
                mul = 0;
            }
        }
        idx++;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    touchStartPoint = touchPoint.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    CGFloat diff = touchPoint.x - touchStartPoint;
//    self.baseDegree = diff / (self.frame.size.width / 2) * M_PI / 6;
//    NSLog(@"%f, %f", diff, self.baseDegree * 180 / M_PI);
//    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
