//
//  NBPlayPhotoSetViewController.m
//  photoMgr
//
//  Created by 龚 镜灵 on 13-7-30.
//  Copyright (c) 2013年 NB. All rights reserved.
//

#import "NBPlayPhotoSetViewController.h"

@interface NBPlayPhotoSetViewController ()

@end

@implementation NBPlayPhotoSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[MWSwitchCell class] forCellReuseIdentifier:@"MWSwitchCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ANNIMALCTRLCELL"];
    [self.tableView registerClass:[MWNumIncreaseCell class] forCellReuseIdentifier:@"MWNumIncreaseCell"];
	// Do any additional setup after loading the view.
    [self initData];
    [self.tableView reloadData];
    [self registerBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    if(_dataSource==nil){
        _dataSource=[[NSMutableArray alloc]init];
    }else{
        [_dataSource removeAllObjects];
        
    }
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic=nil;
    NSMutableArray *arylst=nil;
    arylst=[[NSMutableArray alloc]init];
    dic=[[NSMutableDictionary alloc]init];
    MWKeyValue *curitm=nil;
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"KPLAYTY";
    curitm.desc=[ds stringForKey:keyCATransition];
    [arylst addObject:curitm];
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"KINTERVAL";
    curitm.desc=[NSString stringWithFormat:@"%ld",(long)[ds integerForKey:@"KINTERVAL"]];
    [arylst addObject:curitm];
    
    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"KMUSIC";
    curitm.desc=[ds stringForKey:@"KMUSIC"];
    [arylst addObject:curitm];
    

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"KPLAYMUSIC";
    curitm.desc=[ds stringForKey:@"KPLAYMUSIC"];
    [arylst addObject:curitm];

    curitm=[[MWKeyValue alloc]init];
    curitm.code=@"KREPEAT";
    curitm.desc=[ds stringForKey:@"KREPEAT"];

    [arylst addObject:curitm];
    
    [dic setObject:arylst forKey:@"ITEM"];
    [self.dataSource addObject:dic];
    
}
-(void)registerBarButton{
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"NB_BACK_LABEL",@"back") style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem=left;
    
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"NB_PLAY_LABEL",@"play") style:UIBarButtonItemStyleDone target:self action:@selector(play:)];
    self.navigationItem.rightBarButtonItem=right;
}


