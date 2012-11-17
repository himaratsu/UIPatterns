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
#import "PullUpdateView.h"

#define NUM_OF_PAGES 4

@interface FeedViewController : UIViewController 
<HttpRequestDelegate,
ActionImageViewDelegate,
TouchableUIScrollDelegate,
UIScrollViewDelegate> {
    TouchableUIScrollView* scrollView;
    UIView* highliteBackView;
    
    DraggableView* ridhtCollectionView;
    UIPatternThumbView* thumbView;
    PullUpdateView *pullView;
    CGPoint startLocation;
    CGPoint currentLocation;
}

@end
