//
//  FeedAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "FeedAPI.h"

@implementation FeedAPI

- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        module_ = @"feed.php";
        delegate_ = delegate;
    }
    return self;
}

- (void)parse:(NSDictionary*)dic {
    NSLog(@"FeedAPIParser#parse");
}

@end


@implementation FeedAPIParser

- (void)parse:(NSDictionary*)dic {

}

@end