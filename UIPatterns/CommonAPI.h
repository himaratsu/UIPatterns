//
//  CommonAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUIPatternsBaseUrl @"http://samura1.net/collections/uipatterns/api/"

@interface CommonAPI : NSObject {
    NSString* module;
}

- (id)initWithModule:(NSString*) mod;
- (void)send:(NSDictionary*)param;

@end
