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


@end
