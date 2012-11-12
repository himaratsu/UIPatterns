//
//  UIPatternView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/12.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "UIPatternView.h"

@implementation UIPatternView
@synthesize imageUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.backgroundColor = [UIColor blueColor];
        [self addSubview:imageView];
        
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.frame = CGRectMake(0, 0, 30, 30);
        indicatorView.center = imageView.center;
        [self addSubview:indicatorView];
        
        [indicatorView startAnimating];
    }
    return self;
}

- (void)setImageUrl:(NSString *)_imageUrl {
    NSData *dt = [NSData dataWithContentsOfURL:
                  [NSURL URLWithString:_imageUrl]];
    UIImage *image = [[UIImage alloc] initWithData:dt];
    imageView.image = image;
    [indicatorView stopAnimating];
}

@end
