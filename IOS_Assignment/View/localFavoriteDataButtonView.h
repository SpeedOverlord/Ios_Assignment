//
//  localFavoriteDataButtonView.h
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/20.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface localFavoriteDataButtonView : UIView

@property (nonatomic, copy) void (^buttonAction)(UIButton *);

-(void)changeDefaultColor;
-(void)setButtonTitle;

@end

NS_ASSUME_NONNULL_END
