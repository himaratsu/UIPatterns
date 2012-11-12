//
//  CommonAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUIPatternsBaseUrl @"http://samura1.net/collection/uipatterns/api/"

@protocol HttpRequestDelegate
@required
- (void)didStartHttpResuest:(id)result;
- (void)didEndHttpResuest:(id)result;
- (void)didErrorHttpRequest:(id)result;
@end


@interface CommonAPI : NSObject {
    NSString* module_;
    id<HttpRequestDelegate> delegate_;
}

@property (strong) id<HttpRequestDelegate> delegate;

- (id)initWithDelegate:(id)delegate;
- (void)send:(NSDictionary*)param;
- (void)send;
- (id)parse:(NSDictionary*)dic;

@end
