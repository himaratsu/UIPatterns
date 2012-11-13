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
#import "LazyImageView.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark -
#pragma mark Initialization

- (void)_initLayout {
    // 全体のスクロールビュー
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = kDefaultBgColor;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator   = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * NUM_OF_PAGES);
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

}

- (void)reload {
    [self _initLayout];
    FeedAPI* feedAPI = [[FeedAPI alloc] initWithDelegate:self];
    [feedAPI send];
}

#pragma mark -
#pragma mark ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * NUM_OF_PAGES);
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
    
    NSArray* uiPatterns = [result objectForKey:@"uipatterns"];
    
    for (int i=0; i<9; i++) {
        int x = i % 3;
        int y = i / 3;
        
        UIPattern* pattern = [uiPatterns objectAtIndex:i];
        NSLog(@"imageUrl = %@", pattern.imageUrl);
        LazyImageView* lazyImageView = [[LazyImageView alloc]
                                        initWithFrame:CGRectMake(330*x + 30, 490*y + 120, 300, 450)
                                        withUrl:[NSURL URLWithString:pattern.imageUrl]];
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

- (void)touchesBeganWithUIPattern:(UIPattern *)uiPattern touches:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"uiPattern = %@", uiPattern.title);
}

- (void)touchesMovedWithUIPattern:(UIPattern *)uiPattern touches:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"uiPattern = %@", uiPattern.title);
}

- (void)touchesEndWithUIPattern:(UIPattern *)uiPattern touches:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"uiPattern = %@", uiPattern.title);
}

@end
