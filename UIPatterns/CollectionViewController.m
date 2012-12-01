//
//  CollectionViewController.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/24.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
@synthesize collectionId = collectionId_;

#pragma mark ViewLifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initLayout];
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Initialization

- (void)_initLayout {
    // 全体のスクロールビュー
    scrollView = [[TouchableUIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = kDefaultBgColor;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator   = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
    scrollView.myDelegate = self;   // TouchableUIScrollViewのデリゲート
    [self.view addSubview:scrollView];
    
    // 画面上部の青色ライン
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2048, 15)];
    headerView.backgroundColor = kDefaultAccentColor;
    headerView.layer.shadowOpacity = 0.2;
    headerView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    [scrollView addSubview:headerView];
    
    // タイトル
    UILabel* topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 500, 100)];
    topTitleLabel.text = @"Collections";
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
    
    // カテゴリtmp
    UIButton *tmp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tmp.frame = CGRectMake(550, 53, 100, 35);
    [tmp setTitle:@"Search" forState:UIControlStateNormal];
    [tmp addTarget:self action:@selector(tapSettings) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:tmp];
    
    // 画像ドラッグ時の背景ビュー
    highliteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768*3)];
    highliteBackView.backgroundColor = [UIColor blackColor];
    highliteBackView.alpha = 0.2;
    highliteBackView.hidden = YES;
    [scrollView addSubview:highliteBackView];
    
    // ドラッグ時に表示するサムネイルビュー
    thumbView = [[UIPatternThumbView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.view addSubview:thumbView];
    
    // 右側のコレクションビュー
    ridhtCollectionView = [[CollectionNavigationView alloc]
                           initWithFrame:CGRectMake(1024-195, 50, 200, 700)];
    [ridhtCollectionView moveToPositionBWithAnimation:NO];  // 最初は隠す
    ridhtCollectionView.delegate = self;
    [self.view addSubview:ridhtCollectionView];


}

- (void)reload {
    collectionId_ = @"1111111111";
    
    CollectionGetContentAPI *collectionGetContentAPI
    = [[CollectionGetContentAPI alloc] initWithDelegate:self];
    [collectionGetContentAPI sendWithCollectionId:collectionId_];
}

#pragma mark -
#pragma mark TouchableUIScrollDelegate Method

- (void)scrollViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    currentLocation = startLocation = point;
    
    // サムネイル画像がセットされているかどうかで、領域内外を判断する
    if (thumbView.image != nil) {
        [self appearThumbViewWithAnimation:currentLocation];
    }
}

- (void)scrollViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    CGRect frame = [thumbView frame];
    frame.origin.x += pt.x - currentLocation.x;
    frame.origin.y += pt.y - currentLocation.y;
    [thumbView setFrame:frame];
    
    currentLocation = CGPointMake(frame.origin.x + frame.size.width/2,
                                  frame.origin.y + frame.size.height/2);
    
    // rightCollectionView上にのりかかった場合
    if (pt.x > 1024 - ridhtCollectionView.frame.size.width + kTsumamiSizeWidth) {
        [self scaleChangeThumbViewWithScale:0.6];
        [ridhtCollectionView scrollTouchMoved:touches];
    } else {
        [self scaleChangeThumbViewWithScale:1.0];
    }
}

- (void)scrollViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    if (pt.x > 1024 - ridhtCollectionView.frame.size.width + kTsumamiSizeWidth) {
        [ridhtCollectionView scrollTouchEnded:touches];
    } else {
        [self disappearThumbViewWithAnimation];
    }
}

- (void)scrollViewTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self disappearThumbViewWithAnimation];
}


#pragma mark -
#pragma mark CollectionItemHoverDelegate Method

- (void)collectionItemHoverRelease:(NSSet*)touches diffX:(CGFloat)x diffY:(CGFloat)y {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point.x += x;
    point.y += y;
    [self disappearThumbViewOnCollectionWithAnimation:point];
}

- (void)collectionItemNoHoverRelease {
    [self disappearThumbViewWithAnimation];
}


#pragma mark -
#pragma mark CollectionItemViewDelegate Method

- (void)collectionItemViewTap:(NSString*)sender {
    if ([sender isEqualToString:@"CollectionItemView"]) {
        CollectionViewController* colViewController = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
        // TODO: ここでコレクションidをセットする
        [self.navigationController pushViewController:colViewController animated:NO];
    }
    else if ([sender isEqualToString:@"CollectionItemAddView"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:@"add" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark HttpRequestDelegate Method

- (void)didStartHttpResuest:(id)result type:(NSString *)type {
    NSLog(@"つうしんかいし");
}

- (void)didEndHttpResuest:(id)result type:(NSString *)type {
   // TODO: ここでコレクションを配置
}

- (void)didErrorHttpRequest:(id)result type:(NSString *)type {
    NSLog(@"通信エラー");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                    message:@"エラーが発生しました。\nネットワーク環境のあるところで再読み込みして下さい。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
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
                         thumbView.image = nil;
                     }];
}

- (void)disappearThumbViewOnCollectionWithAnimation:(CGPoint)pt {
    [UIView animateWithDuration:0.4f
                     animations:^(void){
                         thumbView.frame = CGRectMake(pt.x - (kThumbnailSizeWidth*0.6)/2,
                                                      pt.y - (kThumbnailSizeHeight*0.6)/2,
                                                      kThumbnailSizeWidth*0.6,
                                                      kThumbnailSizeHeight*0.6);
                         thumbView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         thumbView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         thumbView.hidden = YES;
                         highliteBackView.hidden = YES;
                         thumbView.alpha = 1.0;
                         thumbView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         thumbView.image = nil;
                     }];
}

- (void)scaleChangeThumbViewWithScale:(CGFloat)scale {
    [UIView animateWithDuration:0.2f
                     animations:^(void){
                         thumbView.transform = CGAffineTransformMakeScale(scale, scale);
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark -

- (void)tapSettings {
    // カテゴリをセット
//    param = [NSMutableDictionary dictionary];
//    [param setObject:@"search" forKey:@"category"];
    
    // 再読み込み
    [self reload];
}

@end
