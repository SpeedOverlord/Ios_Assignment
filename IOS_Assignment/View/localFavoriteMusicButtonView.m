//
//  localFavoriteMusicButtonView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "localFavoriteMusicButtonView.h"

@interface localFavoriteMusicButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}
@property (nonatomic, strong)NSLayoutConstraint *localFavoriteMUpper, *localFavoriteMLower, *localFavoriteMLeft, *localFavoriteMRight;


@end

@implementation localFavoriteMusicButtonView {
    UIButton* LocalFavoriteMusicButton;
    NSString* lightColor;
    NSString* darkColor;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        LocalFavoriteMusicButton = [[UIButton alloc]initWithFrame:CGRectZero];
        LocalFavoriteMusicButton.clipsToBounds = YES;
        LocalFavoriteMusicButton.layer.cornerRadius = 5;
        LocalFavoriteMusicButton.layer.borderWidth = 2;
        LocalFavoriteMusicButton.layer.borderColor = [UIColor blackColor].CGColor;
        [LocalFavoriteMusicButton setTitle:@"音樂" forState:UIControlStateNormal];
        LocalFavoriteMusicButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
        [self changeDefaultColor];
        [self addSubview: LocalFavoriteMusicButton];
        LocalFavoriteMusicButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.localFavoriteMUpper = [LocalFavoriteMusicButton.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.localFavoriteMLower = [LocalFavoriteMusicButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
        self.localFavoriteMLeft = [LocalFavoriteMusicButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
        self.localFavoriteMRight = [LocalFavoriteMusicButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
        self.localFavoriteMUpper.active = YES;
        self.localFavoriteMLower.active = YES;
        self.localFavoriteMLeft.active = YES;
        self.localFavoriteMRight.active = YES;
        [LocalFavoriteMusicButton addTarget:self action:@selector(onclickLocalFavoriteMusicButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)changeDefaultColor {
    [LocalFavoriteMusicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        LocalFavoriteMusicButton.backgroundColor = [UIColor lightGrayColor];
    }else {
        LocalFavoriteMusicButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark -localFavoriteMovieButton Action
-(IBAction)onclickLocalFavoriteMusicButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}

@end
