//
//  CollectionItem.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/17.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionItem.h"

@implementation CollectionItem

@synthesize collectionId = collectionId_;
@synthesize title = title_;
@synthesize imageUrl = imageUrl_;

- (id)init {
    self = [super init];
    if (self) {
        collectionId_ = nil;
        title_ = nil;
        imageUrl_ = nil;
    }
    return self;
}

@end
