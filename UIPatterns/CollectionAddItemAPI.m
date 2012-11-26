//
//  CollectionAddItemAPI.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/26.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionAddItemAPI.h"

@implementation CollectionAddItemAPI

- (id)initWithDelegate:(id)delegate {
    if (self = [super init]) {
        module_ = @"collection_add_item.php";
        delegate_ = delegate;
    }
    return self;
}

- (id)parse:(NSDictionary*)dic {
    CollectionAddItemAPIParser* parser = [[CollectionAddItemAPIParser alloc] init];
    return [parser parse:dic];
}


@end



@implementation CollectionAddItemAPIParser

- (id)parse:(NSDictionary*)dic {
    return dic;
}

@end
