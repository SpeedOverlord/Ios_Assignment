//
//  InputView.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/28.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "InputView.h"

@interface InputView() <UITextFieldDelegate> {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}
@property (nonatomic, strong) NSLayoutConstraint *textFieldUpperBond, *textFieldLowerBond, *textFieldLeftBond, *textFieldRightBond;
@end


@implementation InputView {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField = [[UITextField alloc]initWithFrame:CGRectZero];
//        self.textField.backgroundColor = [UIColor lightGrayColor];
        [self changeDefaultColor];
        [self addSubview: self.textField];
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        self.textFieldUpperBond = [self.textField.topAnchor constraintEqualToAnchor:self.topAnchor constant:2];
        self.textFieldUpperBond.active = YES;
        self.textFieldLowerBond = [self.textField.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-2];
        self.textFieldLowerBond.active = YES;
        self.textFieldLeftBond = [self.textField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:2];
        self.textFieldLeftBond.active = YES;
        self.textFieldRightBond = [self.textField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-2];
        self.textFieldRightBond.active = YES;
    }
    return self;
}

-(void)changeDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        self.textField.backgroundColor = [UIColor lightGrayColor];
    }else {
        self.textField.backgroundColor = [UIColor whiteColor];
    }
}

-(void)resignTextField {
    [self.textField resignFirstResponder];
}



@end
