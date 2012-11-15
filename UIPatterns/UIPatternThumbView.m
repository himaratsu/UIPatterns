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

@synthesize uiPattern = uiPattern_;
@synthesize imageUrl = imageUrl_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

- (void)setUiPattern:(UIPattern *)uiPattern {
    [self setImageUrl:uiPattern.imageUrl];
    uiPattern_ = uiPattern;
}

- (void)setImageUrl:(NSString *)imageUrl {
    NSURL* url = [NSURL URLWithString:imageUrl];
    NSData* data = [NSData dataWithContentsOfURL:url];
    UIImage* img = [[UIImage alloc] initWithData:data];
    imageView.image = img;
}

#pragma mark -
#pragma mark TouchEvent

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"********************");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"####################");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG(@"####################");
}

@end
