//
//  MCLeftSortsViewController.h
//  LeftSlide
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 machao. All rights reserved.
//

#import "MCLeftSortsViewController.h"
#import "MCLeftSliderManager.h"
#import "MCOtherViewController.h"
#import "DKNightVersion.h"

@interface MCLeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation MCLeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.tableview.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableview.nightSeparatorColor = UIColorFromRGB(0x313131);
//        navigationLabel.nightTextColor = [UIColor whiteColor];
        self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
        self.navigationItem.leftBarButtonItem.nightTintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.nightTintColor = [UIColor whiteColor];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MCOtherViewController *vc = [[MCOtherViewController alloc] init];
//    vc.titleName =
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.titleName = cell.textLabel.text;
    [[MCLeftSliderManager sharedInstance].LeftSlideVC closeLeftView];//关闭左侧抽屉
    [[MCLeftSliderManager sharedInstance].mainNavigationController pushViewController:vc animated:NO];
//    if (indexPath.row == 0) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Bluetooth"]];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
//    UISwitch *lightButton = [UISwitch new];
//    
//    [lightButton addTarget:self action:@selector(changeLight) forControlEvents:UIControlEventTouchUpInside];
//    lightButton.frame = CGRectMake(50, 50, 200, 44);
//    
//    [view addSubview:lightButton];
    return view;
}
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 180;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    UISwitch *lightButton = [UISwitch new];
    
    [lightButton addTarget:self action:@selector(changeLight) forControlEvents:UIControlEventTouchUpInside];
    lightButton.frame = CGRectMake(50, 50, 200, 44);
    
    [view addSubview:lightButton];
    return view;
}

-(void)changeLight{
    NSLog(@"daindad");
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
}

@end
