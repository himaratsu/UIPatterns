//
//  CollectionItemView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/17.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionItemView.h"

@implementation CollectionItemView

@synthesize collectionItem = collectionItem_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        // 画像を追加
        UIImage *imageOn  = [UIImage imageNamed:@"collection_on.png"];
        UIImage *imageOff = [UIImage imageNamed:@"collection_off.png"];
        collectionItemTitleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        collectionItemTitleView.backgroundColor = [UIColor clearColor];
        [collectionItemTitleView setBackgroundImage:imageOff forState:UIControlStateNormal];
        [collectionItemTitleView setBackgroundImage:imageOn forState:UIControlStateHighlighted];
        [self addSubview:collectionItemTitleView];
        
        // タイトルを追加
        collectionItemTitleLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, collectionItemTitleView.frame.size.height-5, self.frame.size.width, 40)];
        collectionItemTitleLabel.backgroundColor = [UIColor clearColor];
        collectionItemTitleLabel.text = @"";
        collectionItemTitleLabel.numberOfLines = 0;
        collectionItemTitleLabel.font = [UIFont fontWithName:@"American Typewriter" size:15.0f];
        [self addSubview:collectionItemTitleLabel];
    }
    return self;
}

- (void)setCollectionItem:(CollectionItem *)collectionItem {
    collectionItemTitleLabel.text = collectionItem.title;
    collectionItem_ = collectionItem;
}

// collectionItemTitleViewをハイライト表示する
- (void)setHighlighted:(BOOL)boolean {
    [collectionItemTitleView setHighlighted:boolean];
}

@end
