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

@interface Util : NSObject

+ (void)hideStatusBar;

@end
