//
//  UIPatternView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/12.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPattern.h"

@protocol ActionImageViewDelegate;

@interface LazyImageView : UIImageView {
    BOOL isPress;
}

- (id)initWithFrame:(CGRect)frame withUrl:(NSURL *)url;

- (void)startLoadImage;
- (void)reloadImage;
- (void)cancelLoading;

@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) UIPattern* uiPattern;
@property (nonatomic, weak) id<ActionImageViewDelegate> delegate;

@end

@protocol ActionImageViewDelegate <NSObject>

- (void)tapShortImageView:(UIPattern*)uiPattern gesture:(id)gesture;    // タップ
- (void)tapLongImageView:(UIPattern*)uiPattern gesture:(id)gesture;     // 長押しタップ

@end