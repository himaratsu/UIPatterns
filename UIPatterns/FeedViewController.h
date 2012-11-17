//
//  ViewController.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAPI.h"
#import "LazyImageView.h"
#import "UIPatternThumbView.h"
#import "TouchableUIScrollView.h"
#import "DraggableView.h"

#define NUM_OF_PAGES 4

@interface FeedViewController : UIViewController
<HttpRequestDelegate,
ActionImageViewDelegate,
TouchableUIScrollDelegate> {
    UIScrollView* scrollView;
    UIView* highliteBackView;
    
    DraggableView* ridhtCollectionView;
    UIPatternThumbView* thumbView;
    CGPoint startLocation;
    CGPoint currentLocation;
}

@end
