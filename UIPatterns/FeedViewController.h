//
//  ViewController.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonAPI.h"
#import "UIPatternView.h"
#import "UIPatternThumbView.h"
#import "TouchableUIScrollView.h"
#import "CollectionNavigationView.h"
#import "PullUpdateView.h"

@interface FeedViewController : UIViewController 
<HttpRequestDelegate,
TapUIImageViewDelegate,
TouchableUIScrollDelegate,
UIScrollViewDelegate> {
    TouchableUIScrollView* scrollView;      // タッチ可能なスクロールビュー
    CollectionNavigationView* ridhtCollectionView;  // コレクションナビゲーションバー
    PullUpdateView *pullView;               // 「引っ張って更新」ビュー
    
    UIView* highliteBackView;               // ドラッグ中の背景ビュー
    UIPatternThumbView* thumbView;          // ドラッグ中に表示するサムネイルビュー
    
    CGPoint startLocation;                  // ドラッグ開始位置
    CGPoint currentLocation;                // ドラッグ中の現在位置
}

@end
