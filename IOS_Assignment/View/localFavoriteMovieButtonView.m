//
//  localFavoriteMovieButtonView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "localFavoriteMovieButtonView.h"

@interface localFavoriteMovieButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}
@property (nonatomic, strong)NSLayoutConstraint *localFavoriteMUpper, *localFavoriteMLower, *localFavoriteMLeft, *localFavoriteMRight;
@end

@implementation localFavoriteMovieButtonView {
    UIButton* LocalFavoriteMovieButton;
    NSString* lightColor;
    NSString* darkColor;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        LocalFavoriteMovieButton = [[UIButton alloc] initWithFrame:CGRectZero];
        LocalFavoriteMovieButton.clipsToBounds = YES;
        LocalFavoriteMovieButton.layer.cornerRadius = 5;
        LocalFavoriteMovieButton.layer.borderWidth = 2;
        LocalFavoriteMovieButton.layer.borderColor = [UIColor blackColor].CGColor;
        [LocalFavoriteMovieButton setTitle:@"電影" forState:UIControlStateNormal];
        LocalFavoriteMovieButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
        [self changeDefaultColor];
        [self addSubview: LocalFavoriteMovieButton];
        LocalFavoriteMovieButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.localFavoriteMUpper = [LocalFavoriteMovieButton.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.localFavoriteMLower = [LocalFavoriteMovieButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
        self.localFavoriteMLeft = [LocalFavoriteMovieButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
        self.localFavoriteMRight = [LocalFavoriteMovieButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
        self.localFavoriteMUpper.active = YES;
        self.localFavoriteMLower.active = YES;
        self.localFavoriteMLeft.active = YES;
        self.localFavoriteMRight.active = YES;
        [LocalFavoriteMovieButton addTarget:self action:@selector(onclickLocalFavoriteMovieButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)changeDefaultColor {
    [LocalFavoriteMovieButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        LocalFavoriteMovieButton.backgroundColor = [UIColor lightGrayColor];
    }else {
        LocalFavoriteMovieButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark -localFavoriteMovieButton Action
-(IBAction)onclickLocalFavoriteMovieButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}

@end
