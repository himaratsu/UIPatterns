//
//  Util.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/13.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (void)hideStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
}

@end
