//
//  BackgroungColorSettingController.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "BackgroundColorSettingViewController.h"
#import "previousButtonView.h"
#import "backgroundColorSettingTableViewCell.h"
#import "DefaultColorManager.h"

@interface BackgroundColorSettingViewController () <UITableViewDelegate, UITableViewDataSource>{
    float screenWidthRatio;
    previousButtonView *previousButton;
    UITableView *colorSettingTable;
    DefaultColorManager *defaultManager;
}
@property (nonatomic, strong) NSLayoutConstraint *previousBtnUpperBond, *previousBtnLowerBond, *previousBtnLeftBond, *previousBtnRightBond;

@property (nonatomic, strong) NSLayoutConstraint *bgColorSettingUpperBond, *bgColorSettingLowerBond, *bgColorSettingLeftBond, *bgColorSettingRightBond;

@end

@implementation BackgroundColorSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUIView];
    [self calculateWidthRatio];
    [self configurePreviousPageBtn];
    [self setPreviousPageBtn];
    [self previousPageButtonBlock];
    [self configureColorSettingTableView];
    [self setColorSettingTableView];
    
   
}

-(void)initUIView {
    defaultManager = [DefaultColorManager new];
    if([defaultManager checkDefaultColor]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else {
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)calculateWidthRatio {
    screenWidthRatio = [UIScreen mainScreen].bounds.size.width / 375;
}

#pragma mark -previousPageBtn
-(void)configurePreviousPageBtn {
    previousButton = [[previousButtonView alloc]initWithFrame:CGRectZero];
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: previousButton];
}

-(void)setPreviousPageBtn {
    self.previousBtnUpperBond = [previousButton.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:70];
    self.previousBtnLowerBond = [previousButton.heightAnchor constraintEqualToConstant:50];
    self.previousBtnLeftBond = [previousButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:15];
    self.previousBtnRightBond = [previousButton.widthAnchor constraintEqualToConstant:50];
    self.previousBtnUpperBond.active = YES;
    self.previousBtnLowerBond.active = YES;
    self.previousBtnLeftBond.active = YES;
    self.previousBtnRightBond.active = YES;
}

-(void)previousPageButtonBlock {
    __weak typeof (self) weakSelf = self;
    previousButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickPreviousPageButton];
    };
}

-(void)onClickPreviousPageButton {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -configure colorSetting tableView
-(void)configureColorSettingTableView {
    [colorSettingTable removeFromSuperview];
    colorSettingTable = [[UITableView alloc]initWithFrame:CGRectZero];
    colorSettingTable.delegate = self;
    colorSettingTable.dataSource = self;
    colorSettingTable.estimatedRowHeight = 33;
    [colorSettingTable registerClass:backgroundColorSettingTableViewCell.class forCellReuseIdentifier:@"ColorSettingCell"];
    colorSettingTable.backgroundColor = [UIColor whiteColor];
    colorSettingTable.scrollEnabled = NO;
    [self.view addSubview: colorSettingTable];
    [self setColorSettingTableView];
}

-(void)setColorSettingTableView {
    colorSettingTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgColorSettingUpperBond = [colorSettingTable.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:150];
    self.bgColorSettingUpperBond.active = YES;
    self.bgColorSettingLowerBond = [colorSettingTable.heightAnchor constraintEqualToConstant:72];
    self.bgColorSettingLowerBond.active = YES;
    self.bgColorSettingLeftBond = [colorSettingTable.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    self.bgColorSettingLeftBond.active = YES;
    self.bgColorSettingRightBond = [colorSettingTable.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    self.bgColorSettingRightBond.active = YES;
}

#pragma mark -colorSetting tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ColorSettingCell";
    backgroundColorSettingTableViewCell *cell = (backgroundColorSettingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    BOOL currentColorSettingIsLight = [defaultManager checkDefaultColor];
    
    if(indexPath.row == 0) {
        cell.colorName.text = [defaultManager lightColor];
        if(currentColorSettingIsLight == YES) {
            cell.colorName.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.colorName.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else {
        cell.colorName.text = [defaultManager darkColor];
        if(currentColorSettingIsLight == YES) {
            cell.colorName.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            cell.colorName.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }
    return cell;
}

#pragma mark -click cell, reload and update views
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        [defaultManager setDefaultColor:@"淺色模式"];
        self.view.backgroundColor = [UIColor whiteColor];
    }else {
        [defaultManager setDefaultColor:@"深色模式"];
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    [previousButton changeDefaultColor];
    [self->colorSettingTable beginUpdates];
    [self->colorSettingTable reloadData];
    [self->colorSettingTable endUpdates];
}


@end
