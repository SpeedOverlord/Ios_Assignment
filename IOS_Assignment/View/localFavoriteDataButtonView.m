//
//  localFavoriteDataButtonView.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/20.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "localFavoriteDataButtonView.h"
#import "FavoriteManager.h"
@interface localFavoriteDataButtonView() {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
    FavoriteManager *favoriteManager;
}
@property (nonatomic, strong)NSLayoutConstraint *LocalFListUpperBond, *LocalFListLowerBond, *LocalFListLeftBond, *LocalFListRightBond;
@end

@implementation localFavoriteDataButtonView {
    UIButton* LocalFListButton;
    NSString* LocalFListButtonTitle;
    NSString* lightColor;
    NSString* darkColor;
    NSInteger favoriteNumber;
    
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
    favoriteManager = [FavoriteManager new];
    LocalFListButtonTitle = [NSString new];
    if(self) {
        LocalFListButton = [[UIButton alloc]initWithFrame:CGRectZero];
        LocalFListButton.clipsToBounds = YES;
        LocalFListButton.layer.cornerRadius = 10;
        [self setButtonTitle];
        
        [self changeDefaultColor];
        [self addSubview:LocalFListButton];
        LocalFListButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.LocalFListUpperBond = [LocalFListButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:3];
        self.LocalFListLowerBond = [LocalFListButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-3];
        self.LocalFListLeftBond = [LocalFListButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:3];
        self.LocalFListRightBond = [LocalFListButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-3];
        self.LocalFListUpperBond.active = YES;
        self.LocalFListLowerBond.active = YES;
        self.LocalFListLeftBond.active = YES;
        self.LocalFListRightBond.active = YES;
        [LocalFListButton addTarget:self action:@selector(onclickLocalFavoriteListButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setButtonTitle {
    favoriteNumber = [favoriteManager getFavoriteNumber];
    NSString* favoriteNumberString = [NSString stringWithFormat:@"%ld", (long)favoriteNumber];
    LocalFListButtonTitle = [@"收藏數量:                                        " stringByAppendingString: favoriteNumberString];
    LocalFListButtonTitle = [
                             LocalFListButtonTitle stringByAppendingString:@"個"];
    [LocalFListButton setTitle:LocalFListButtonTitle forState:UIControlStateNormal];
    [LocalFListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(void)changeDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if([defaultColor isEqualToString: @"淺色模式"]) {
        LocalFListButton.backgroundColor = [UIColor lightGrayColor];
    }else {
        LocalFListButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark -localFListButton Action
-(IBAction)onclickLocalFavoriteListButton:(UIButton *)sender {
    if (self.buttonAction) {
        self.buttonAction(sender);
    }
}



@end