-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)play:(id)sender{
    if ([_modaldelegate respondsToSelector:@selector(modelview:data:)]) {
        [_modaldelegate modelview:self data:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataSource count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary *dic=(NSMutableDictionary*)[_dataSource objectAtIndex:section];
    NSMutableArray *arylst=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    return [arylst count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary*dic=(NSMutableDictionary*)[_dataSource objectAtIndex:indexPath.section];
    NSMutableArray *arylst=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    MWKeyValue *curitm=(MWKeyValue*)[arylst objectAtIndex:indexPath.row];
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    if ([curitm.code isEqualToString:@"KINTERVAL"]) {
        MWNumIncreaseCell *cell=(MWNumIncreaseCell*)[tableView dequeueReusableCellWithIdentifier:@"MWNumIncreaseCell"];
        NSInteger seconds=[ds integerForKey:@"KINTERVAL"];

        [cell.lbTitle setText:NSLocalizedString(@"NB_TIMEINTERVAL_LABEL",@"Time Interval")];
        [cell.lbDesc setText:[NSString stringWithFormat:@"%ld %@",(long)seconds,NSLocalizedString(@"NB_SECONDS_LABEL", @"seconds")]];
        cell.bindingsource=self;
        cell.indexPath=indexPath;
        cell.numSteper.value=seconds;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([curitm.code isEqualToString:@"KREPEAT"]||[curitm.code isEqualToString:@"KPLAYMUSIC"]){
        MWSwitchCell *cell=(MWSwitchCell*)[tableView dequeueReusableCellWithIdentifier:@"MWSwitchCell"];
        cell.bindingsource=self;
        cell.indexpath=indexPath;
        if ([curitm.code isEqualToString:@"KREPEAT"]) {
            NSString *strRepeat=[ds objectForKey:@"KREPEAT"];
            [cell.lbTitle setText:NSLocalizedString(@"NB_REPEAT_LABEL",@"repeat")];
            if ([strRepeat isEqualToString:@"REPEATON"]&&strRepeat!=nil) {
                cell.sWitch.on=YES;
            }else{
                cell.sWitch.on=NO;
            }
        }else{
            NSString *strMusic=[ds objectForKey:@"KPLAYMUSIC"];
            [cell.lbTitle setText:NSLocalizedString(@"NB_BACKGROUND_MUSIC_LABEL", @"背景音乐")];
            if ([strMusic isEqualToString:@"MUSICON"]) {
                cell.sWitch.on=YES;
            }else{
                cell.sWitch.on=NO;
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *cellIdentified=@"ANNIMALCTRLCELL";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentified];
        if ([curitm.code isEqualToString:@"KPLAYTY"]) {
            [cell.textLabel setText:NSLocalizedString(@"NB_TRANSANIMATION_TYPE_LABEL", @"过渡")];
            NSString *transNm=[self returnTransModeName:[ds objectForKey:keyCATransition]];
            [cell.detailTextLabel setText:transNm];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            [cell.textLabel setText:NSLocalizedString(@"NB_MUSIC_LABEL",@"Music")];
            NSString *musicName=[ds stringForKey:@"kAudioTitle"];
            [cell.detailTextLabel setText:musicName];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.curIndexpath=indexPath;
    NSMutableDictionary*dic=(NSMutableDictionary*)[_dataSource objectAtIndex:indexPath.section];
    NSMutableArray *arylst=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    MWKeyValue *curitm=(MWKeyValue*)[arylst objectAtIndex:indexPath.row];
    if ([curitm.code isEqualToString:@"KMUSIC"]) {
        [self showMediaPicker];
    }else if ([curitm.code isEqualToString:@"KPLAYTY"]){
        [self showTransType:indexPath];
    }
    
}

//-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableDictionary*dic=(NSMutableDictionary*)[_dataSource objectAtIndex:indexPath.section];
//    NSMutableArray *arylst=(NSMutableArray*)[dic objectForKey:@"ITEM"];
//    MWKeyValue *curitm=(MWKeyValue*)[arylst objectAtIndex:indexPath.row];
//    if ([curitm.code isEqualToString:@"KINTERVAL"]) {
//        return 50;
//    }else{
//        return 44;
//    }
//
//}
-(void)showMediaPicker{
    MPMediaPickerController * mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    if(mediaPicker != nil)
    {
        NSLog(@"Successfully instantiated a media picker");
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = NO;
        [self presentViewController:mediaPicker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Could not instantiate a media picker");
    }

}


-(void)showTransType:(NSIndexPath *)indexPath {
    NBAnimalPickerViewController * animalCtrl=[[NBAnimalPickerViewController alloc]init];
    animalCtrl.parentIndexpath=indexPath;
    animalCtrl.modalDelegate=self;
    animalCtrl.backgroundcolor=self.backgroundcolor;
    [self.navigationController pushViewController:animalCtrl animated:YES];
}

#pragma mark-
#pragma mark-nbmodalviewdelegate
-(void)modelview:(id)controller data:(id)data{
    UIViewController *pushedCtrl=(UIViewController *)controller;
    [pushedCtrl.navigationController popViewControllerAnimated:YES];
    NSDictionary *dic=(NSDictionary*)data;
    MWKeyValue *curitm=(MWKeyValue*)[dic objectForKey:@"kSelectValue"];
    NSIndexPath *curindexpath=(NSIndexPath*)[dic objectForKey:@"kParentIndexpath"];
    MWKeyValue*kvItm=(MWKeyValue*)[(NSMutableArray*)[(NSMutableDictionary*)[self.dataSource objectAtIndex:curindexpath.section] objectForKey:@"ITEM"] objectAtIndex:curindexpath.row];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:curindexpath];
    if ([curitm.code isEqualToString:@"kCATransitionFade"]) {
        kvItm.desc=NSLocalizedString(@"NB_FADE_ANIMATION", @"fade");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_FADE_ANIMATION", @"fade")];
    }else if([curitm.code isEqualToString:@"kCATransitionPush"]){
        kvItm.desc=NSLocalizedString(@"NB_PUSH_ANIMATION", @"PUSH");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_PUSH_ANIMATION", @"PUSH")];
    }else if([curitm.code isEqualToString:@"kCATransitionReveal"]){
        kvItm.desc=NSLocalizedString(@"NB_REVEAL_ANIMATION", @"REVEAL");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_REVEAL_ANIMATION", @"REVEAL")];

    }else if([curitm.code isEqualToString:@"kCATransitionMoveIn"]){
        kvItm.desc=NSLocalizedString(@"NB_MOVEIN_ANIMATION", @"MOVEIN");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_MOVEIN_ANIMATION", @"MOVEIN")];
    }
    else if([curitm.code isEqualToString:@"cube"]){
        kvItm.desc=NSLocalizedString(@"NB_CUBE_ANIMATION", @"CUBE");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_CUBE_ANIMATION", @"CUBE")];
    }
    else if([curitm.code isEqualToString:@"suckEffect"]){
        kvItm.desc=NSLocalizedString(@"NB_SUCK_ANIMATION", @"SUCK");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_SUCK_ANIMATION", @"SUCK")];
    }else if([curitm.code isEqualToString:@"oglFlip"]){
        kvItm.desc=NSLocalizedString(@"NB_FLIP_ANIMATION", @"FLIP");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_FLIP_ANIMATION", @"FLIP")];
    }
    else if([curitm.code isEqualToString:@"rippleEffect"]){
        kvItm.desc=NSLocalizedString(@"NB_RIPPLE_ANIMATION", @"RIPPLE");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_RIPPLE_ANIMATION", @"RIPPLE")];

    }
    
    else if([curitm.code isEqualToString:@"pageCurl"]){
        kvItm.desc=NSLocalizedString(@"NB_PAGEUP_ANIMATION", @"PAGEUP");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_PAGEUP_ANIMATION", @"PAGEUP")];
    }
    
    else if([curitm.code isEqualToString:@"pageUnCurl"]){
        kvItm.desc=NSLocalizedString(@"NB_PAGEDWN_ANIMATION", @"PAGEDOWN");
        [cell.detailTextLabel setText:NSLocalizedString(@"NB_PAGEDWN_ANIMATION", @"PAGEDOWN")];
    }

}

-(NSString*)returnTransModeName:(NSString*)type{
    NSString *transMode=@"";
    if ([type isEqualToString:@"kCATransitionFade"]) {
        transMode=NSLocalizedString(@"NB_FADE_ANIMATION", @"fade");
    }else if([type isEqualToString:@"kCATransitionPush"]){
        transMode=NSLocalizedString(@"NB_PUSH_ANIMATION", @"PUSH");
    }else if([type isEqualToString:@"kCATransitionReveal"]){
        transMode=NSLocalizedString(@"NB_REVEAL_ANIMATION", @"REVEAL");        
    }else if([type isEqualToString:@"kCATransitionMoveIn"]){
        transMode=NSLocalizedString(@"NB_MOVEIN_ANIMATION", @"MOVEIN");
    }
    else if([type isEqualToString:@"cube"]){
        transMode=NSLocalizedString(@"NB_CUBE_ANIMATION", @"CUBE");
    }
    else if([type isEqualToString:@"suckEffect"]){
        transMode=NSLocalizedString(@"NB_SUCK_ANIMATION", @"SUCK");
    }else if([type isEqualToString:@"oglFlip"]){
        transMode=NSLocalizedString(@"NB_FLIP_ANIMATION", @"FLIP");
    }
    else if([type isEqualToString:@"rippleEffect"]){
        transMode=NSLocalizedString(@"NB_RIPPLE_ANIMATION", @"RIPPLE");        
    }
    
    else if([type isEqualToString:@"pageCurl"]){
        transMode=NSLocalizedString(@"NB_PAGEUP_ANIMATION", @"PAGEUP");
    }
    
    else if([type isEqualToString:@"pageUnCurl"]){
        transMode=NSLocalizedString(@"NB_PAGEDWN_ANIMATION", @"PAGEDOWN");
    }
    return transMode;
}

#pragma mark-
#pragma mark-nbbindingsourcedelegate
-(void)bindingsource:(id)target sender:(id)sender data:(id)data{
    NSIndexPath *indexpath=(NSIndexPath*)data;
    NSMutableDictionary *dic=[self.dataSource objectAtIndex:indexpath.section];
    NSMutableArray *arylst=(NSMutableArray*)[dic objectForKey:@"ITEM"];
    MWKeyValue *curitm=(MWKeyValue*)[arylst objectAtIndex:indexpath.row];
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    if ([target isKindOfClass:[MWNumIncreaseCell class]]) {
        UIStepper *stepper=(UIStepper*)sender;
        curitm.desc=[NSString stringWithFormat:@"%d %@",(int)stepper.value,NSLocalizedString(@"NB_SECONDS_LABEL", @"SECONDS")];
        MWNumIncreaseCell *cell=(MWNumIncreaseCell*)[self.tableView cellForRowAtIndexPath:indexpath];
        [cell.lbDesc setText:curitm.desc];
        [ds setInteger:stepper.value forKey:@"KINTERVAL"];
        [ds synchronize];
    }else if ([target isKindOfClass:[MWSwitchCell class]]){
        UISwitch *sWitch=(UISwitch*)sender;
        if ([curitm.code isEqualToString:@"KPLAYMUSIC"]) {
            if (sWitch.on) {
                curitm.desc=@"MUSICON";
            }else{
                curitm.desc=@"MUSICOFF";
            }
            [ds setValue:curitm.desc forKey:@"KPLAYMUSIC"];
            [ds synchronize];
        }else if ([curitm.code isEqualToString:@"KREPEAT"]){
            if (sWitch.on) {
                curitm.desc=@"REPEATON";
            }else{
                curitm.desc=@"REPEATOFF";
            }
            [ds setValue:curitm.desc forKey:@"KREPEAT"];
            [ds synchronize];
        }
    }
}
#pragma mark-
#pragma mark- MPMediaPickerControllerDelegate

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    NSLog(@"Media Picker returned");
    MPMediaItem *selectedSong = [[mediaItemCollection items] objectAtIndex:0];
   // NSString *title=[selectedSong valueForProperty: MPMediaItemPropertyTitle];
    //NSString *singerManNM=[selectedSong valueForKey:MPMediaItemPropertyPodcastTitle];
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    NSURL *url = [selectedSong valueForProperty:MPMediaItemPropertyAssetURL];
    NSString *urlString=[url absoluteString];
    NSString *title=[selectedSong valueForProperty: MPMediaItemPropertyTitle];
    [ds setValue:title forKey:@"kAudioTitle"];
    [ds setValue:urlString forKey:@"kAudioUrl"];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:_curIndexpath];
    [cell.detailTextLabel setText:title];
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
}
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSLog(@"Media Picker was cancelled");
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
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
