//
//  TouchableUIScrollView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/15.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "TouchableUIScrollView.h"

@implementation TouchableUIScrollView

@synthesize myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -
#pragma mark Touches Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"customTouchesBegan");
    self.scrollEnabled = NO;
    [self.nextResponder touchesBegan:touches withEvent:event];
    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesBegan:withEvent:)]) {
        [myDelegate scrollViewTouchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"customTouchesMoved");
    [self.nextResponder touchesMoved:touches withEvent:event];
    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesMoved:withEvent:)]) {
        [myDelegate scrollViewTouchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"customTouchesEnded");
    self.scrollEnabled = YES;
    [self.nextResponder touchesEnded:touches withEvent:event];
    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesEnded:withEvent:)]) {
        [myDelegate scrollViewTouchesEnded:touches withEvent:event];
    }
}


- (void)setDragAndDropMode:(BOOL)mode {
    self.delaysContentTouches = !mode;
}


@end
