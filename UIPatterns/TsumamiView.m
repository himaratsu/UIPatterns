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
    [delegate_ touchesBeganTsumamiView:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [delegate_ touchesMovedTsumamiView:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [delegate_ touchesEndedTsumamiView:touches withEvent:event];
}

@end
