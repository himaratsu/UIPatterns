//
//  CollectionListView.m
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/18.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CollectionItemListView.h"
#import "CollectionItemView.h"

@implementation CollectionItemListView
@synthesize delegate = delegate_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, frame.size.width, frame.size.height-140)];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
        [self addSubview:scrollView];
        
        // コレクション情報を取得
        [self reload];
    }
    return self;
}

- (void)reload {
    CollectionGetAPI *collectionGetApi = [[CollectionGetAPI alloc] initWithDelegate:self];
    [collectionGetApi send];
}


#pragma mark -
#pragma mark HttpRequestDelegate Method

- (void)didStartHttpResuest:(id)sender {
    
}

- (void)didEndHttpResuest:(id)sender {
    NSDictionary *result = (NSDictionary*)sender;
    
    int total = [[result objectForKey:@"totalCount"] intValue];
    
    // コレクションアイテムを配置する
    NSArray* collections = [result objectForKey:@"collections"];
    for (int i=0; i<total; i++) {
        CollectionItem* colItem = [collections objectAtIndex:i];
        CollectionItemView* colItemView = [[CollectionItemView alloc]
                                        initWithFrame:CGRectMake(20,
                                                                 20 + 150*i,
                                                                 100,
                                                                 140)];
        colItemView.tag = kCollectionItemTag;
        colItemView.collectionItem = colItem;
        [scrollView addSubview:colItemView];
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 40+150*total);
}

- (void)didErrorHttpRequest:(id)sender {
    
}


#pragma mark -
#pragma mark checkColision

- (void)scrollTouchMoved:(NSSet*)touches {
    LOG_CURRENT_METHOD;
    CGPoint pt = [[touches anyObject] locationInView:scrollView];
    LOG(@"%f, %f", pt.x, pt.y);
    
    // ナビゲーションバー上ではサムネイルは0.6倍のサイズとなっている
    CGRect touchFrame = CGRectMake(pt.x-kThumbnailSizeWidth*0.6/2,
                                   pt.y-kThumbnailSizeHeight*0.6/2,
                                   kThumbnailSizeWidth*0.6,
                                   kThumbnailSizeHeight*0.6);
    
    for (UIView *v in [scrollView subviews]) {
        CollectionItemView *colItemView = (CollectionItemView*)v;
        if (CGRectContainsPoint(v.frame, pt)) {
            // 衝突！
            LOG(@"衝突 → %@", colItemView.collectionItem.title);
            [colItemView setHighlighted:YES];
        } else {
            [colItemView setHighlighted:NO];
        }
    }
    
}

- (void)scrollTouchEnded:(NSSet*)touches {
    LOG_CURRENT_METHOD;
    CGPoint pt = [[touches anyObject] locationInView:scrollView];
    LOG(@"%f, %f", pt.x, pt.y);
    
    for (UIView *v in [scrollView subviews]) {
        CollectionItemView *colItemView = (CollectionItemView*)v;
        if (CGRectContainsPoint(v.frame, pt)) {
            // ホバー中のコレクションの中心に向けてAction
            CGFloat diff_x = colItemView.center.x - pt.x;
            CGFloat diff_y = colItemView.center.y - pt.y;
            [delegate_ collectionItemHoverRelease:touches diffX:diff_x diffY:diff_y];
            [colItemView setHighlighted:NO];
            break;
        }
    }

}


@end
