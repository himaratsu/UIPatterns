//
//  CollectionGetAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/18.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CommonAPI.h"

@interface CollectionGetAPI : CommonAPI

@end

@interface CollectionGetAPIParser : NSObject {
    NSMutableDictionary *result;
}

- (id)parse:(NSDictionary*)dic;

@end