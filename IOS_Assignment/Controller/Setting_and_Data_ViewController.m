//
//  Setting_and_Data_ViewController.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/28.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "Setting_and_Data_ViewController.h"
#import "backgroundColorButtonView.h"
#import "BackgroundColorSettingViewController.h"
#import "DefaultColorManager.h"
#import "localFavoriteDataButtonView.h"
#import "LocalFavoriteDataViewController.h"
#import "Apple_iTunesButtonView.h"
#import "AppleITunesViewController.h"

@interface Setting_and_Data_ViewController () {
    UITabBarItem *tabBarItem2;
    float screenWidthRatio;
    backgroundColorButtonView *backgroundColorButton;
    localFavoriteDataButtonView *localFavoriteButton;
    DefaultColorManager *defaultColorManager;
    Apple_iTunesButtonView *appleITunesButton;
}

@property (nonatomic, strong) NSLayoutConstraint *bgColorSettingUpperBond, *bgColorSettingLowerBond, *bgColorSettingLeftBond, *bgColorSettingRightBond;
@property (nonatomic, strong) NSLayoutConstraint *LocalFavoriteBtnUpperBond, *LocalFavoriteBtnLowerBond, *LocalFavoriteBtnLeftBond, *LocalFavoriteBtnRightBond;
@property (nonatomic, strong) NSLayoutConstraint *appleITunesUpper, *appleITunesLower, *appleITunesLeft, *appleITunesRight;

@end

@implementation Setting_and_Data_ViewController

-(void)viewWillAppear:(BOOL)animated {
    [self checkDefaultColorSetting];
    [self setLocalFavoriteButtonTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calculateWidthRatio];
    [self configureBGColorSettingButton];
    [self setBGColorSettingButton];
    [self bgColorButtonBlock];
    [self configureLocalFavoriteButton];
    [self setLocalFavoriteButton];
    [self favoriteButtonBlock];
    [self configureAppleITunesButton];
    [self setAppleITunesButton];
    [self appleITunesButtonBlock];
}

-(void)checkDefaultColorSetting {
    defaultColorManager = [DefaultColorManager new];
    if([defaultColorManager checkDefaultColor]) {
        self.view.backgroundColor = [UIColor whiteColor];
        [backgroundColorButton changeDefaultColor];
        [localFavoriteButton changeDefaultColor];
        [appleITunesButton changeDefaultColor];
    }else {
        self.view.backgroundColor = [UIColor lightGrayColor];
        [backgroundColorButton changeDefaultColor];
        [localFavoriteButton changeDefaultColor];
        [appleITunesButton changeDefaultColor];
    }
}

-(void)setLocalFavoriteButtonTitle {
    [localFavoriteButton setButtonTitle];
}

- (void)calculateWidthRatio {
    screenWidthRatio = [UIScreen mainScreen].bounds.size.width / 375;
}

#pragma mark -bgColorSettingBtn
-(void)configureBGColorSettingButton {
    backgroundColorButton = [[backgroundColorButtonView alloc]initWithFrame:CGRectZero];
    backgroundColorButton.backgroundColor = [UIColor blackColor];
    backgroundColorButton.clipsToBounds = YES;
    backgroundColorButton.layer.cornerRadius = 10;
    backgroundColorButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: backgroundColorButton];
}

-(void)setBGColorSettingButton {
    self.bgColorSettingUpperBond = [backgroundColorButton.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:100];
    self.bgColorSettingLowerBond = [backgroundColorButton.heightAnchor constraintEqualToConstant:40];
    self.bgColorSettingLeftBond = [backgroundColorButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:5];
    self.bgColorSettingRightBond = [backgroundColorButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5];
    self.bgColorSettingUpperBond.active = YES;
    self.bgColorSettingLowerBond.active = YES;
    self.bgColorSettingLeftBond.active = YES;
    self.bgColorSettingRightBond.active = YES;
}

-(void)bgColorButtonBlock {
    __weak typeof (self) weakSelf = self;
    backgroundColorButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickBGColorSettingButton];
    };
}

-(void)onClickBGColorSettingButton {
    UIViewController *bgColorSettingBtn;
    bgColorSettingBtn = [[BackgroundColorSettingViewController alloc]init];
    bgColorSettingBtn.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:bgColorSettingBtn animated:true completion:^{}];
}

#pragma mark -localFavoriteButton
-(void)configureLocalFavoriteButton {
    localFavoriteButton = [[localFavoriteDataButtonView alloc]initWithFrame:CGRectZero];
    localFavoriteButton.backgroundColor = [UIColor blackColor];
    localFavoriteButton.clipsToBounds = YES;
    localFavoriteButton.layer.cornerRadius = 10;
    localFavoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: localFavoriteButton];
}

-(void)setLocalFavoriteButton {
    self.LocalFavoriteBtnUpperBond = [localFavoriteButton.topAnchor constraintEqualToAnchor: backgroundColorButton.bottomAnchor constant:10];
       self.LocalFavoriteBtnLowerBond = [localFavoriteButton.heightAnchor constraintEqualToConstant:40];
    self.LocalFavoriteBtnLeftBond = [localFavoriteButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:5];
       self.LocalFavoriteBtnRightBond = [localFavoriteButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5];
       self.LocalFavoriteBtnUpperBond.active = YES;
       self.LocalFavoriteBtnLowerBond.active = YES;
       self.LocalFavoriteBtnLeftBond.active = YES;
       self.LocalFavoriteBtnRightBond.active = YES;
}

-(void)favoriteButtonBlock {
    __weak typeof (self) weakSelf = self;
    localFavoriteButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickLocalFavoriteButton];
    };
}

-(void)onClickLocalFavoriteButton {
    UIViewController *localFavoriteBtn;
       localFavoriteBtn = [[LocalFavoriteDataViewController alloc]init];
       localFavoriteBtn.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:localFavoriteBtn animated:true completion:^{}];
}

#pragma mark -Apple iTunes button
-(void)configureAppleITunesButton {
    appleITunesButton = [[Apple_iTunesButtonView alloc]initWithFrame:CGRectZero];
    appleITunesButton.backgroundColor = [UIColor blackColor];
    appleITunesButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: appleITunesButton];
}

-(void)setAppleITunesButton {
    self.appleITunesUpper = [appleITunesButton.topAnchor constraintEqualToAnchor: localFavoriteButton.bottomAnchor constant:10];
    self.appleITunesLower = [appleITunesButton.heightAnchor constraintEqualToConstant:20];
    self.appleITunesLeft = [appleITunesButton.widthAnchor constraintEqualToConstant:150];
    self.appleITunesRight = [appleITunesButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5];
    self.appleITunesUpper.active = YES;
    self.appleITunesLower.active = YES;
    self.appleITunesLeft.active = YES;
    self.appleITunesRight.active = YES;
}

-(void)appleITunesButtonBlock {
    __weak typeof (self) weakSelf = self;
    appleITunesButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickAppleITunesButton];
    };
}

-(void)onClickAppleITunesButton {
    UIViewController *appleITunesBtn;
       appleITunesBtn = [[AppleITunesViewController alloc]init];
       [self presentViewController:appleITunesBtn animated:true completion:^{}];
}

@end
