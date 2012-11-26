//
//  CollectionGetContentAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/24.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionGetContentAPI.h"

@implementation CollectionGetContentAPI

- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        module_ = @"collection_get_content.php";
        delegate_ = delegate;
    }
    return self;
}

- (id)parse:(NSDictionary*)dic {
    CollectionGetContentAPIParser* parser = [[CollectionGetContentAPIParser alloc] init];
    return [parser parse:dic];
}

// 引数が文字列の場合のsendメソッド
- (void)sendWithCollectionId:(NSString *)collectionId {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:collectionId, @"collection_id", nil];
    NSLog(@"collectionId = %@", collectionId);
    NSLog(@"params = %@", params);
    [self send:params];
}

@end

@implementation CollectionGetContentAPIParser

- (id)parse:(NSDictionary*)dic {
    result = [[NSMutableDictionary alloc] init];
    
//    NSArray* uiPatterns = [dic objectForKey:@"uiPatterns"];
//    
//    if ([dic objectForKey:@"totalCount"]) {
//        [result setObject:[dic objectForKey:@"totalCount"] forKey:@"totalCount"];
//    }
//    if ([dic objectForKey:@"responseCount"]) {
//        [result setObject:[dic objectForKey:@"responseCount"] forKey:@"responseCount"];
//    }
//    
//    NSMutableArray* patternArray = [NSMutableArray array];
//    
//    for (NSDictionary* pattern in uiPatterns) {
//        UIPattern* uiPattern = [[UIPattern alloc] init];
//        uiPattern.id = [pattern objectForKey:@"id"];
//        uiPattern.title = [pattern objectForKey:@"title"];
//        uiPattern.type = [pattern objectForKey:@"type"];
//        uiPattern.imageUrl = [pattern objectForKey:@"imageUrl"];
//        if ([pattern objectForKey:@"appStoreUrl"]) {
//            uiPattern.appStoreUrl = [pattern objectForKey:@"appStoreUrl"];
//        }
//        if ([pattern objectForKey:@"googlePlayUrl"]) {
//            uiPattern.appStoreUrl = [pattern objectForKey:@"googlePlayUrl"];
//        }
//        [patternArray addObject:uiPattern];
//    }
//    
//    if ([patternArray count] > 0) {
//        [result setObject:patternArray forKey:@"uipatterns"];
//    }
    
    return result;
}

@end