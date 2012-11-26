//
//  CollectionGetContentAPI.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/24.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import "CommonAPI.h"

@interface CollectionGetContentAPI : CommonAPI

- (void)sendWithCollectionId:(NSString *)collectionId;

@end

@interface CollectionGetContentAPIParser : NSObject {
    NSMutableDictionary* result;
}

- (id)parse:(NSDictionary*)dic;

@end