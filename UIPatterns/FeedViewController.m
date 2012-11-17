//
//  ViewController.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FeedViewController.h"
#import "FeedAPI.h"
#import "UIPattern.h"


@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark -
#pragma mark Initialization

- (void)_initLayout {
    // 全体のスクロールビュー
    scrollView = [[TouchableUIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = kDefaultBgColor;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator   = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 画面上部の青色ライン
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2048, 15)];
    headerView.backgroundColor = kDefaultAccentColor;
    headerView.layer.shadowOpacity = 0.2;
    headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    [scrollView addSubview:headerView];
    
    // タイトル
    UILabel* topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 500, 100)];
    topTitleLabel.text = @"UI Patterns";
    topTitleLabel.font = [UIFont fontWithName:@"American Typewriter" size:56];
    topTitleLabel.textColor = kDefaultAccentColor;
    topTitleLabel.backgroundColor = [UIColor clearColor];
    topTitleLabel.layer.shadowOpacity = 0.1;
    topTitleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    [scrollView addSubview:topTitleLabel];
    
    // 検索虫眼鏡アイコン
    UIImage* searchIcon = [UIImage imageNamed:@"search_icon.png"];
    UIImageView* searchIconView = [[UIImageView alloc] initWithFrame:CGRectMake(690, 53, 35, 35)];
    searchIconView.image = searchIcon;
    searchIconView.alpha = 0.5;
    [scrollView addSubview:searchIconView];
    
    // 検索窓
    UITextField* searchField = [[UITextField alloc] initWithFrame:CGRectMake(740, 50, 250, 40)];
    searchField.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0];
    searchField.clipsToBounds = YES;
    searchField.layer.cornerRadius = 5.0f;
    searchField.layer.borderWidth = 1.0f;
    searchField.layer.borderColor = [UIColor colorWithRed:179/256.0 green:179/256.0 blue:179/256.0 alpha:1.0].CGColor;
    searchField.font = [UIFont fontWithName:@"Verdana" size:26.0f];
    searchField.textColor = [UIColor grayColor];
    [scrollView addSubview:searchField];
    
    // 画像ドラッグ時の背景ビュー
    highliteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768*3)];
    highliteBackView.backgroundColor = [UIColor blackColor];
    highliteBackView.alpha = 0.2;
    highliteBackView.hidden = YES;
    [scrollView addSubview:highliteBackView];
    
    // ドラッグ時要のサムネイルビュー
    thumbView = [[UIPatternThumbView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.view addSubview:thumbView];
    
    // 右側のコレクションビュー
    ridhtCollectionView = [[DraggableView alloc]
                                          initWithFrame:CGRectMake(1024-195, 50, 200, 700)];
    [ridhtCollectionView moveToPositionBWithAnimation:NO];  // 最初は隠す
    [self.view addSubview:ridhtCollectionView];
    
    
    // temp更新ボタン
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"更新" forState:UIControlStateNormal];
    btn.frame = CGRectMake(650, 53, 35, 35);
    [btn addTarget:self action:@selector(reloadButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
}

- (void)resetUIPatternLayout {
    for (UIView* v in [scrollView subviews]) {
        if (v.tag == kUIImageTag) {
            [v removeFromSuperview];
        }
    }
}

// UIPattern画像を再読み込み
- (void)reload {
    [self resetUIPatternLayout];
    FeedAPI* feedAPI = [[FeedAPI alloc] initWithDelegate:self];
    [feedAPI send];
}

#pragma mark -
#pragma mark ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initLayout];
    [self reload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark Rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    //画面の左側にホームボタン
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark -
#pragma mark HttpRequestDelegate 

- (void)didStartHttpResuest:(id)sender {
    NSLog(@"通信スタート");
}

- (void)didEndHttpResuest:(id)sender {
    NSLog(@"通信成功");
    NSDictionary* result = (NSDictionary*)sender;
    
    int total = [[result objectForKey:@"totalCount"] intValue];
    
    // 描画領域を確保
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,
                                        120+kUIPatternImageSizeHeight*(total/numberOfUIPatternInRow)
                                        );
    
    NSArray* uiPatterns = [result objectForKey:@"uipatterns"];
    for (int i=0; i<total; i++) {
        int x = i % numberOfUIPatternInRow;
        int y = i / numberOfUIPatternInRow;
        
        UIPattern* pattern = [uiPatterns objectAtIndex:i];
        LazyImageView* lazyImageView = [[LazyImageView alloc]
                                        initWithFrame:CGRectMake((kUIPatternImageSizeWidth+10)*x + kMarginLeft,
                                                                 (kUIPatternImageSizeHeight+10)*y + 120,
                                                                 kUIPatternImageSizeWidth - 20,
                                                                 kUIPatternImageSizeHeight - 30)
                                        withUrl:[NSURL URLWithString:pattern.imageUrl]];
        lazyImageView.tag = kUIImageTag;
        lazyImageView.delegate = self;
        lazyImageView.uiPattern = pattern;
        [lazyImageView startLoadImage];
        [scrollView addSubview:lazyImageView];
    }
    
    // D&D時の背景ビューを、前面に持ってきておく
    [scrollView bringSubviewToFront:highliteBackView];
}

- (void)didErrorHttpRequest:(id)sender {
    NSLog(@"通信エラー");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                    message:@"エラーが発生しました。\nネットワーク環境のあるところで再読み込みして下さい。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark -
#pragma mark TouchableUIScrollDelegate

- (void)scrollViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_CURRENT_METHOD;

    
    CGPoint point = [[touches anyObject] locationInView:self.view];
//    currentLocation = point;
    currentLocation = startLocation = point;
    [self appearThumbViewWithAnimation:currentLocation];
}

- (void)scrollViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_CURRENT_METHOD;
    
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    CGRect frame = [thumbView frame];
    frame.origin.x += pt.x - currentLocation.x;
    frame.origin.y += pt.y - currentLocation.y;
    [thumbView setFrame:frame];
    
    currentLocation = CGPointMake(frame.origin.x + frame.size.width/2,
                                frame.origin.y + frame.size.height/2);
}

