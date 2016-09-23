//
//  NBAnimalPickerViewController.h
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWmodelviewdelegate.h"
#import "MWKeyValue.h"
@interface NBAnimalPickerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dsTrans;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,weak)id<MWmodelviewdelegate> modalDelegate;
@property(nonatomic,strong)NSIndexPath*parentIndexpath;
@property(nonatomic,strong)UIColor *backgroundcolor;

@end
