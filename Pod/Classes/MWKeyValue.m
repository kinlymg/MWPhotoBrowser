//
//  NBKeyValue.m
//  photoMgr
//
//  Created by 龚 镜灵 on 13-5-25.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import "MWKeyValue.h"

@implementation MWKeyValue
- (id)init
{
    self = [super init];
    if (self) {
        self.code=[[NSString alloc]init];
        self.desc=[[NSString alloc]init];
    }
    return self;
}
@end
