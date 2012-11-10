//
//  CommonAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CommonAPI.h"

@implementation CommonAPI

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

- (NSString*)makeUrl:(NSDictionary *)param {
    NSMutableString* url = [[NSMutableString alloc] initWithString:kUIPatternsBaseUrl];
    [url appendString:module_];
    [url appendString:@"?"];
    [url appendString:[self composeKeyAndValueParams:param]];
    
    return url;
}


- (void)send:(NSDictionary *)param {
    // TODO: APIにアクセス
    NSString* urlStr = [self makeUrl:param];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", urlStr);
    
    NSURLResponse *res;
    NSError *err = nil;
    
    // 通信開始
    [delegate_ didStartHttpResuest];
    NSData* data = [NSURLConnection sendSynchronousRequest:req
                                         returningResponse:&res
                                                     error:&err];
    [delegate_ didEndHttpResuest];
    
    // 結果のJSONをパース
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&err];
    NSLog(@"dic = %@", dic);
}
@end
