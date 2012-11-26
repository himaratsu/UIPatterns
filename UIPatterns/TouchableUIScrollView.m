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
        longPressBegan = NO;
        startTouches = nil;
    }
    return self;
}

#pragma mark -
#pragma mark Touches Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 長押しカウントスタート
    [self performSelector:@selector(beginLongPress) withObject:nil afterDelay:longPressTime];
    
    self.scrollEnabled = NO;
    [self.nextResponder touchesBegan:touches withEvent:event];
//    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesBegan:withEvent:)]) {
//        [myDelegate scrollViewTouchesBegan:touches withEvent:event];
//    }
    startTouches = touches;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
    if (longPressBegan) {
        if ([myDelegate respondsToSelector:@selector(scrollViewTouchesMoved:withEvent:)]) {
            [myDelegate scrollViewTouchesMoved:touches withEvent:event];
        }
    } else {
        // 長押しでない時に動いたら、長押しカウントを終了
        [self endLongPress];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
    [self.nextResponder touchesEnded:touches withEvent:event];
    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesEnded:withEvent:)]) {
        [myDelegate scrollViewTouchesEnded:touches withEvent:event];
    }
    [self endLongPress];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.scrollEnabled = YES;
    [self.nextResponder touchesCancelled:touches withEvent:event];
    if ([myDelegate respondsToSelector:@selector(scrollViewTouchesCancelled:withEvent:)]) {
        [myDelegate scrollViewTouchesCancelled:touches withEvent:event];
    }
    [self endLongPress];
}

#pragma mark -

- (void)beginLongPress
{
    // 長押しを開始
    if (!longPressBegan) {
        longPressBegan = YES;
        // 長押しスタート地点をdelegateに渡す
        if ([myDelegate respondsToSelector:@selector(scrollViewTouchesBegan:withEvent:)]) {
            [myDelegate scrollViewTouchesBegan:startTouches withEvent:nil];
        }
    }
}

- (void)endLongPress
{
    // beginLongPress の呼び出しをキャンセル。
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginLongPress) object:nil];
    
    // 長押しが開始されていない = シングルタップ
//    if (longPressBegan == NO) {
//        
//    }
    longPressBegan = NO;
}

@end