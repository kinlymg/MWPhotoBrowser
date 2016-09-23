//
//  NBSwitchCell.h
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-25.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWBingdingsourcedelegate.h"
@interface MWSwitchCell : UITableViewCell
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UISwitch *sWitch;
@property(nonatomic,strong)NSIndexPath *indexpath;
@property(nonatomic,weak)id<MWBingdingsourcedelegate>bindingsource;
@end
