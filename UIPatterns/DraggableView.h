//
//  DraggableView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TsumamiView.h"

#define kMenuBarMoveRange 150

@interface DraggableView : UIView <TsumamiViewTouchActionDelegate> {
    CGPoint startLocation;
    BOOL isTouchesMove;
    CGRect posA, posB;
    BOOL isCurrentPosA;
    
    CGFloat borderHalf, borderLeft, borderRight;
}

- (void)moveToPositionAWithAnimation:(BOOL)animated;
- (void)moveToPositionBWithAnimation:(BOOL)animated;

@end
