//
//  CollectionGetAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/18.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionGetAPI.h"
#import "CollectionItem.h"

@implementation CollectionGetAPI

- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        module_ = @"collection_get.php";
        delegate_ = delegate;
    }
    return self;
}

- (id)parse:(NSDictionary*)dic {
    CollectionGetAPIParser* parser = [[CollectionGetAPIParser alloc] init];
    return [parser parse:dic];
}

@end

@implementation CollectionGetAPIParser

- (id)parse:(NSDictionary*)dic {
    result = [[NSMutableDictionary alloc] init];
    
    NSArray* collections = [dic objectForKey:@"collections"];
    
    if ([dic objectForKey:@"totalCount"]) {
        [result setObject:[dic objectForKey:@"totalCount"] forKey:@"totalCount"];
    }
    if ([dic objectForKey:@"responseCount"]) {
        [result setObject:[dic objectForKey:@"responseCount"] forKey:@"responseCount"];
    }
    
    NSMutableArray* collectionArray = [NSMutableArray array];
    
    for (NSDictionary* collection in collections) {
        CollectionItem* colItem = [[CollectionItem alloc] init];
        colItem.collectionId = [collection objectForKey:@"collectionId"];
        colItem.title = [collection objectForKey:@"title"];
        colItem.imageUrl = [collection objectForKey:@"imageUrl"];
        [collectionArray addObject:colItem];
    }
    
    if ([collectionArray count] > 0) {
        [result setObject:collectionArray forKey:@"collections"];
    }
    
    return result;
}


@end