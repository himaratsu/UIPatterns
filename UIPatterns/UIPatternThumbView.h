//
//  UIPatternThumbView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPattern.h"

@interface UIPatternThumbView : UIView {
    UIImageView* imageView;
}

@property (nonatomic, weak) UIImage* image; // サムネイル画像

@end
