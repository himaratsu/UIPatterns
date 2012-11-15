//
//  TsumamiView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TsumamiViewTouchActionDelegate;

@interface TsumamiView : UIView {
    CGPoint startLocation;
}

@property (nonatomic, weak) id<TsumamiViewTouchActionDelegate> delegate;

@end

@protocol TsumamiViewTouchActionDelegate <NSObject>
- (void)touchesBeganTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMovedTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEndedTsumamiView:(NSSet *)touches withEvent:(UIEvent *)event;
@end