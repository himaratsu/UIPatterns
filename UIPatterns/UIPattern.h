//
//  UIPattern.h
//  UIPatterns
//
//  Created by 平松 亮介 on 2012/11/10.
//  Copyright (c) 2012年 mashroom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPattern : NSObject {
    NSString* id_;
    NSString* title_;
    NSArray*  type_;
    NSString* imageUrl_;
    NSString* appStoreUrl_;
    NSString* googlePlayUrl_;
}

@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSArray*  type;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* appStoreUrl;
@property (nonatomic, strong) NSString* googlePlayUrl;


@end
