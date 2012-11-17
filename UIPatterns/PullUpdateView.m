//
//  PullUpdateView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/17.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "PullUpdateView.h"

@implementation PullUpdateView

@synthesize label = label_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor yellowColor];
        
        label_ = [[UILabel alloc] initWithFrame:CGRectMake(362, 15, 300, 20)];
        label_.text = @"↑ 引っ張って更新";
        label_.textAlignment = NSTextAlignmentCenter;
        label_.textColor = [UIColor grayColor];
        label_.font = [UIFont fontWithName:@"American Typewriter" size:20];
        label_.font = [UIFont boldSystemFontOfSize:20];
        label_.backgroundColor = [UIColor clearColor];
        [self addSubview:label_];
    }
    return self;
}

@end
