//
//  Apple_iTunesButtonView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "Apple_iTunesButtonView.h"
@interface Apple_iTunesButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}
@property (nonatomic, strong)NSLayoutConstraint *iTunesUpper, *iTunesLower, *iTunesLeft, *iTunesRight;
@end

@implementation Apple_iTunesButtonView {
    UIButton* iTunesButton;
    NSString* LocalFListButtonTitle;
    NSString* lightColor;
    NSString* darkColor;
    NSInteger favoriteNumber;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    LocalFListButtonTitle = [NSString new];
    if(self) {
        iTunesButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [iTunesButton setTitle:@"關於 Apple iTunes" forState:UIControlStateNormal];
        [iTunesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self changeDefaultColor];
        [self addSubview:iTunesButton];
        iTunesButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.iTunesUpper = [iTunesButton.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.iTunesLower = [iTunesButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
        self.iTunesLeft = [iTunesButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
        self.iTunesRight = [iTunesButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
        self.iTunesUpper.active = YES;
        self.iTunesLower.active = YES;
        self.iTunesLeft.active = YES;
        self.iTunesRight.active = YES;
        [iTunesButton addTarget:self action:@selector(onclickAppleITunesButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)changeDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        iTunesButton.backgroundColor = [UIColor whiteColor];
    }else {
        iTunesButton.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark -localFListButton Action
-(IBAction)onclickAppleITunesButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}


@end
