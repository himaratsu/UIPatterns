//
//  UIPattern.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/10.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "UIPattern.h"

@implementation UIPattern

@synthesize id = id_;
@synthesize title = title_;
@synthesize type = type_;
@synthesize imageUrl = imageUrl_;
@synthesize appStoreUrl = appStoreUrl_;
@synthesize googlePlayUrl = googlePlayUrl_;

- (id)init {
    if (self = [super init]) {
        id_ = nil;
        title_ = nil;
        type_ = nil;
        imageUrl_ = nil;
        appStoreUrl_ = nil;
        googlePlayUrl_ = nil;
    }
    return self;
}

@end
