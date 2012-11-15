//
//  TouchableUIScrollView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/15.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchableUIScrollDelegate;

@interface TouchableUIScrollView : UIScrollView

@property (weak) id<TouchableUIScrollDelegate> delegate;
@end

@protocol TouchableUIScrollDelegate <NSObject>
- (void)scrollViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)scrollViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
