//
//  backgroundColorSettingTableViewCell.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "backgroundColorSettingTableViewCell.h"
#import "DefaultColorManager.h"
@interface backgroundColorSettingTableViewCell() {
    DefaultColorManager *defaultColorManager;
}

@property (nonatomic, strong)NSLayoutConstraint *colorNameUpperBond, *colorNameLowerBond, *colorNameLeftBond, *colorNameRightBond;

@end

@implementation backgroundColorSettingTableViewCell {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}
@synthesize colorName = _colorName;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self configureCell];
    }
    return self;
}

-(void)configureCell {
    self.colorName = [[UILabel alloc]initWithFrame:CGRectZero];
    [self setFontAndColor];
    [self addSubview: self.colorName];
    [self setColorName];
}

-(void)setFontAndColor {
    defaultColorManager = [DefaultColorManager new];
    BOOL settingColor = [defaultColorManager checkDefaultColor];
    if(settingColor == YES) {
        self.colorName.textColor = [UIColor blackColor];
    }else {
        self.colorName.textColor = [UIColor whiteColor];
    }
    self.colorName.font = [UIFont fontWithName:@"Arial" size:33];
}

-(void)setColorName {
    self.colorName.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorNameUpperBond = [self.colorName.topAnchor constraintEqualToAnchor: self.topAnchor];
    self.colorNameUpperBond.active = YES;
    self.colorNameLowerBond = [self.colorName.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    self.colorNameLowerBond.active = YES;
    self.colorNameLeftBond = [self.colorName.leadingAnchor constraintEqualToAnchor: self.leadingAnchor];
    self.colorNameLeftBond.active = YES;
    self.colorNameRightBond = [self.colorName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    self.colorNameRightBond.active = YES;
    self.colorName.numberOfLines = 0;
    [self.colorName sizeToFit];
}

@end
