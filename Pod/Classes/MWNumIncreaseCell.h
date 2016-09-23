//
//  NBNumIncreaseCell.h
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWBingdingsourcedelegate.h"
@interface MWNumIncreaseCell : UITableViewCell
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbDesc;
@property(nonatomic,strong)UIStepper *numSteper;
@property(nonatomic,weak)id<MWBingdingsourcedelegate> bindingsource;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
