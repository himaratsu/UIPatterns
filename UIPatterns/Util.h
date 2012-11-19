//
//  Util.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/13.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__)
#define LOG_CURRENT_METHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#define LOG(...) ;
#define LOG_CURRENT_METHOD ;
#endif

#define kDefaultBgColor     [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]
#define kDefaultAccentColor [UIColor colorWithRed:63/255.0 green:169/255.0 blue:245/255.0 alpha:1.0]
#define kDefaultSubColor    [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]

#define kUIPatternImageSizeWidth  320   // UIPattern画像の幅
#define kUIPatternImageSizeHeight 480   // UIPattern画像の高さ
#define kThumbnailSizeWidth  100        // UIPatternサムネイルの幅
#define kThumbnailSizeHeight 150        // UIPatternサムネイルの高さ

#define kPullUpdateViewHeight 50        // 「引っ張って更新」のビューの高さ

#define kMarginLeft 30

#define numberOfUIPatternInRow 3    // 一行に何枚表示するか

#define kUIImageTag 100
#define kCollectionItemTag 101

@interface Util : NSObject

+ (void)hideStatusBar;

@end
