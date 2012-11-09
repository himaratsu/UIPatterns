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
    [url appendString:module];
    [url appendString:@"?"];
    [url appendString:[self composeKeyAndValueParams:param]];
    
    return url;
}


- (void)send:(NSDictionary *)param {
    // TODO: APIにアクセス
    NSString* url = [self makeUrl:param];
    NSLog(@"url = %@", url);
}
@end
