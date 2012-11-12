//
//  FeedAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "FeedAPI.h"
#import "UIPattern.h"

@implementation FeedAPI

- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        module_ = @"feed.php";
        delegate_ = delegate;
    }
    return self;
}

- (id)parse:(NSDictionary*)dic {
    FeedAPIParser* parser = [[FeedAPIParser alloc] init];
    return [parser parse:dic];
}

@end


@implementation FeedAPIParser

- (id)parse:(NSDictionary*)dic {
    result = [[NSMutableDictionary alloc] init];
    
    NSArray* uiPatterns = [dic objectForKey:@"uiPatterns"];
    
    if ([dic objectForKey:@"totalCount"]) {
        [result setObject:[dic objectForKey:@"totalCount"] forKey:@"totalCount"];
    }
    if ([dic objectForKey:@"responseCount"]) {
        [result setObject:[dic objectForKey:@"responseCount"] forKey:@"responseCount"];
    }
    
    NSMutableArray* patternArray = [NSMutableArray array];
    
    for (NSDictionary* pattern in uiPatterns) {
        UIPattern* uiPattern = [[UIPattern alloc] init];
        uiPattern.id = [pattern objectForKey:@"id"];
        uiPattern.title = [pattern objectForKey:@"title"];
        uiPattern.type = [pattern objectForKey:@"type"];
        uiPattern.imageUrl = [pattern objectForKey:@"imageUrl"];
        if ([pattern objectForKey:@"appStoreUrl"]) {
            uiPattern.appStoreUrl = [pattern objectForKey:@"appStoreUrl"];
        }
        if ([pattern objectForKey:@"googlePlayUrl"]) {
            uiPattern.appStoreUrl = [pattern objectForKey:@"googlePlayUrl"];
        }
        [patternArray addObject:uiPattern];
    }
    
    if ([patternArray count] > 0) {
        [result setObject:patternArray forKey:@"uipatterns"];
    }
    
    return result;
}

@end