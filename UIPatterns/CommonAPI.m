//
//  CommonAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CommonAPI.h"

@implementation CommonAPI

@synthesize delegate = delegate_;

#pragma mark -
#pragma mark Network Method

// paramに格納されたkey->valueを
// key=value と変換して&で連結する
- (NSString*)composeKeyAndValueParams:(NSDictionary*)param {
    NSMutableString* path = [[NSMutableString alloc] init];
    NSArray* allKeys = [param allKeys];
    for (NSString* key in allKeys) {
        NSString* keyEqualValueStr = [NSString stringWithFormat:@"%@=%@", key, [param objectForKey:key]];
        [path appendString:keyEqualValueStr];
        [path appendString:@"&"];
    }
    // 最後の&は削除する
    [path deleteCharactersInRange:NSMakeRange([path length]-1, 1)];
    
    return path;
}

// リクエストURLを作成する
- (NSString*)makeUrl:(NSDictionary *)param {
    NSMutableString* url = [[NSMutableString alloc] initWithString:kUIPatternsBaseUrl];
    [url appendString:module_];
    if (param != nil) {
        [url appendString:@"?"];
        [url appendString:[self composeKeyAndValueParams:param]];
    }
    return url;
}

// リクエストを送信（プライベートメソッド）
- (void)_send: (NSDictionary *)param {
    @autoreleasepool {
        NSString* urlStr = [self makeUrl:param];
        NSURLRequest *req = nil;
        
        NSLog(@"url = %@", urlStr);
        
        // リクエストの作成
        if (urlStr) {
            NSURL *url = [NSURL URLWithString:urlStr];
            if (url) {
                req = [NSURLRequest requestWithURL:url];
            }
        }
        
        if (!req) {
            return;
        }
        
        // ネットワークアクセス開始
        NSData *data;
        NSURLResponse *res;
        NSError *err = nil;
        
        [self _didStartHttpRequest];
        data = [NSURLConnection sendSynchronousRequest:req
                                             returningResponse:&res
                                                         error:&err];
        if (err) {
            // 失敗パターン
            // メインスレッドでデリゲートに通知
            [self performSelectorOnMainThread:@selector(_didErrorHttpRequest:)
                                   withObject:err
                                waitUntilDone:YES];
        } else {
            // 成功パターン
            // パース後、デリゲートに通知
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&err];
            
            [self performSelectorOnMainThread:@selector(_didEndHttpRequest:)
                                   withObject:[self parse:dic]
                                waitUntilDone:YES];
        }
    }
}

// リクエストを送信（パラメータあり）
- (void)send:(NSDictionary *)param {
    // サブスレッドを作成する
    [NSThread detachNewThreadSelector:@selector(_send:) toTarget:self withObject:param];
}

// リクエストを送信（パラメータなし）
- (void)send {
    [self send:nil];
}

#pragma mark -
#pragma mark HttpRequestDelegate Method

- (void)_didStartHttpRequest {
    [delegate_ didStartHttpResuest:nil type:[[self class] description]];
}

- (void)_didEndHttpRequest:(NSDictionary*)result {
    [delegate_ didEndHttpResuest:result type:[[self class] description]];
}

- (void)_didErrorHttpRequest:(NSError*)error {
    [delegate_ didErrorHttpRequest:error type:[[self class] description]];
}

@end
