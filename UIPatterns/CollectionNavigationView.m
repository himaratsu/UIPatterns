//
//  DraggableView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CollectionNavigationView.h"
#import "CollectionItemListView.h"

@implementation CollectionNavigationView

#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // コレクションアイテムを表示するビュー
        CollectionItemListView* collectionView = [[CollectionItemListView alloc]
                                  initWithFrame:CGRectMake(kTsumamiSizeWidth,
                                                           0,
                                                           frame.size.width-kTsumamiSizeWidth,
                                                           frame.size.height)];
        collectionView.backgroundColor = kDefaultSubColor;        
        // 影をつける
        collectionView.layer.shadowOpacity = 0.4;
        collectionView.layer.shadowOffset = CGSizeMake(-4.0, 4.0);
        [self addSubview:collectionView];
        
        
        // 左下に表示する「ツマミ」
        TsumamiView* tsumamiView = [[TsumamiView alloc]
                                    initWithFrame:CGRectMake(0,
                                                             frame.size.height-kTsumamiSizeHeight,
                                                             kTsumamiSizeWidth,
                                                             kTsumamiSizeHeight)];
        tsumamiView.delegate = self;
        tsumamiView.backgroundColor = collectionView.backgroundColor;
        // 影をつける
        tsumamiView.layer.shadowOpacity = 0.4;
        tsumamiView.layer.shadowOffset = CGSizeMake(-4.0, 4.0);
        [self addSubview:tsumamiView];
        
        isTouchesMove = NO;
        isCurrentPosA = YES;
        
        posA = frame;
        posB = CGRectMake(frame.origin.x+kMenuBarMoveRange, frame.origin.y,
                          frame.size.width, frame.size.height);

        borderLeft  = frame.origin.x;
        borderHalf  = frame.origin.x+kMenuBarMoveRange/2-kTsumamiSizeWidth;
        borderRight = frame.origin.x+kMenuBarMoveRange;
    }
    return self;
}

#pragma mark -
#pragma mark TsumamiViewTouchActionDelegate

// ツマミが移動開始した
- (void)touchesBeganTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event {
    isTouchesMove = NO;
    startLocation = [[touches anyObject] locationInView:self];  // 初期位置を覚えておく
    [[self superview] bringSubviewToFront:self];
}

// ツマミが移動した
- (void)touchesMovedTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isTouchesMove == NO) {
        isTouchesMove = YES;    // 少しでも移動した
    }
    
    CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
    // 範囲内であれば移動を許可
    if (frame.origin.x > borderLeft && frame.origin.x < borderRight) {
        [self setFrame:frame];
    }
}

// ツマミが移動終了した
- (void)touchesEndedTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event {    
    // 移動してなければposA <--> posBに移動
    if (isTouchesMove == NO) {
        if (isCurrentPosA) {
            [self moveToPositionBWithAnimation:YES];
        } else {
            [self moveToPositionAWithAnimation:YES];
        }
    } else {
        // 移動していた場合、posAとposBの近い方に移動
        if (self.frame.origin.x <= borderHalf) {
            [self moveToPositionAWithAnimation:YES];
        } else {
            [self moveToPositionBWithAnimation:YES];
        }
    }
}

#pragma mark -
#pragma mark TouchEvent

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 現在イベントが発生しているViewを取得
    UIView *nowHitView = [super hitTest:point withEvent:event];
    
    // 自分自身(UIView）ならイベントを無視
    if (self == nowHitView) {
        return nil;
    }
    
    // 自分以外ならイベント発生を許可
    return nowHitView;
}


#pragma mark -
#pragma mark MoveAnimation

- (void)moveToPositionAWithAnimation:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3f
                         animations:^(void){
                             self.frame = posA;
                         }
                         completion:^(BOOL finished) {
                             isCurrentPosA = YES;
                         }];
    } else {
        self.frame = posA;
        isCurrentPosA = YES;
    }
}


- (void)moveToPositionBWithAnimation:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3f
                         animations:^(void){
                             self.frame = posB;
                         }
                         completion:^(BOOL finished) {
                             isCurrentPosA = NO;
                         }];
    } else {
        self.frame = posB;
        isCurrentPosA = NO;
    }
}

@end
