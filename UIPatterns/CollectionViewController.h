//
//  CollectionViewController.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/24.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchableUIScrollView.h"
#import "UIPatternThumbView.h"
#import "CollectionNavigationView.h"
#import "CollectionGetContentAPI.h"

@interface CollectionViewController : UIViewController
<TouchableUIScrollDelegate,
CollectionItemHoverDelegate,
CollectionItemViewDelegate,
HttpRequestDelegate
> {
    TouchableUIScrollView *scrollView;
    UIView *highliteBackView;
    UIPatternThumbView *thumbView;
    CollectionNavigationView* ridhtCollectionView;
    
    CGPoint currentLocation, startLocation;
}

@property (nonatomic, strong) NSString* collectionId;

@end
