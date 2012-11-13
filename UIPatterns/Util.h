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

@interface Util : NSObject

+ (void)hideStatusBar;

@end
