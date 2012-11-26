//
//  CollectionListView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/18.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionGetAPI.h"
#import "CollectionItemView.h"

@protocol CollectionItemHoverDelegate;

@interface CollectionItemListView : UIView <HttpRequestDelegate> {
    UIScrollView *scrollView;
}

@property (nonatomic, weak) id<CollectionItemHoverDelegate, CollectionItemViewDelegate> delegate;
- (void)scrollTouchMoved:(NSSet*)touches;
- (void)scrollTouchEnded:(NSSet*)touches;

@end


@protocol CollectionItemHoverDelegate <NSObject>

- (void)collectionItemHoverRelease:(NSSet*)touches
                             diffX:(CGFloat)x
                             diffY:(CGFloat)y
                      collectionId:(NSString*)collectionId;
- (void)collectionItemNoHoverRelease;

@end