//
//  CollectionAddItemAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/26.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CommonAPI.h"

@interface CollectionAddItemAPI : CommonAPI

@end

@interface CollectionAddItemAPIParser : NSObject

- (id)parse:(NSDictionary*)dic;

@end