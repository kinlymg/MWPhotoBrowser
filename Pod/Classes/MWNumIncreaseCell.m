//
//  NBNumIncreaseCell.m
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import "MWNumIncreaseCell.h"

@implementation MWNumIncreaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect screenframe = [ UIScreen mainScreen ].applicationFrame;

        _lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, 3, 150,22)];
        [_lbTitle setBackgroundColor:[UIColor clearColor]];
        [_lbTitle setTextAlignment:NSTextAlignmentLeft];
        [_lbTitle setFont:[UIFont boldSystemFontOfSize:17]];
        _lbDesc=[[UILabel alloc]initWithFrame:CGRectMake(20, 25,100, 22)];
        [_lbDesc setBackgroundColor:[UIColor clearColor]];
        
        _numSteper=[[UIStepper alloc]initWithFrame:CGRectMake(screenframe.size.width-94-20, self.frame.size.height/2-29/2, 94,29)];
        [_numSteper addTarget:self action:@selector(numstepper_click:) forControlEvents:UIControlEventValueChanged];
         _numSteper.minimumValue=2; //设置最小值
         _numSteper.maximumValue = 10; //设置最大值
         _numSteper.stepValue =1; //每次递增2
         [_numSteper setWraps:YES]; //是否循环forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_lbTitle];
        [self.contentView addSubview:_lbDesc];
        [self.contentView addSubview:_numSteper];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)numstepper_click:(UIStepper *)sender{
    if ([_bindingsource respondsToSelector:@selector(bindingsource:sender:data:)]){
        [_bindingsource bindingsource:self sender:sender data:_indexPath];
    }
}
@end
