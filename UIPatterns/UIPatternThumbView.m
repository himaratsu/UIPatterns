//
//  UIPatternThumbView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/14.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIPatternThumbView.h"


@implementation UIPatternThumbView

@synthesize uipatternId = uipatternId_;
@synthesize image = image_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景色
        self.backgroundColor = [UIColor whiteColor];
        
        // 影落とす
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        
        // 最初は非表示
        self.hidden = YES;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kThumbnailSizeWidth, kThumbnailSizeHeight)];
        imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage*)image{
    image_ = image;
    imageView.image = image;
}

@end
