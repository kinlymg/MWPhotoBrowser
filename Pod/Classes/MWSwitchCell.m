//
//  NBSwitchCell.m
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-25.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import "MWSwitchCell.h"

@implementation MWSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect screenframe = [ UIScreen mainScreen ].applicationFrame;
        CGRect frame=CGRectMake(20,self.frame.size.height/2-30/2, 200,30);
        _lbTitle=[[UILabel alloc]initWithFrame:frame];
        [_lbTitle setBackgroundColor:[UIColor clearColor]];
        [_lbTitle setTextAlignment:NSTextAlignmentLeft];
        [_lbTitle setFont:[UIFont systemFontOfSize:17]];
        _sWitch=[[UISwitch alloc]initWithFrame:CGRectMake(screenframe.size.width-60-20,self.frame.size.height/2-30/2, 60, 30)];
        [_sWitch addTarget:self action:@selector(switch_valueChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_lbTitle];
        [self.contentView addSubview:_sWitch];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)switch_valueChange:(UISwitch*)sender{
    if ([_bindingsource respondsToSelector:@selector(bindingsource:sender:data:)]) {
        [_bindingsource bindingsource:self sender:sender data:self.indexpath];
    }
}
@end
