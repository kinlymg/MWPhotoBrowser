//
//  NBAnimalPickerViewController.m
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import "NBAnimalPickerViewController.h"

@interface NBAnimalPickerViewController ()

@end

@implementation NBAnimalPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TranSMethCell"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
	// Do any additional setup after loading the view.
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    if (_dsTrans==nil) {
        _dsTrans=[[NSMutableArray alloc]init];
    }else{
        [_dsTrans removeAllObjects];
    }
    NSMutableArray *arylst=nil;
    NSMutableDictionary *dic=nil;
    MWKeyValue *curitm=nil;
    dic=[[NSMutableDictionary alloc]init];
    arylst=[[NSMutableArray alloc]init];
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"kCATransitionFade";
    curitm.desc=NSLocalizedString(@"NB_FADE_ANIMATION", @"fade");
    [arylst addObject:curitm];
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"kCATransitionPush";
    curitm.desc=NSLocalizedString(@"NB_PUSH_ANIMATION", @"push");
    [arylst addObject:curitm];

    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"kCATransitionReveal";
    curitm.desc=NSLocalizedString(@"NB_REVEAL_ANIMATION", @"reveal");
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"kCATransitionMoveIn";
    curitm.desc=NSLocalizedString(@"NB_MOVEIN_ANIMATION", @"movein");
    [arylst addObject:curitm];

    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"cube";
    curitm.desc=NSLocalizedString(@"NB_CUBE_ANIMATION", @"cube");
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"suckEffect";
    curitm.desc=NSLocalizedString(@"NB_SUCK_ANIMATION", @"suckEffect");
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"oglFlip";
    curitm.desc=NSLocalizedString(@"NB_FLIP_ANIMATION", @"oglFlip");
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"rippleEffect";
    curitm.desc=NSLocalizedString(@"NB_RIPPLE_ANIMATION", @"rippleEffect");
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"pageCurl";
    curitm.desc=NSLocalizedString(@"NB_PAGEUP_ANIMATION", @"pageCurl");
    [arylst addObject:curitm];
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"pageUnCurl";
    curitm.desc=NSLocalizedString(@"NB_PAGEDWN_ANIMATION", @"pageUnCurl");
    [arylst addObject:curitm];

    [dic setObject:arylst forKey:@"ITEM"];
    [self.dsTrans addObject:dic];
}

-(void)registerBarButton{
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem=left;
}
-(void)back:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView*)genTableHeaderview{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.dsTrans count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary *dic=(NSMutableDictionary*)[self.dsTrans objectAtIndex:section];
    NSMutableArray *ary=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    return [ary count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentified=@"TranSMethCell";
    NSMutableDictionary *dic=(NSMutableDictionary*)[self.dsTrans objectAtIndex:indexPath.section];
    NSMutableArray *ary=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    MWKeyValue *curitm=(MWKeyValue*)[ary objectAtIndex:indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentified];
    [cell.textLabel setText:curitm.desc];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dic=(NSMutableDictionary*)[self.dsTrans objectAtIndex:indexPath.section];
    NSMutableArray *ary=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    MWKeyValue *curitm=(MWKeyValue*)[ary objectAtIndex:indexPath.row];
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    [ds setObject:curitm.code forKey:keyCATransition];
    [ds synchronize];
    if ([_modalDelegate respondsToSelector:@selector(modelview:data:)]) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:curitm,@"kSelectValue",_parentIndexpath,@"kParentIndexpath", nil];
        [_modalDelegate modelview:self data:dic];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
