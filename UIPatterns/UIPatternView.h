//
//  UIPatternView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/12.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPattern.h"

@protocol TapUIImageViewDelegate;

@interface UIPatternView : UIImageView {
    BOOL longPressBegan;
}

- (id)initWithFrame:(CGRect)frame withUrl:(NSURL *)url;
- (void)startLoadImage;
- (void)reloadImage;
- (void)cancelLoading;

@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) UIPattern* uiPattern;
@property (nonatomic, weak) id<TapUIImageViewDelegate> delegate;

@end

@protocol TapUIImageViewDelegate <NSObject>

- (void)UIImageViewSingleTap:(UIImage*)image;   // タップ
- (void)UIImageViewLongTap:(UIImage*)image;     // 長押しタップ

@end