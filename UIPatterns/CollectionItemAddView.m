//
//  CollectionItemAddView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/12/01.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionItemAddView.h"

@implementation CollectionItemAddView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        collectionItemTitleLabel.text = @"Add Collection";
    }
    return self;
}

@end
