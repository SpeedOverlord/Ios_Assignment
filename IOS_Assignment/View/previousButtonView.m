//
//  previousButtonView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "previousButtonView.h"

@interface previousButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}

@property (nonatomic, strong)NSLayoutConstraint *previousBtnUpperBond, *previousBtnLowerBond, *previousBtnLeftBond, *previousBtnRightBond;


@end


@implementation previousButtonView {
    UIButton *previousPageButton;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        previousPageButton = [[UIButton alloc]initWithFrame:CGRectZero];
       
        UIImage *previousBtnImage = [UIImage imageNamed:@"BackButton"];
        [previousPageButton setImage:previousBtnImage forState:UIControlStateNormal];
        [self changeDefaultColor];
        [self addSubview: previousPageButton];
        previousPageButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.previousBtnUpperBond = [previousPageButton.topAnchor constraintEqualToAnchor:self.topAnchor constant: 0];
        self.previousBtnLowerBond =[previousPageButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
        self.previousBtnLeftBond = [previousPageButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0];
        self.previousBtnRightBond = [previousPageButton.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:0];
        self.previousBtnUpperBond.active = YES;
        self.previousBtnLowerBond.active = YES;
        self.previousBtnLeftBond.active = YES;
        self.previousBtnRightBond.active = YES;
        [previousPageButton addTarget:self action:@selector(onclickPreviousPageButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)changeDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        previousPageButton.backgroundColor = [UIColor whiteColor];
    }else {
        previousPageButton.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark -bgColorButton Action
-(IBAction)onclickPreviousPageButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}


@end
