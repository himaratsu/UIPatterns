//
//  UIPatternView.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/12.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPatternView : UIView {
    UIImageView* imageView;
    UIActivityIndicatorView* indicatorView;
}

@property (nonatomic, weak) NSString* imageUrl;

@end