- (void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    LOG_CURRENT_METHOD;
    [self disappearThumbViewWithAnimation];

}


#pragma mark -
#pragma mark ActionImageViewDelegate

// 通常タップ
- (void)UIImageViewSingleTap:(UIImage *)image {
    thumbView.image = image;
}

#pragma mark -
#pragma mark Animation

- (void)appearThumbViewWithAnimation:(CGPoint)point {
    thumbView.frame = CGRectMake(point.x - (kThumbnailSizeWidth+10)/2,
                                 point.y - (kThumbnailSizeHeight+10)/2,
                                 kThumbnailSizeWidth + 10,
                                 kThumbnailSizeHeight + 10);
    thumbView.hidden = NO;
    highliteBackView.hidden = NO; // 背景を少し暗くする
    [self.view bringSubviewToFront:thumbView];
    
    thumbView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3f
                     animations:^(void){
                             thumbView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                         [ridhtCollectionView moveToPositionAWithAnimation:YES];
                     }];
}

- (void)disappearThumbViewWithAnimation {
    [UIView animateWithDuration:0.3f
                     animations:^(void){
                         thumbView.frame = CGRectMake(startLocation.x - (kThumbnailSizeWidth+10)/2,
                                                      startLocation.y - (kThumbnailSizeHeight+10)/2,
                                                      kThumbnailSizeWidth + 10,
                                                      kThumbnailSizeHeight + 10);
                         thumbView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }
                     completion:^(BOOL finished) {
                         [ridhtCollectionView moveToPositionBWithAnimation:YES];
                         thumbView.hidden = YES;
                         highliteBackView.hidden = YES;
                         thumbView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }];
}

#pragma mark -
#pragma mark UserAction

- (void)reloadButtonTouchUpInside:(id)sender {
    [self reload];
}

@end
