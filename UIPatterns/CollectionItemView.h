//
//  CollectionItemView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/17.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionItem.h"

@interface CollectionItemView : UIView {
    UILabel* collectionItemTitleLabel;
    UIButton* collectionItemTitleView;
}

@property (nonatomic, strong) CollectionItem *collectionItem;

- (void)setHighlighted:(BOOL)boolean;

@end
