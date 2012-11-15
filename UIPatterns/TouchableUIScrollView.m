//
//  TouchableUIScrollView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/15.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "TouchableUIScrollView.h"

@implementation TouchableUIScrollView

@synthesize delegate;

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
    if ([delegate respondsToSelector:@selector(scrollViewTouchesBegan:withEvent:)]) {
        [delegate scrollViewTouchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"customTouchesMoved");
    [self.nextResponder touchesMoved:touches withEvent:event];
    if ([delegate respondsToSelector:@selector(scrollViewTouchesMoved:withEvent:)]) {
        [delegate scrollViewTouchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"customTouchesEnded");
    self.scrollEnabled = YES;
    [self.nextResponder touchesEnded:touches withEvent:event];
    if ([delegate respondsToSelector:@selector(scrollViewTouchesEnded:withEvent:)]) {
        [delegate scrollViewTouchesEnded:touches withEvent:event];
    }
}


- (void)setDragAndDropMode:(BOOL)mode {
    self.delaysContentTouches = !mode;
}


@end
