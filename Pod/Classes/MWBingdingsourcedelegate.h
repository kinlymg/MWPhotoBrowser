//
//  MWBingdingsourcedelegate.h
//  passwordmgr
//
//  Created by 龚 镜灵 on 13-4-5.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MWBingdingsourcedelegate <NSObject>
@optional
-(void)bindingsource:(id)target sender:(id) sender data:(id)data;
@end


