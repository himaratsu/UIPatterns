//
//  DraggableView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TsumamiView.h"

#define kMenuBarMoveRange   150           // バーの移動幅
#define kTsumamiSizeWidth   50            // サイドバーのつまみの幅
#define kTsumamiSizeHeight  50            // サイドバーのつまみの高さ

@interface CollectionNavigationView : UIView <TsumamiViewTouchActionDelegate> {
    CGPoint startLocation;  // バーの移動開始位置
    BOOL isTouchesMove;     // タッチ後、バーを少しでも移動したかどうか
    CGRect posA, posB;      // posA <--> posB
    BOOL isCurrentPosA;     // いまいる位置がposAかどうか
    
    CGFloat borderLeft, borderHalf, borderRight;    // 左端ライン、中央ライン、右端ライン
}

- (void)moveToPositionAWithAnimation:(BOOL)animated;    // posAへバーを移動させる
- (void)moveToPositionBWithAnimation:(BOOL)animated;    // posBへバーを移動させる

@end
