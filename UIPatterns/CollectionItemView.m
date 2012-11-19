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
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setBackgroundImage:imageOff forState:UIControlStateNormal];
        [btn setBackgroundImage:imageOn forState:UIControlStateHighlighted];
        [self addSubview:btn];
        
        // タイトルを追加
        label = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, btn.frame.size.height-5, self.frame.size.width, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"";
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"American Typewriter" size:15.0f];
        [self addSubview:label];
    }
    return self;
}

- (void)setCollectionItem:(CollectionItem *)collectionItem {
    label.text = collectionItem.title;
    collectionItem_ = collectionItem;
}

@end
