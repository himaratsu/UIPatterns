//
//  FeedAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/09.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonAPI.h"

@interface FeedAPI : CommonAPI

@end

@interface FeedAPIParser : NSObject {
    NSMutableDictionary* result;
}

- (id)parse:(NSDictionary*)dic;

@end