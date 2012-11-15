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
#import "DraggableView.h"


@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark -
#pragma mark Initialization

- (void)_initLayout {
    // 全体のスクロールビュー
    LOG(@"%f, %f", self.view.bounds.size.width, self.view.bounds.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    LOG(@"%f, %f", scrollView.bounds.size.width, scrollView.bounds.size.height);
    scrollView.backgroundColor = kDefaultBgColor;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator   = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
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
    highliteBackView = [[UIView alloc] initWithFrame:self.view.frame];
    highliteBackView.backgroundColor = [UIColor whiteColor];
    highliteBackView.alpha = 0.4;
    highliteBackView.hidden = YES;
    [self.view addSubview:highliteBackView];
    
    // ドラッグ時要のサムネイルビュー
    thumbView = [[UIPatternThumbView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [scrollView addSubview:thumbView];
    
    // 右側のコレクションビュー
    DraggableView* ridhtCollectionView = [[DraggableView alloc]
                                          initWithFrame:CGRectMake(1024-200, 50, 200, 700)];
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
}

- (void)didErrorHttpRequest:(id)sender {
    NSLog(@"通信エラー");
}

#pragma mark -
#pragma mark ActionImageViewDelegate

//// 通常タップ
//- (void)tapShortImageView:(UIPattern *)uiPattern gesture:(id)gesture {
//    LOG_CURRENT_METHOD;
//
//}
//
//// 長押しタップ
//- (void)tapLongImageView:(UIPattern *)uiPattern gesture:(id)gesture {
//    LOG_CURRENT_METHOD;
//    UILongPressGestureRecognizer* tapGesture = (UILongPressGestureRecognizer*)gesture;
//    CGPoint point = [tapGesture locationInView:scrollView];
//    LOG(@"%f, %f", point.x, point.y);
//    
//    thumbView.uiPattern = uiPattern;
//    thumbView.frame = CGRectMake(point.x - (kThumbnailSizeWidth+10)/2,
//                                 point.y - (kThumbnailSizeHeight+10)/2,
//                                 kThumbnailSizeWidth + 10,
//                                 kThumbnailSizeHeight + 10);
//    thumbView.hidden = NO;
//    [scrollView bringSubviewToFront:thumbView];
//    
//    // タッチイベント呼ぶ
//    [self touchesBegan:nil withEvent:nil];
//    [self setDragAndDropMode:YES];
//}


//#pragma mark -
//#pragma mark TouchEvent
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    LOG(@"touchesBegan");
//    startLocation = thumbView.frame.origin;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    LOG(@"touchesMoved");
//    CGPoint pt = [[touches anyObject] locationInView:scrollView];
//    LOG(@"start = %f, current = %f", startLocation.x, pt.x);
//    CGRect frame = [thumbView frame];
//    frame.origin.x += pt.x - startLocation.x;
//    frame.origin.y += pt.y - startLocation.y;
//    [thumbView setFrame:frame];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    LOG(@"touchesEnded");
//    thumbView.hidden = YES;
//    [self setDragAndDropMode:NO];
//}
//
//
//// D&D中はYES
//- (void)setDragAndDropMode:(BOOL)mode {
//    scrollView.delaysContentTouches = !mode;
//    scrollView.userInteractionEnabled = !mode;
//    highliteBackView.hidden = !mode;
//}

- (void)reloadButtonTouchUpInside:(id)sender {
    [self reload];
}

@end
