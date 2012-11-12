//
//  ViewController.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedAPI.h"
#import "UIPattern.h"
#import "UIPatternView.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark -
#pragma mark Initialization

- (void)_initLayout {
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator   = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * NUM_OF_PAGES);
    [self.view addSubview:scrollView];
    
    for (int i=0; i<3; i++) {
        UIPatternView* uiPatternView = [[UIPatternView alloc] initWithFrame:CGRectMake(330*i + 22, 10, 320, 480)];
        [self.view addSubview:uiPatternView];
        
        [uiPatternList addObject:uiPatternView];
    }
}

#pragma mark -
#pragma mark ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    uiPatternList = [NSMutableArray array];
    
    [self _initLayout];

    
    
    FeedAPI* feedAPI = [[FeedAPI alloc] initWithDelegate:self];
    [feedAPI send];
    
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
    return YES;
}

- (UIInterfaceOrientation)interfaceOrientation {
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
    
    for (int i=0; i<3; i++) {
        UIPattern* pattern = [uiPatterns objectAtIndex:i];
        UIPatternView* uiPatternView = [uiPatternList objectAtIndex:i];
        [scrollView addSubview:uiPatternView];
        uiPatternView.imageUrl = pattern.imageUrl;
    }
}

- (void)didErrorHttpRequest:(id)sender {
    NSLog(@"通信エラー");
}

@end
