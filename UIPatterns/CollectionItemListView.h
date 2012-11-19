//
//  CollectionListView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/18.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionGetAPI.h"

@interface CollectionItemListView : UIView <HttpRequestDelegate> {
    UIScrollView *scrollView;
}

@end
