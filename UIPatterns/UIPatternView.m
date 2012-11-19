//
//  UIPatternView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/12.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIPatternView.h"

typedef enum LazyImageViewTag_ {
    LazyImageViewTagIndicatorView = 1,
} LazyImageViewTag;

@interface UIPatternView ()

- (void)setLoadingImage;
- (void)setLoadErrorImage;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation UIPatternView

- (id)initWithFrame:(CGRect)frame withUrl:(NSURL *)url {
    self = [super initWithFrame:frame];
    
    if (self) {
        // タッチ可能にする
        self.userInteractionEnabled = YES;
        
        // 影をつける
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
        
        // 画像URLをセット
        [self setImageUrl:url];
    }
    
    return self;
}

- (void)startLoadImage {
    
    if (self.image) return;
    
    if (self.connection) {
        [self.connection cancel];
    }
    
    [self setData:[NSMutableData data]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:self.imageUrl];
    NSURLConnection *con = [NSURLConnection connectionWithRequest:req delegate:self];
    [self setConnection:con];
    
    [self setLoadingImage];
}

- (void)reloadImage {
    [self setImage:nil];
    [self startLoadImage];
}

- (void)cancelLoading {
    [self.connection cancel];
    [self setConnection:nil];
    
    if (self.image == nil) {
        [self setLoadErrorImage];
    }
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self setLoadErrorImage];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:LazyImageViewTagIndicatorView];
    if (iv) [iv removeFromSuperview];
    
    [self setImage:[UIImage imageWithData:self.data]];

}

#pragma mark -

- (void)setLoadingImage {
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:LazyImageViewTagIndicatorView];
    if (iv == nil) {
        iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [iv setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [iv setTag:LazyImageViewTagIndicatorView];
        [self addSubview:iv];
    }
    [iv startAnimating];
    [iv setHidden:NO];
    
    //[self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setLoadErrorImage {
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:LazyImageViewTagIndicatorView];
    [iv removeFromSuperview];
    
    [self setImage:nil];
    //[self setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.4]];
    [self setBackgroundColor:[UIColor redColor]];
}

#pragma mark -

@synthesize imageUrl;
@synthesize connection;
@synthesize data;
@synthesize uiPattern = uiPattern_;
@synthesize delegate = delegate_;

// UIImageViewがタッチされた時のふるまい
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 別スレッドで処理を続行
    [NSThread detachNewThreadSelector:@selector(touchImageView) toTarget:self withObject:nil];
    [super touchesBegan:touches withEvent:event];
}

// タップ
- (void)touchImageView {
    if ([delegate_ respondsToSelector:@selector(UIImageViewSingleTap:)]) {
        [delegate_ UIImageViewSingleTap:self.image];
    }
}


@end
