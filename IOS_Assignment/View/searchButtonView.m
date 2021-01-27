//
//  searchButtonView.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/30.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "searchButtonView.h"

@interface searchButtonView(){
}
@property (nonatomic, strong)NSLayoutConstraint *searchButtonUpperBond, *searchButtonLowerBond, *searchButtonLeftBond, *searchButtonRightBond;
@end

@implementation searchButtonView {
    UIButton *searchButton;
    UIImage *buttonImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        searchButton = [[UIButton alloc]initWithFrame:CGRectZero];
        buttonImage = [UIImage imageNamed:@"magnifier_1x.png"];
        [searchButton setImage:buttonImage forState:UIControlStateNormal];
        searchButton.backgroundColor = [UIColor whiteColor];
        [self addSubview: searchButton];
        searchButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.searchButtonUpperBond = [searchButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:1];
        self.searchButtonUpperBond.active = YES;
        self.searchButtonLowerBond = [searchButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-1];
        self.searchButtonLowerBond.active = YES;
        self.searchButtonLeftBond = [searchButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:1];
        self.searchButtonLeftBond.active = YES;
        self.searchButtonRightBond = [searchButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-1];
        self.searchButtonRightBond.active = YES;
        [searchButton addTarget:self action:@selector(onClickSearchButton:) forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -searchButtonView Action
-(IBAction)onClickSearchButton:(UIButton *)sender{
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}

@end
