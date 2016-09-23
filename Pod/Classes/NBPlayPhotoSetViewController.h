//
//  NBPlayPhotoSetViewController.h
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWKeyValue.h"
#import "MWSwitchCell.h"
#import "MWNumIncreaseCell.h"
#import "MWBingdingsourcedelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NBAnimalPickerViewController.h"
#import "MWmodelviewdelegate.h"
@interface NBPlayPhotoSetViewController : UITableViewController<MWBingdingsourcedelegate,MPMediaPickerControllerDelegate,MWmodelviewdelegate>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,weak)id<MWmodelviewdelegate> modaldelegate;
@property(nonatomic,strong)NSIndexPath *curIndexpath;
@property(nonatomic,strong)UIColor *backgroundcolor;
@end
