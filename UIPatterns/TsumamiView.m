//
//  TsumamiView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TsumamiView.h"

@implementation TsumamiView
@synthesize delegate = delegate_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    //    startLocation = [[touches anyObject] locationInView:self];
    //    [[self superview] bringSubviewToFront:self];
    
    [delegate_ touchesBeganTsumamiView:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    //    CGPoint pt = [[touches anyObject] locationInView:self];
    //	CGRect frame = [self frame];
    //	frame.origin.x += pt.x - startLocation.x;
    //	[self setFrame:frame];
    
    [delegate_ touchesMovedTsumamiView:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    
    [delegate_ touchesEndedTsumamiView:touches withEvent:event];
}
@end
