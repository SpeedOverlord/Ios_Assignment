//
//  backgroundColorView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "backgroundColorButtonView.h"

@interface backgroundColorButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}

@property (nonatomic, strong)NSLayoutConstraint *bgColorUpperBond, *bgColorLowerBond, *bgColorLeftBond, *bgColorRightBond;

@end


@implementation backgroundColorButtonView {
    UIButton *bgColorButton;
    NSString *bgColorButtonTitle;
    NSString *lightColor;
    NSString *darkColor;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    lightColor = @"淺色模式";
    darkColor = @"深色模式";
    bgColorButtonTitle = [[NSString alloc]init];
    defaultColorData = [NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if (self) {
        bgColorButton = [[UIButton alloc]initWithFrame:CGRectZero];
        bgColorButton.clipsToBounds = YES;
        bgColorButton.layer.cornerRadius = 10;
        if(defaultColor == nil || [defaultColor isEqualToString:lightColor]) {
            bgColorButtonTitle = [@"主題顏色:                               " stringByAppendingString: lightColor];
        }else {
            bgColorButtonTitle = [@"主題顏色:                               " stringByAppendingString: darkColor];
        }
        
        
        [bgColorButton setTitle:bgColorButtonTitle forState:UIControlStateNormal];
        [self changeDefaultColor];
        [bgColorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview: bgColorButton];
        bgColorButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.bgColorUpperBond = [bgColorButton.topAnchor constraintEqualToAnchor:self.topAnchor constant: 3];
        self.bgColorLowerBond =[bgColorButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-3];
        self.bgColorLeftBond = [bgColorButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:3];
        self.bgColorRightBond = [bgColorButton.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-3];
        self.bgColorUpperBond.active = YES;
        self.bgColorLowerBond.active = YES;
        self.bgColorLeftBond.active = YES;
        self.bgColorRightBond.active = YES;
        [bgColorButton addTarget:self action:@selector(onclickBGColorButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)changeDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        bgColorButton.backgroundColor = [UIColor lightGrayColor];
         bgColorButtonTitle = [@"主題顏色:                               " stringByAppendingString: @"淺色模式"];
        [bgColorButton setTitle:bgColorButtonTitle forState:UIControlStateNormal];
    }else {
        bgColorButton.backgroundColor = [UIColor whiteColor];
        bgColorButtonTitle = [@"主題顏色:                               " stringByAppendingString: @"深色模式"];
        [bgColorButton setTitle:bgColorButtonTitle forState:UIControlStateNormal];
    }
    
}

#pragma mark -bgColorButton Action
-(IBAction)onclickBGColorButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}

@end
